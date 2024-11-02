#include "hal.h"

#define TASK_STACK_SIZE 1024 // Size of the task stack in bytes
static uint32_t task1_stack[TASK_STACK_SIZE/sizeof(uint32_t)]; // This is my stack  of 128 bytes
static uint32_t task1_op_stack[TASK_STACK_SIZE/sizeof(uint32_t)]; // This is my stack  of 128 bytes
void task1(void);
static void print_core_regs(struct core_regs *, char *);
static inline void save_core_regs_main();
static inline void save_core_regs_pendsv();
static inline void save_core_regs_task1();
struct core_regs regs_main;
struct core_regs regs_pendsv;
struct core_regs regs_task1;

static volatile uint32_t s_task1_counter;
void task1 (void) {
  printf("Starting task 1\r\n");
  save_core_regs_task1();
  /*
  uint16_t led = PIN('B', 7);             // Blue LED
  RCC->AHB1ENR |= BIT(PINBANK(led));      // Enable GPIO clock for LED
  systick_init(16000000 / 1000);
  gpio_set_mode(led, GPIO_MODE_OUTPUT);
  uart_init(UART3, 115200);               // Initialise UART
  */
  int i = 0;
  while (1) {
    printf("This is task 1, %d\r\n", i++);
    spin(1000000); 
    if (i > 10) break;
  }
  s_task1_counter++;
  printf("Exiting task1 \r\n");
}
// Stack pointe rfor task1
static volatile uint32_t *task1_sp;
static volatile uint32_t *task1_last_element;

// Function to set the Process Stack pointer  (PSP)
void set_PSP(uint32_t sp) {
  __asm volatile("MSR PSP, %0" : : "r" (sp)); //Set the PSP to the provided value
}

void create_task(void) {
  // Initialize the stack pointer for task1
  // Point to the top of the stack. (Note that stack grows downward in M4)
  task1_sp = (volatile uint32_t *)(&task1_stack[TASK_STACK_SIZE/sizeof(uint32_t)]);
  task1_last_element = task1_sp;

  // Set up initial Context (See Programming Manual 2.3.7 Exception entry and return. Figure 12)
  // Need to set up, R0 to R3, R12, LR(Link Register), PC(Program Counter), xPSR(Program Status Register)
  *(--task1_sp) = (1UL << 24); // xPSR: Set the Thumb bit (T bit) to indicate a valid state
  *(--task1_sp) = (uint32_t)task1; // PC: Address of the task function
  *(--task1_sp) = 0xFFFFFFFD; // LR: Link Register, typically 0 for initial task
  task1_sp = (volatile uint32_t *)(&task1_op_stack[TASK_STACK_SIZE/sizeof(uint32_t)]);
  task1_sp--;
  //R12 to R0
  for (int i = 0; i <= 12; i++) {
    *(--task1_sp) = 0;
  }
 }

static volatile uint32_t s_pendsv_count;
//static volatile uint32_t *current_task_sp;
//static volatile uint32_t *next_task_sp;
void PendSV_Handler(void) {
  //printf("PendSV \r\n");
  //s_pendsv_count++;
  __asm volatile (
    "LDR R0, %[next_sp]    \n"
    "LDMIA SP!, {R0-R12}   \n"
    "LDR PC, =task1        \n"
    :
    : [next_sp] "m" (task1_sp)
    : "memory", "r0"
  );
  //save_core_regs_pendsv();
  //printf("PendSV_Handler: task1_sp %p, task1 pc %p\r\n", task1_sp, task1);
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

static inline void save_core_regs_main() {
  __asm volatile (
    "MOV %0, R0        \n"
    "MOV %1, R1        \n"
    "MOV %2, R2        \n"
    "MOV %3, R3        \n"
    "MOV %4, R12       \n"
    "MOV %5, LR        \n"
    "MOV %6, PC        \n"
    "MRS %7, PSR       \n"
    : "=r" (regs_main.r0),
    "=r" (regs_main.r1),
    "=r" (regs_main.r2),
    "=r" (regs_main.r3),
    "=r" (regs_main.r12),
    "=r" (regs_main.lr),
    "=r" (regs_main.pc),
    "=r" (regs_main.psr)
  );
}

static inline void save_core_regs_pendsv() {
  __asm volatile (
    "MOV %0, R0         \n"
    "MOV %1, R1         \n"
    "MOV %2, R2         \n"
    "MOV %3, R3         \n"
    "MOV %4, R12        \n"
    "MOV %5, LR         \n"
    "MOV %6, PC         \n"
    "MRS %7, PSR       \n"
    : "=r" (regs_pendsv.r0),
    "=r" (regs_pendsv.r1),
    "=r" (regs_pendsv.r2),
    "=r" (regs_pendsv.r3),
    "=r" (regs_pendsv.r12),
    "=r" (regs_pendsv.lr),
    "=r" (regs_pendsv.pc),
    "=r" (regs_pendsv.psr)
  );
}

static inline void save_core_regs_task1() {
  __asm volatile (
    "MOV %0, R0         \n"
    "MOV %1, R1         \n"
    "MOV %2, R2         \n"
    "MOV %3, R3         \n"
    "MOV %4, R12        \n"
    "MOV %5, LR         \n"
    "MOV %6, PC         \n"
    "MRS %7, PSR       \n"
    : "=r" (regs_task1.r0),
    "=r" (regs_task1.r1),
    "=r" (regs_task1.r2),
    "=r" (regs_task1.r3),
    "=r" (regs_task1.r12),
    "=r" (regs_task1.lr),
    "=r" (regs_task1.pc),
    "=r" (regs_task1.psr)
  );
}

static void print_core_regs(struct core_regs *regs, char *str)
{
  printf("%s\r\n", str);
  printf("xPSR : 0x%lX \r\n", regs->psr);
  printf("PC   : 0x%lX \r\n", regs->pc);
  printf("LR   : 0x%lX \r\n", regs->lr);
  printf("R12  : 0x%lX \r\n", regs->r12);
  printf("R3   : 0x%lX \r\n", regs->r3);
  printf("R2   : 0x%lX \r\n", regs->r2);
  printf("R1   : 0x%lX \r\n", regs->r1);
  printf("R0   : 0x%lX \r\n", regs->r0);
}

int main(void) {
  uint16_t led = PIN('B', 7);             // Blue LED
  RCC->AHB1ENR |= BIT(PINBANK(led));      // Enable GPIO clock for LED
  systick_init(16000000 / 1000);
  gpio_set_mode(led, GPIO_MODE_OUTPUT);
  uart_init(UART3, 115200);               // Initialise UART
  uint32_t start = s_ticks;
  bool on = true;         // This block is executed
  int i = 0;
  
 // uint32_t s[10];
 // printf("s[0] = %p, s[9] = %p \r\n", &s[0], &s[9]);
 // spin(1000000000); 

  save_core_regs_main();
  print_core_regs(&regs_main, "#### main ####");
  create_task();
  trigger_pendsv();

  print_core_regs(&regs_pendsv, "#### pendsv ####");
  print_core_regs(&regs_task1, "#### task1 ####");

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

