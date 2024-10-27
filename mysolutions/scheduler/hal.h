#pragma once

#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>
#include <stddef.h> // size_t
#include <sys/stat.h>

#include <string.h> // memset

#define BIT(x) (1UL << (x))
#define PIN(bank, num) ((((bank) - 'A') << 8) | (num))
#define PINNO(pin) (pin & 255)
#define PINBANK(pin) (pin >> 8)
#define BUF_SIZE 64 

static inline void spin(volatile uint32_t count) {
  while (count--) asm("nop");
  //while (count--) (void)0;
}
struct gpio {
  volatile uint32_t MODER, OTYPER, OSPEEDR, PUPDR, IDR, ODR, BSRR, LCKR, AFR[2];
};

#define GPIO(bank) ((struct gpio *)(0x40020000 + 0x400 * (bank)))

// Enum values are per dateasheet: 0, 1, 2, 3
enum { GPIO_MODE_INPUT, GPIO_MODE_OUTPUT, GPIO_MODE_AF, GPIO_MODE_ANALOG };

// RCC (Reset and Clock Control) to enable peripherals
#define RCC ((struct rcc *) 0x40023800)

struct rcc {
  volatile uint32_t CR, PLLCFGR, CFGR, CIR, AHB1RSTR, AHB2RSTR, AHB3RSTR,
      RESERVED0, APB1RSTR, APB2RSTR, RESERVED1[2], AHB1ENR, AHB2ENR, AHB3ENR,
      RESERVED2, APB1ENR, APB2ENR, RESERVED3[2], AHB1LPENR, AHB2LPENR,
      AHB3LPENR, RESERVED4, APB1LPENR, APB2LPENR, RESERVED5[2], BDCR, CSR,
      RESERVED6[2], SSCGR, PLLI2SCFGR;
};

static inline void gpio_set_mode(uint16_t pin, uint8_t mode) {
  struct gpio *gpio = GPIO(PINBANK(pin)); // GPIO bank
  int n = PINNO(pin);                     // Pin number
  RCC->AHB1ENR |= BIT(PINBANK(pin));    // Enable GPIO clock
  gpio->MODER &= ~(3U << (n * 2));        // Clear existing setting
  gpio->MODER |= (mode & 3) << (n * 2);   // Set new mode
}

static inline void gpio_write(uint16_t pin, bool val) {
  struct gpio *gpio = GPIO(PINBANK(pin));
  gpio->BSRR = (1U << PINNO(pin)) << (val ? 0 : 16);
}

/* SysTick interrupt */
struct systick {
  volatile uint32_t CTRL, LOAD, VAL, CALIB;
};

#define SYSTICK ((struct systick *) 0xe000e010) // 2.2.2

static inline void systick_init(uint32_t ticks) {
  if ((ticks - 1) > 0xffffff) return; // Systick timer is 24 bit
  SYSTICK->LOAD = ticks - 1;
  SYSTICK->VAL = 0;
  SYSTICK->CTRL = BIT(0) | BIT(1) | BIT(2); // Enable systick
  RCC->APB2ENR |= BIT(14);                  // Enable SYSCFG
}

// USART
struct uart {
  volatile uint32_t SR, DR, BRR, CR1, CR2, CR3, GTPR;
};

#define UART1 ((struct uart *) 0x40011000)
#define UART2 ((struct uart *) 0x40004400)
#define UART3 ((struct uart *) 0x40004800)

static inline void gpio_set_af(uint16_t pin, uint8_t af_num) {
  struct gpio *gpio = GPIO(PINBANK(pin));     // GPIO bank
  int n = PINNO(pin);                         // Pin number
  gpio->AFR[n >> 3] &= ~(15UL << ((n & 7) * 4));
  gpio->AFR[n >> 3] |= ((uint32_t)af_num) << ((n & 7) * 4);
}

#define FREQ 16000000 // CPU frequency, 16 MHz
static inline void uart_init(struct uart *uart, unsigned long baud) {
  uint8_t af = 7;           // Alternate function
  uint16_t rx = 0, tx = 0;  // pins

  if (uart == UART1) RCC->APB2ENR |= BIT(4);
  if (uart == UART2) RCC->APB1ENR |= BIT(17);
  if (uart == UART3) RCC->APB1ENR |= BIT(18);

  if (uart == UART1) tx = PIN('A', 9), rx = PIN('A', 10);
  if (uart == UART2) tx = PIN('A', 2), rx = PIN('A', 3);
  if (uart == UART3) tx = PIN('D', 8), rx = PIN('D', 9);

  gpio_set_mode(tx, GPIO_MODE_AF);
  gpio_set_af(tx, af);
  gpio_set_mode(rx, GPIO_MODE_AF);
  gpio_set_af(rx, af);
  uart->CR1 = 0;                            // Disable this UART1
  uart->BRR = FREQ / baud;                  // FREQ is an UART bus frequency
  uart->CR1 |= BIT(13) | BIT(2) | BIT(3);  // Set UE, RE, TE
}

static inline int uart_read_ready(struct uart *uart) {
  return uart->SR & BIT(5); // If RXNE bit is set, data is ready
}

static inline uint8_t uart_read_byte(struct uart *uart) {
  return (uint8_t)(uart->DR & 255);
}

static inline void uart_write_byte(struct uart *uart, uint8_t byte) {
  uart->DR = byte;
  while ((uart->SR & BIT(7)) == 0) spin(1);
}

static inline void uart_write_buf(struct uart *uart, char *buf, size_t len) {
  while(len-- > 0) uart_write_byte(uart, *(uint8_t *)buf++);
}

