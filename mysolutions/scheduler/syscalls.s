	.cpu arm7tdmi
	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"syscalls.c"
	.text
	.align	2
	.syntax unified
	.arm
	.type	spin, %function
spin:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	b	.L2
.L3:
	.syntax divided
@ 29 "hal.h" 1
	nop
@ 0 "" 2
	.arm
	.syntax unified
.L2:
	ldr	r3, [fp, #-8]
	sub	r2, r3, #1
	str	r2, [fp, #-8]
	cmp	r3, #0
	bne	.L3
	nop
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	spin, .-spin
	.align	2
	.syntax unified
	.arm
	.type	uart_write_byte, %function
uart_write_byte:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	mov	r3, r1
	strb	r3, [fp, #-9]
	ldrb	r2, [fp, #-9]	@ zero_extendqisi2
	ldr	r3, [fp, #-8]
	str	r2, [r3, #4]
	b	.L5
.L6:
	mov	r0, #1
	bl	spin
.L5:
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	and	r3, r3, #128
	cmp	r3, #0
	beq	.L6
	nop
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
	.size	uart_write_byte, .-uart_write_byte
	.align	2
	.syntax unified
	.arm
	.type	uart_write_buf, %function
uart_write_buf:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	b	.L8
.L9:
	ldr	r3, [fp, #-12]
	add	r2, r3, #1
	str	r2, [fp, #-12]
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, [fp, #-8]
	bl	uart_write_byte
.L8:
	ldr	r3, [fp, #-16]
	sub	r2, r3, #1
	str	r2, [fp, #-16]
	cmp	r3, #0
	bne	.L9
	nop
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
	.size	uart_write_buf, .-uart_write_buf
	.align	2
	.global	_write
	.syntax unified
	.arm
	.type	_write, %function
_write:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	ldr	r3, [fp, #-8]
	cmp	r3, #1
	bne	.L11
	ldr	r3, [fp, #-16]
	mov	r2, r3
	ldr	r1, [fp, #-12]
	ldr	r0, .L13
	bl	uart_write_buf
.L11:
	mvn	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L14:
	.align	2
.L13:
	.word	1073760256
	.size	_write, .-_write
	.align	2
	.global	_fstat
	.syntax unified
	.arm
	.type	_fstat, %function
_fstat:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	mvn	r3, #0
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	_fstat, .-_fstat
	.align	2
	.global	_sbrk
	.syntax unified
	.arm
	.type	_sbrk, %function
_sbrk:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	ldr	r3, .L20
	ldr	r3, [r3]
	cmp	r3, #0
	bne	.L18
	ldr	r3, .L20
	ldr	r2, .L20+4
	str	r2, [r3]
.L18:
	ldr	r3, .L20
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	ldr	r3, .L20
	ldr	r2, [r3]
	ldr	r3, [fp, #-16]
	add	r3, r2, r3
	ldr	r2, .L20
	str	r3, [r2]
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L21:
	.align	2
.L20:
	.word	heap.0
	.word	_end
	.size	_sbrk, .-_sbrk
	.align	2
	.global	_close
	.syntax unified
	.arm
	.type	_close, %function
_close:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	mvn	r3, #0
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	_close, .-_close
	.align	2
	.global	_isatty
	.syntax unified
	.arm
	.type	_isatty, %function
_isatty:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	mov	r3, #1
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	_isatty, .-_isatty
	.align	2
	.global	_read
	.syntax unified
	.arm
	.type	_read, %function
_read:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	mvn	r3, #0
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	_read, .-_read
	.align	2
	.global	_lseek
	.syntax unified
	.arm
	.type	_lseek, %function
_lseek:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	mov	r3, #0
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	_lseek, .-_lseek
	.bss
	.align	2
heap.0:
	.space	4
	.size	heap.0, 4
	.ident	"GCC: (15:13.2.rel1-2) 13.2.1 20231009"
