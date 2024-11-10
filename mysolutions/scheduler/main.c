#include "hal.h"

static inline void reschedule(void);
void PendSV_Handler(void);
static inline uint32_t elapsed_time(uint32_t later, uint32_t start);

// System SysTick
#define SYSTICK_INITIAL_LOAD  (16000000 / 1000) // Every millisecond
// Task Manger definition
#define NUM_TASK_MAX  32

// Task Control Block definition
#define STACK_SIZE 1024 * 2 // 2 KB

struct TCB {
  // Do not change the order of variables as start_first_task() devends on it.
  uint32_t *sp;
  uint32_t *task_function;
  uint32_t task_id;
  uint32_t stack[STACK_SIZE / sizeof(uint32_t)];
  uint32_t sleep_ticks;
  uint32_t state;
};

struct task_manager{
  volatile struct TCB *current_task;
  volatile struct TCB *next_task;
  volatile struct TCB *save_task;
  struct TCB *tasks[NUM_TASK_MAX];
  uint32_t num_tasks;
};

static struct task_manager tm = {
  .num_tasks = 0
};

enum{
  TASK_READY,
  TASK_RUNNING,
  TASK_PENDING
};

static volatile uint32_t s_ticks;

void sleep(uint32_t ms) {
  volatile struct TCB *task = tm.current_task;
  task->sleep_ticks = ms;
  while(task->sleep_ticks > 0){
    __asm("nop");
  }
}

// Scheduler helper functions
void create_task(struct TCB *tcb, void (*task_func)())
{
  uint32_t *sp = &(tcb->stack[STACK_SIZE / sizeof(uint32_t)]);
  *(--sp) = (1UL << 24); // xPSR: Set the Thumb bit (T bit) to indicate a valid state
  *(--sp) = (uint32_t)task_func; // R15 : PC
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

  tcb->task_function = (uint32_t *)task_func;
  tcb->task_id = tm.num_tasks + 1;
  tcb->sp = sp;
  tcb->state = TASK_READY;
  tcb->sleep_ticks = 0;
  tm.tasks[tm.num_tasks] = tcb;
  tm.num_tasks++;
}

void start_first_task() {
  if (tm.num_tasks == 0) {
    return;
  }

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

void start_scheduler() {
  systick_init(SYSTICK_INITIAL_LOAD);
  start_first_task();
}

static uint32_t next_task_index = 1;
static inline void reschedule(void) {
  if (tm.num_tasks == 1) {
    return;
  }

  // Round robin
  //next_task_index++;
  if (++next_task_index >= tm.num_tasks) {
    next_task_index = 0;
  }

  tm.next_task = tm.tasks[next_task_index];
  tm.save_task = tm.current_task;
  tm.current_task->state = TASK_READY;
  tm.current_task = tm.next_task;
  trigger_pendsv();
}

void update_sleep_ticks(void) {
  struct TCB *task;
  for (uint32_t i = 0; i < tm.num_tasks; i++) {
    task = tm.tasks[i];
    if (task->sleep_ticks > 0){
     task->sleep_ticks--;
    }
  }
}

void SysTick_Handler(void) {
  s_ticks++;
  update_sleep_ticks();
  reschedule();
}

static volatile uint32_t s_pendsv_count;
void PendSV_Handler(void) {
  s_pendsv_count++;

  // Save current task
  __asm volatile (
  "MRS R0, PSP            \n"
  "STMDB R0!, {R4-R11}    \n"
  "STR R0, %0             \n" // Save updated PSP to current_task_sp
  : "=m" (tm.save_task->sp)
  : 
  : "memory", "r0"
  );

  // Load next task
  __asm volatile (
  "LDR R0, %0     \n"
  "LDMIA R0!, {R4-R11}    \n"
  "MSR PSP, R0            \n"
  :
  : "m" (tm.next_task->sp)
  : "memory", "r0"
  );

  // Switch to new task
  __asm volatile("BX LR");
}

/* This logic works because when the later (s_ticks) rolls over, its value will be close
 * to UNINT_MAX as 2^32 will be added to it, making the value positive number.
 */
static inline uint32_t elapsed_time(uint32_t later, uint32_t start){
  return later - start;
}

void idle(void) {
  //int i = 0;
  while(1) {
    asm("nop");
  }
}

struct TCB tcb_task1;
void task1 (void) {
  int i = 0;
  while (1) {
    printf("This is task 1, %d\r\n", i++);
    sleep(10000);
  }
}

void task2 (void) {
  int i = 10000000;
  while (1) {
    printf("This is task 2, %d\r\n", i--);
    sleep(3000);
  }
}

void task3 (void) {
  bool on = true;                         // This block is executed
  uint16_t led = PIN('B', 7);             // Blue LED
  RCC->AHB1ENR |= BIT(PINBANK(led));      // Enable GPIO clock for LED
  gpio_set_mode(led, GPIO_MODE_OUTPUT);

  for (;;) {
    printf("This is task 3. LED : %d\r\n", on);
    gpio_write(led, on);
    on = !on;
    sleep(1000);
  }
}

int main(void) {
  uart_init(UART3, 115200);   // Initialise UART

  struct TCB tcb_idle_task;
  struct TCB tcb_task2;
  struct TCB tcb_task3;

  create_task(&tcb_idle_task, idle);
  create_task(&tcb_task1, task1);
  create_task(&tcb_task2, task2);
  create_task(&tcb_task3, task3);

  start_scheduler();
  
  // Should not reach here.
  for (;;);

  return 0;
}

