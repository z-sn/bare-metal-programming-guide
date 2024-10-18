#include "hal.h"

int main(void) {
  uint16_t led = PIN('B', 7);             // Blue LED
  RCC->AHB1ENR |= BIT(PINBANK(led));      // Enable GPIO clock for LED
  systick_init(16000000 / 1000);
  gpio_set_mode(led, GPIO_MODE_OUTPUT);
  uart_init(UART3, 115200);               // Initialise UART
  uint32_t start = s_ticks;
  bool on = true;         // This block is executed
  int i = 0;
  char buf[BUF_SIZE]; // Reserve enough buf
  for (;;) {
    // 200ms timer
    if (elapsed_time(s_ticks, start) > 500) {
      gpio_write(led, on);    // Every 'period' milliseconds
      on = !on;
      start = s_ticks;
      int_to_string(i, buf, BUF_SIZE);
      uart_write_buf(UART3, buf, BUF_SIZE); // Write message
      i++;
    }
  }
  return 0;
}

