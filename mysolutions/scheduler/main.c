#include "hal.h"

#define TASK_STACK_SIZE 1024 // Size of the task stack in bytes
void task1(void);
uint32_t * reschedule();

// Function to set the Process Stack pointer  (PSP)
void set_PSP(uint32_t sp) {
  __asm volatile("MSR PSP, %0" : : "r" (sp)); //Set the PSP to the provided value
}

// Task Control Block definition
#define NUM_CORE_REGS 21  // 16 General-purpose regs and 5 special regs    
#define STACK_SIZE 1024 * 2 // 2 KB

struct TCB {
  uint32_t task_id;
  uint32_t stack[STACK_SIZE / sizeof(uint32_t)];
  uint32_t *task_function;
  uint32_t *sp;
};

struct TCB tcb_scheduler;
struct TCB tcb_task1;
struct TCB tcb_task2;

// Scheduler helper functions
void create_task_tcb(struct TCB *tcb)
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
}

static uint32_t task_switch_count = 0;
void task_scheduler(void) {
  while(1) {
  printf("Scheduling %lu\r\n", task_switch_count++);
    spin(1000000);
  }
}

static volatile uint32_t current_task_id;
void task2 (void) {
  //current_task_id = 2;
  int i = 0;
  while (1) {
    printf("This is task 2, %d\r\n", i++);
    spin(4000000); 
  }
}

static volatile uint32_t s_task1_counter;
void task1 (void) {
  //current_task_id = 1;
  int i = 0;
  while (1) {
    printf("This is task 1, %d\r\n", i++);
    spin(4000000); 
  }
}

static volatile uint32_t s_pendsv_count;
static uint32_t *current_task_sp;
static uint32_t *next_task_sp;
static uint32_t *sp_before, *sp_after;
void PendSV_Handler(void) {
  //printf("PendSV Handler %lu \r\n", s_pendsv_count);
  //s_pendsv_count++;
  // Context save
  sp_before = current_task_sp;
  __asm volatile (
  "MRS R0, PSP            \n"
  "STMDB R0!, {R4-R11}    \n"
  "STR R0, %0             \n" // Save updated PSP to current_task_sp
  : "=m" (current_task_sp)
  :
  : "memory", "r0"
  );
  sp_after = current_task_sp;

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
  //current_task_sp = (current_task_id == tcb_task1.sp) ? tcb_task2.sp : tcb_task1.sp;
  //next_task_sp = current_task_sp;

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

static volatile uint32_t s_ticks;
void SysTick_Handler(void) {
  printf("SysTick Handler %lu, cur_sp=%p, next_sp=%p, task1_sp=%p, task2_sp=%p, current_task_id=%ld, sp_before=%p, sp_after=%p \r\n", s_ticks, current_task_sp, next_task_sp, tcb_task1.sp, tcb_task2.sp, current_task_id, sp_before, sp_after);
  s_ticks++;

  if (s_ticks % 10 == 0) {
    trigger_pendsv();
  }
  #if 0
  if (s_ticks == 10) {
    /*
    if (current_task_id == 1) {
      current_task_sp = tcb_task1.sp;
      next_task_sp = tcb_task2.sp;
      current_task_id = 2;
    } else {
      current_task_sp = tcb_task2.sp;
      next_task_sp = tcb_task1.sp;
      current_task_id = 1;
    }
    */
    trigger_pendsv(); 
  } else if (s_ticks == 20) {
    /*
     if (current_task_id == 1) {
      current_task_sp = tcb_task1.sp;
      next_task_sp = tcb_task2.sp;
      current_task_id = 2;
    } else {
      current_task_sp = tcb_task2.sp;
      next_task_sp = tcb_task1.sp;
      current_task_id = 1;
    }
    */
    trigger_pendsv(); 
  }
#endif
}

/* This logic works because when the later (s_ticks) rolls over, its value will be close
 * to UNINT_MAX as 2^32 will be added to it, making the value positive number.
 */
static uint32_t elapsed_time(uint32_t later, uint32_t start){
  return later - start;
}


static uint32_t sched_start = 0;
uint32_t * reschedule() {
  if (elapsed_time(s_ticks, sched_start) > 10) {
    sched_start = s_ticks;
    if (current_task_id == tcb_task1.task_id){
      return tcb_task2.sp;
    }
    else {
      return tcb_task1.sp;
    }
  }
  return 0;
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

  // Create a scheduler task and 2 worker tasks
  tcb_scheduler.task_id = 99;
  tcb_scheduler.task_function = (uint32_t *)task_scheduler;
  create_task_tcb(&tcb_scheduler);

  tcb_task1.task_id = 1;
  tcb_task1.task_function = (uint32_t *)task1;
  create_task_tcb(&tcb_task1);

  tcb_task2.task_id = 2;
  tcb_task2.task_function = (uint32_t *)task2;
  create_task_tcb(&tcb_task2);
 
  current_task_sp = tcb_task1.sp;
  current_task_id = tcb_task1.task_id;
  next_task_sp = tcb_task2.sp;

  printf("Before first pendsv. cur_sp=%p, next_sp=%p, task1_sp=%p, task2_sp=%p\r\n",
         current_task_sp, next_task_sp, tcb_task1.sp, tcb_task2.sp);
  /*
  current_task_sp--;
  printf("Before first pendsv. cur_sp=%p, next_sp=%p, task1_sp=%p, task2_sp=%p\r\n",
         current_task_sp, next_task_sp, tcb_task1.sp, tcb_task2.sp);
  spin(10000000);
  */
   // Set the PSP to the initial task's stack pointer and enable PSP
   __asm volatile ("MSR PSP, %0" : : "r" (current_task_sp) : "memory");
   __asm volatile ("MOV R0, #2"); // Set CONTROL register to use PSP in Thread mode
   __asm volatile ("MSR CONTROL, R0");

  printf("Before first pendsv. cur_sp=%p, next_sp=%p, task1_sp=%p, task2_sp=%p\r\n",
         current_task_sp, next_task_sp, tcb_task1.sp, tcb_task2.sp);
   // Trigger first task
   trigger_pendsv();
  for (;;){
    spin(100000);
  }
 // uint32_t s[10];
 // printf("s[0] = %p, s[9] = %p \r\n", &s[0], &s[9]);
 // spin(1000000000); 

  /*
  save_core_regs_main();
  print_core_regs(&regs_main, "#### main ####");
  create_task();
  trigger_pendsv();

  print_core_regs(&regs_pendsv, "#### pendsv ####");
  print_core_regs(&regs_task1, "#### task1 ####");

  printf("Done switching (This should not be printed if context is switched to task1.)\r\n");
  spin(1000000000); 
  printf("Wait done\r\n");
*/
  for (;;) {

      printf("%d  : LED : %d, tick: %lu, pendsv : %lu, task1 counter : %lu\r\n",
             i, on, s_ticks, s_pendsv_count, s_task1_counter);
      spin(1000000);
  }
  for (;;) {
    // 200ms timer
    if (elapsed_time(s_ticks, start) > 10) {
      gpio_write(led, on);    // Every 'period' milliseconds
      on = !on;
      start = s_ticks;
      //uart_write_buf(UART3, "hi\r\n", 4);
      printf("%d  : LED : %d, tick: %lu, pendsv : %lu, task1 counter : %lu\r\n",
             i, on, s_ticks, s_pendsv_count, s_task1_counter);
      i++;
    }
  }
  return 0;
}

