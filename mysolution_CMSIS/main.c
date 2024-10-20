#include "hal.h"

static volatile uint32_t s_ticks;
void SysTick_Handler(void) {
  s_ticks++;
}

uint32_t SystemCoreClock = FREQ;
void SystemInit(void) {
  RCC->APB2ENR |= RCC_APB2ENR_SYSCFGEN;
  SysTick_Config(SystemCoreClock / 1000);
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
      printf("%d  : LED : %d, tick: %lu\r\n",i, on, s_ticks);
      i++;
    }
  }
  return 0;
}

