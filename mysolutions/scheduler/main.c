#include "hal.h"

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
  for (;;) {
    // 200ms timer
    if (elapsed_time(s_ticks, start) > 500) {
      gpio_write(led, on);    // Every 'period' milliseconds
      on = !on;
      start = s_ticks;
      //uart_write_buf(UART3, "hi\r\n", 4);
      printf("%d  : LED : %d, tick: %lu\r\n",i, on, s_ticks);
      i++;
    }
  }
  return 0;
}

