#include "hal.h"

#define TASK_STACK_SIZE 1024 // Size of the task stack in bytes
static uint32_t task1_stack[TASK_STACK_SIZE/sizeof(uint32_t)]; // This is my stack  of 128 bytes
void task1(void);
static volatile uint32_t s_task1_counter;
void task1 (void) {
  /*
  uint16_t led = PIN('B', 7);             // Blue LED
  RCC->AHB1ENR |= BIT(PINBANK(led));      // Enable GPIO clock for LED
  systick_init(16000000 / 1000);
  gpio_set_mode(led, GPIO_MODE_OUTPUT);
  uart_init(UART3, 115200);               // Initialise UART
  */
  printf("Starting task 1\r\n");
 
  int i = 0;
  while (1) {
    printf("This is task 1, %d\r\n", i++);
    spin(1000000); 
  }
  s_task1_counter++;
}
// Stack pointe rfor task1
static volatile uint32_t *task1_sp;

// Function to set the Process Stack pointer  (PSP)
void set_PSP(uint32_t sp) {
  __asm volatile("MSR PSP, %0" : : "r" (sp)); //Set the PSP to the provided value
}

//#define TEST
void create_task(void) {
  #ifdef TEST
  
  task1_sp = (volatile uint32_t *)(&task1_stack[TASK_STACK_SIZE/sizeof(uint32_t)]);
  *(--task1_sp) = (1UL << 24);
  *(--task1_sp) = (uint32_t)task1;
  *(--task1_sp) = 0xFFFFFFFD;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;
  *(--task1_sp) = 0;

  #else

  // Initialize the stack pointer for task1
  // Point to the top of the stack. (Note that stack grows downward in M4)
  task1_sp = (volatile uint32_t *)(&task1_stack[TASK_STACK_SIZE/sizeof(uint32_t)]);

  // Set up initial Context (See Programming Manual 2.3.7 Exception entry and return. Figure 12)
  // Need to set up, R0 to R3, R12, LR(Link Register), PC(Program Counter), xPSR(Program Status Register)
  *(--task1_sp) = (1UL << 24); // xPSR: Set the Thumb bit (T bit) to indicate a valid state
  //*(--task1_sp) = (uint32_t)task1 & 0xfffffffeUL; // PC: Address of the task function
  *(--task1_sp) = (uint32_t)task1; // PC: Address of the task function
  *(--task1_sp) = 0xFFFFFFFD; // LR: Link Register, typically 0 for initial task
  // Push R12, R3, R2, R1 and R0 onto the stack; there can be set to 0 initially
  for (int i = 0; i < 5; i++) {
    *(--task1_sp) = 0; // R12 and R3-R0 to 0
  }
#endif
  // Set the initial SP for the task
  //set_PSP((uint32_t)task1_sp);
  __asm volatile ("MSR PSP, %0" : : "r" (task1_sp) : "memory");

  __asm volatile (
    "MOVS R0, #0x02 \n"
    "MSR CONTROL, R0 \n"
    "ISB            \n"
    "BX %0          \n"
    :
    : "r" (task1)
    : "r0", "memory"
  );
}

void start_first_task(void) {
  set_PSP((uint32_t)task1_sp);
  trigger_pendsv();
}
static volatile uint32_t s_pendsv_count;
//static volatile uint32_t *current_task_sp;
//static volatile uint32_t *next_task_sp;
void PendSV_Handler(void) {
  printf("PendSV_Handler \r\n");
  s_pendsv_count++;
  
  // My first context switch logic
  // Save context
/*
  __asm volatile (
    "MRS R0, PSP              \n" // Load Process Stack Pointer into R0
    "STMDB R0!, {R4-R11}      \n" // Push R4-R11 onto the current task stack
    "STR R0, %[cur_sp]        \n" // Save updated PSP value to current_task_sp
    : [cur_sp] "=m" (current_task_sp)
    :
    : "memory", "r0"                  // Clobber list
    //: [cur_sp] "m" (current_task_sp)  // Output: Save PSP to current_task_sp
 );
 */

  // Switch  to the next task
  //current_task_sp = next_task_sp;
  //next_task_sp = task1_sp;
  // Restore context
  printf("PendSV_Handler: task1_sp %p \r\n", task1_sp);
  __asm volatile (
    "LDR R0, %[next_sp]       \n" // Load PSP for next task into R0
    "LDMIA R0!, {R4-R11}      \n" // Pop R4-R11 from the next task stack
    "MSR PSP, R0              \n" // Update PSP with the next task's stack pointer
    //"SVC 0                    \n" // Start fist task
    "BX LR                    \n" // Return to task
    :
    : [next_sp] "m" (task1_sp) // Input: Load next_task_sp to PSP
    : "memory", "r0"              // Clobber list
  );

  // Exit PendSV, R0-R3, R12, LR, PC, and xPSR will be resoterd automatically by hardware
  printf("Exiting PendSV_Handler. Should switch to a new task.\r\n");
}

static volatile uint32_t s_ticks;
void SysTick_Handler(void) {
  s_ticks++;
}

/* This logic works because when the later (s_ticks) rolls over, its value will be close
 * to UNINT_MAX as 2^32 will be added to it, making the value positive number.
 */
static uint32_t elapsed_time(uint32_t later, uint32_t start){
  return later - start;
}

// Simple scheduler
// 1. Set up SysTick Timer
// 2. Define Task Context Structure
// 3. Initialize Task Stacks
// 4. Implement Context Save Routine
// 5. Implement Context Restore Routine
// 6. Implement Task Switching Mechanism
// 7. Enable SysTick and Start Scheduler

int main(void) {
  uint16_t led = PIN('B', 7);             // Blue LED
  RCC->AHB1ENR |= BIT(PINBANK(led));      // Enable GPIO clock for LED
  systick_init(16000000 / 1000);
  gpio_set_mode(led, GPIO_MODE_OUTPUT);
  uart_init(UART3, 115200);               // Initialise UART
  uint32_t start = s_ticks;
  bool on = true;         // This block is executed
  int i = 0;

  // My first task
  printf("Create task\r\n");
  create_task();
  start_first_task();
  while (1) {}
  //printf("SP for task1 : %p\r\n", task1_sp);

  //printf("Trigger PendSV interrupt to switch to new task\r\n");
  //set_PSP((uint32_t)task1_sp);
  trigger_pendsv();

  printf("Done switching (This should not be printed if context is switched to task1.)\r\n");
  spin(1000000000); 
  printf("Wait done\r\n");

  for (;;) {
    // 200ms timer
    if (elapsed_time(s_ticks, start) > 500) {
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

