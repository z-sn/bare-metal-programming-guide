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
	.file	"startup.c"
	.text
	.align	2
	.global	_reset
	.syntax unified
	.arm
	.type	_reset, %function
_reset:
	@ Function supports interworking.
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	ldr	r4, .L7
	b	.L2
.L3:
	mov	r3, #0
	str	r3, [r4]
	add	r4, r4, #4
.L2:
	ldr	r3, .L7+4
	cmp	r4, r3
	bcc	.L3
	ldr	r4, .L7+8
	ldr	r5, .L7+12
	b	.L4
.L5:
	mov	r2, r5
	add	r5, r2, #4
	mov	r3, r4
	add	r4, r3, #4
	ldr	r2, [r2]
	str	r2, [r3]
.L4:
	ldr	r3, .L7+16
	cmp	r4, r3
	bcc	.L5
	bl	main
.L6:
	b	.L6
.L8:
	.align	2
.L7:
	.word	_sbss
	.word	_ebss
	.word	_sdata
	.word	_sidata
	.word	_edata
	.size	_reset, .-_reset
	.global	tab
	.section	.vectors,"a"
	.align	2
	.type	tab, %object
	.size	tab, 428
tab:
	.word	_estack
	.word	_reset
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	PendSV_Handler
	.word	SysTick_Handler
	.space	364
	.ident	"GCC: (15:13.2.rel1-2) 13.2.1 20231009"
