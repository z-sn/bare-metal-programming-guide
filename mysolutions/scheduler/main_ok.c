#include "hal.h"

// Task Control Block definition
#define STACK_SIZE 1024 * 2 // 2 KB

struct TCB {
  uint32_t *sp;
  uint32_t *task_function;
  uint32_t task_id;
  uint32_t stack[STACK_SIZE / sizeof(uint32_t)];
};

struct task_manager{
  volatile struct TCB *current_task;
  volatile struct TCB *next_task;
  volatile uint32_t *current_task_sp;
  volatile uint32_t *next_task_sp;
  struct TCB *tasks[10];
  int num_task;
};

static struct task_manager tm = {
  .num_task = 0
};

struct TCB tcb_scheduler;
struct TCB tcb_task1;
struct TCB tcb_task2;

static volatile uint32_t current_task_id;
static volatile uint32_t s_pendsv_count;
static uint32_t *current_task_sp;
static uint32_t *next_task_sp;

// Scheduler helper functions
void create_task(struct TCB *tcb)
{
  uint32_t *sp = &(tcb->stack[STACK_SIZE / sizeof(uint32_t)]);
  *(--sp) = (1UL << 24); // xPSR: Set the Thumb bit (T bit) to indicate a valid state
  *(--sp) = (uint32_t)tcb->task_function; // R15 : PC
  *(--sp) = 0xFFFFFFFD; // R14 : LR, Return using PSP
  *(--sp) = 0; // R12
  *(--sp) = 0; // R3
  *(--sp) = 0; // R2
  *(--sp) = 0; // R1
  *(--sp) = 0; // R0
  // Set R4-R11
  for (int i = 0; i < 8; i++) {
    *(--sp) = 0;
  }

  tcb->sp = sp;
  tm.tasks[tm.num_task++] = tcb;
}

static inline void reschedule(void) {
  if (tm.current_task == tm.tasks[0]) {
    tm.next_task = tm.tasks[1];
  } else {
    tm.next_task = tm.tasks[0];
  }
  /*
  if (current_task_id == tcb_task1.task_id) {
    tcb_task1.sp = current_task_sp;
    current_task_sp = tcb_task2.sp;
    next_task_sp = tcb_task2.sp;
    current_task_id = 2;
  } else {
    tcb_task2.sp = current_task_sp;
    current_task_sp = tcb_task1.sp;
    next_task_sp = tcb_task1.sp;
    current_task_id = 1;
  }
  */
}

void task1 (void) {
  int i = 0;
  while (1) {
    printf("This is task 1, %d\r\n", i++);
    spin(1000000); 
  }
}

void task2 (void) {
  int i = 10000000;
  while (1) {
    printf("This is task 2, %d\r\n", i--);
    spin(1000000); 
  }
}

void start_first_task() {
  tm.current_task = tm.tasks[0];
  // Set the PSP to the initial task's stack pointer and enable PSP
   __asm volatile ("MSR PSP, %0" : : "r" (tm.tasks[0]->sp) : "memory");
   __asm volatile ("MOV R0, #2"); // Set CONTROL register to use PSP in Thread mode
   __asm volatile ("MSR CONTROL, R0");

  __asm volatile (
  "LDR R0, [%[task], #0]      \n"
  "MSR PSP, R0                \n"
  "LDR R0, [%[task], #4]      \n"
  "BX R0                      \n"
    :
    : [task] "r" (tm.tasks[0])
    : "memory", "r0"
  );
}


#if 0
void PendSV_Handler(void) {
  s_pendsv_count++;
  // Context save
  __asm volatile (
  "MRS R0, PSP            \n"
  "STMDB R0!, {R4-R11}    \n"
  "STR R0, %0             \n" // Save updated PSP to current_task_sp
  : "=m" (current_task_sp)
  :
  : "memory", "r0"
  );

   if (current_task_id == tcb_task1.task_id) {
    tcb_task1.sp = current_task_sp;
    current_task_sp = tcb_task2.sp;
    next_task_sp = tcb_task2.sp;
    current_task_id = 2;
  } else {
    tcb_task2.sp = current_task_sp;
    current_task_sp = tcb_task1.sp;
    next_task_sp = tcb_task1.sp;
    current_task_id = 1;
  }

  // Switch to the next task
  __asm volatile (
  "LDR R0, %0     \n"
  "LDMIA R0!, {R4-R11}    \n"
  "MSR PSP, R0            \n"
    :
  : "m" (next_task_sp)
    : "memory", "r0"
  );
  __asm volatile("BX LR");

}
#else

void PendSV_Handler(void) {
  s_pendsv_count++;
  // Context save
  __asm volatile (
  "MRS R0, PSP            \n"
  "STMDB R0!, {R4-R11}    \n"
  "STR R0, %0             \n" // Save updated PSP to current_task_sp
  : "=m" (tm.current_task->sp)
  : 
  : "memory", "r0"
  );

  // Switch to the next task
  __asm volatile (
  "LDR R0, %0     \n"
  "LDMIA R0!, {R4-R11}    \n"
  "MSR PSP, R0            \n"
  :
  : "m" (tm.next_task->sp)
 // : "m" (next_task_sp)
  : "memory", "r0"
  );
  tm.current_task = tm.next_task;
  __asm volatile("BX LR");

}
#endif

static volatile uint32_t s_ticks;
void SysTick_Handler(void) {
  s_ticks++;
  if (s_ticks % 10 == 0) {
    reschedule();
    trigger_pendsv();
  }
}

/* This logic works because when the later (s_ticks) rolls over, its value will be close
 * to UNINT_MAX as 2^32 will be added to it, making the value positive number.
 */
static uint32_t elapsed_time(uint32_t later, uint32_t start){
  return later - start;
}

int main(void) {
  uint16_t led = PIN('B', 7);             // Blue LED
  RCC->AHB1ENR |= BIT(PINBANK(led));      // Enable GPIO clock for LED
  //systick_init(16000000 / 1000);
  systick_init(16000000);
  gpio_set_mode(led, GPIO_MODE_OUTPUT);
  uart_init(UART3, 115200);               // Initialise UART
  uint32_t start = s_ticks;
  bool on = true;         // This block is executed
  int i = 0;

  tcb_task1.task_id = 1;
  tcb_task1.task_function = (uint32_t *)task1;
  create_task(&tcb_task1);

  tcb_task2.task_id = 2;
  tcb_task2.task_function = (uint32_t *)task2;
  create_task(&tcb_task2);
 
  current_task_sp = tcb_task1.sp;
  current_task_id = tcb_task1.task_id;
  next_task_sp = tcb_task2.sp;

  printf("Before first pendsv. cur_sp=%p, next_sp=%p, task1_sp=%p, task2_sp=%p\r\n",
         current_task_sp, next_task_sp, tcb_task1.sp, tcb_task2.sp);

  start_first_task();

  for (;;){
  }

  for (;;) {
    // 200ms timer
    if (elapsed_time(s_ticks, start) > 10) {
      gpio_write(led, on);    // Every 'period' milliseconds
      on = !on;
      start = s_ticks;
      //uart_write_buf(UART3, "hi\r\n", 4);
      printf("%d  : LED : %d, tick: %lu\r\n", i, on, s_ticks);
      i++;
    }
  }
  return 0;
}

