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
	.file	"main.c"
	.text
	.align	2
	.syntax unified
	.arm
	.type	trigger_pendsv, %function
trigger_pendsv:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	ldr	r3, .L2
	ldr	r3, [r3]
	ldr	r2, .L2
	orr	r3, r3, #268435456
	str	r3, [r2]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L3:
	.align	2
.L2:
	.word	-536810236
	.size	trigger_pendsv, .-trigger_pendsv
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
	b	.L5
.L6:
	.syntax divided
@ 29 "hal.h" 1
	nop
@ 0 "" 2
	.arm
	.syntax unified
.L5:
	ldr	r3, [fp, #-8]
	sub	r2, r3, #1
	str	r2, [fp, #-8]
	cmp	r3, #0
	bne	.L6
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
	.type	gpio_set_mode, %function
gpio_set_mode:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	mov	r3, r0
	mov	r2, r1
	strh	r3, [fp, #-14]	@ movhi
	mov	r3, r2
	strb	r3, [fp, #-15]
	ldrh	r3, [fp, #-14]
	lsr	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	add	r3, r3, #1048576
	add	r3, r3, #128
	lsl	r3, r3, #10
	str	r3, [fp, #-8]
	ldrh	r3, [fp, #-14]
	and	r3, r3, #255
	str	r3, [fp, #-12]
	ldr	r3, .L8
	ldr	r2, [r3, #48]
	ldrh	r3, [fp, #-14]
	lsr	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	mov	r1, r3
	mov	r3, #1
	lsl	r3, r3, r1
	ldr	r1, .L8
	orr	r3, r2, r3
	str	r3, [r1, #48]
	ldr	r3, [fp, #-8]
	ldr	r2, [r3]
	ldr	r3, [fp, #-12]
	lsl	r3, r3, #1
	mov	r1, #3
	lsl	r3, r1, r3
	mvn	r3, r3
	and	r2, r2, r3
	ldr	r3, [fp, #-8]
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	ldrb	r2, [fp, #-15]	@ zero_extendqisi2
	and	r1, r2, #3
	ldr	r2, [fp, #-12]
	lsl	r2, r2, #1
	lsl	r2, r1, r2
	orr	r2, r3, r2
	ldr	r3, [fp, #-8]
	str	r2, [r3]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L9:
	.align	2
.L8:
	.word	1073887232
	.size	gpio_set_mode, .-gpio_set_mode
	.align	2
	.syntax unified
	.arm
	.type	gpio_write, %function
gpio_write:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	mov	r3, r0
	mov	r2, r1
	strh	r3, [fp, #-14]	@ movhi
	mov	r3, r2
	strb	r3, [fp, #-15]
	ldrh	r3, [fp, #-14]
	lsr	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	add	r3, r3, #1048576
	add	r3, r3, #128
	lsl	r3, r3, #10
	str	r3, [fp, #-8]
	ldrh	r3, [fp, #-14]
	and	r3, r3, #255
	mov	r2, #1
	lsl	r2, r2, r3
	ldrb	r3, [fp, #-15]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L11
	mov	r3, #0
	b	.L12
.L11:
	mov	r3, #16
.L12:
	lsl	r2, r2, r3
	ldr	r3, [fp, #-8]
	str	r2, [r3, #24]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	gpio_write, .-gpio_write
	.align	2
	.syntax unified
	.arm
	.type	systick_init, %function
systick_init:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	cmp	r3, #16777216
	bcs	.L16
	ldr	r2, .L17
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	str	r3, [r2, #4]
	ldr	r3, .L17
	mov	r2, #0
	str	r2, [r3, #8]
	ldr	r3, .L17
	mov	r2, #7
	str	r2, [r3]
	ldr	r3, .L17+4
	ldr	r3, [r3, #68]
	ldr	r2, .L17+4
	orr	r3, r3, #16384
	str	r3, [r2, #68]
	b	.L13
.L16:
	nop
.L13:
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L18:
	.align	2
.L17:
	.word	-536813552
	.word	1073887232
	.size	systick_init, .-systick_init
	.align	2
	.syntax unified
	.arm
	.type	gpio_set_af, %function
gpio_set_af:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	mov	r3, r0
	mov	r2, r1
	strh	r3, [fp, #-14]	@ movhi
	mov	r3, r2
	strb	r3, [fp, #-15]
	ldrh	r3, [fp, #-14]
	lsr	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	add	r3, r3, #1048576
	add	r3, r3, #128
	lsl	r3, r3, #10
	str	r3, [fp, #-8]
	ldrh	r3, [fp, #-14]
	and	r3, r3, #255
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-12]
	asr	r2, r3, #3
	ldr	r3, [fp, #-8]
	add	r2, r2, #8
	ldr	r1, [r3, r2, lsl #2]
	ldr	r3, [fp, #-12]
	and	r3, r3, #7
	lsl	r3, r3, #2
	mov	r2, #15
	lsl	r3, r2, r3
	mvn	r3, r3
	ldr	r2, [fp, #-12]
	asr	r2, r2, #3
	and	r1, r1, r3
	ldr	r3, [fp, #-8]
	add	r2, r2, #8
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [fp, #-12]
	asr	r2, r3, #3
	ldr	r3, [fp, #-8]
	add	r2, r2, #8
	ldr	r1, [r3, r2, lsl #2]
	ldrb	r2, [fp, #-15]	@ zero_extendqisi2
	ldr	r3, [fp, #-12]
	and	r3, r3, #7
	lsl	r3, r3, #2
	lsl	r3, r2, r3
	ldr	r2, [fp, #-12]
	asr	r2, r2, #3
	orr	r1, r1, r3
	ldr	r3, [fp, #-8]
	add	r2, r2, #8
	str	r1, [r3, r2, lsl #2]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	gpio_set_af, .-gpio_set_af
	.global	__aeabi_uidiv
	.align	2
	.syntax unified
	.arm
	.type	uart_init, %function
uart_init:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	mov	r3, #7
	strb	r3, [fp, #-9]
	mov	r3, #0
	strh	r3, [fp, #-6]	@ movhi
	mov	r3, #0
	strh	r3, [fp, #-8]	@ movhi
	ldr	r3, [fp, #-16]
	ldr	r2, .L27
	cmp	r3, r2
	bne	.L21
	ldr	r3, .L27+4
	ldr	r3, [r3, #68]
	ldr	r2, .L27+4
	orr	r3, r3, #16
	str	r3, [r2, #68]
.L21:
	ldr	r3, [fp, #-16]
	ldr	r2, .L27+8
	cmp	r3, r2
	bne	.L22
	ldr	r3, .L27+4
	ldr	r3, [r3, #64]
	ldr	r2, .L27+4
	orr	r3, r3, #131072
	str	r3, [r2, #64]
.L22:
	ldr	r3, [fp, #-16]
	ldr	r2, .L27+12
	cmp	r3, r2
	bne	.L23
	ldr	r3, .L27+4
	ldr	r3, [r3, #64]
	ldr	r2, .L27+4
	orr	r3, r3, #262144
	str	r3, [r2, #64]
.L23:
	ldr	r3, [fp, #-16]
	ldr	r2, .L27
	cmp	r3, r2
	bne	.L24
	mov	r3, #9
	strh	r3, [fp, #-8]	@ movhi
	mov	r3, #10
	strh	r3, [fp, #-6]	@ movhi
.L24:
	ldr	r3, [fp, #-16]
	ldr	r2, .L27+8
	cmp	r3, r2
	bne	.L25
	mov	r3, #2
	strh	r3, [fp, #-8]	@ movhi
	mov	r3, #3
	strh	r3, [fp, #-6]	@ movhi
.L25:
	ldr	r3, [fp, #-16]
	ldr	r2, .L27+12
	cmp	r3, r2
	bne	.L26
	mov	r3, #776
	strh	r3, [fp, #-8]	@ movhi
	ldr	r3, .L27+16
	strh	r3, [fp, #-6]	@ movhi
.L26:
	ldrh	r3, [fp, #-8]
	mov	r1, #2
	mov	r0, r3
	bl	gpio_set_mode
	ldrb	r2, [fp, #-9]	@ zero_extendqisi2
	ldrh	r3, [fp, #-8]
	mov	r1, r2
	mov	r0, r3
	bl	gpio_set_af
	ldrh	r3, [fp, #-6]
	mov	r1, #2
	mov	r0, r3
	bl	gpio_set_mode
	ldrb	r2, [fp, #-9]	@ zero_extendqisi2
	ldrh	r3, [fp, #-6]
	mov	r1, r2
	mov	r0, r3
	bl	gpio_set_af
	ldr	r3, [fp, #-16]
	mov	r2, #0
	str	r2, [r3, #12]
	ldr	r1, [fp, #-20]
	ldr	r0, .L27+20
	bl	__aeabi_uidiv
	mov	r3, r0
	mov	r2, r3
	ldr	r3, [fp, #-16]
	str	r2, [r3, #8]
	ldr	r3, [fp, #-16]
	ldr	r3, [r3, #12]
	orr	r3, r3, #8192
	orr	r3, r3, #12
	ldr	r2, [fp, #-16]
	str	r3, [r2, #12]
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L28:
	.align	2
.L27:
	.word	1073811456
	.word	1073887232
	.word	1073759232
	.word	1073760256
	.word	777
	.word	16000000
	.size	uart_init, .-uart_init
	.bss
	.align	2
tm:
	.space	144
	.size	tm, 144
	.text
	.align	2
	.global	create_task
	.syntax unified
	.arm
	.type	create_task, %function
create_task:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	ldr	r3, [fp, #-16]
	add	r3, r3, #2048
	add	r3, r3, #12
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r2, #16777216
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-8]
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mvn	r2, #2
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3]
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L30
.L31:
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L30:
	ldr	r3, [fp, #-12]
	cmp	r3, #7
	ble	.L31
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-20]
	str	r2, [r3, #4]
	ldr	r3, .L32
	ldr	r3, [r3, #140]
	add	r2, r3, #1
	ldr	r3, [fp, #-16]
	str	r2, [r3, #8]
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-8]
	str	r2, [r3]
	ldr	r3, .L32
	ldr	r3, [r3, #140]
	add	r2, r3, #1
	ldr	r1, .L32
	str	r2, [r1, #140]
	ldr	r2, .L32
	add	r3, r3, #2
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r2, [fp, #-16]
	str	r2, [r3, #4]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L33:
	.align	2
.L32:
	.word	tm
	.size	create_task, .-create_task
	.align	2
	.global	start_first_task
	.syntax unified
	.arm
	.type	start_first_task, %function
start_first_task:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	ldr	r3, .L38
	ldr	r3, [r3, #140]
	cmp	r3, #0
	beq	.L37
	ldr	r3, .L38
	ldr	r3, [r3, #12]
	ldr	r2, .L38
	str	r3, [r2]
	ldr	r3, .L38
	ldr	r3, [r3, #12]
	ldr	r3, [r3]
	.syntax divided
@ 59 "main.c" 1
	MSR PSP, r3
@ 0 "" 2
@ 60 "main.c" 1
	MOV R0, #2
@ 0 "" 2
@ 61 "main.c" 1
	MSR CONTROL, R0
@ 0 "" 2
	.arm
	.syntax unified
	ldr	r3, .L38
	ldr	r3, [r3, #12]
	.syntax divided
@ 63 "main.c" 1
	LDR R0, [r3, #0]      
MSR PSP, R0                
LDR R0, [r3, #4]      
BX R0                      

@ 0 "" 2
	.arm
	.syntax unified
	b	.L34
.L37:
	nop
.L34:
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L39:
	.align	2
.L38:
	.word	tm
	.size	start_first_task, .-start_first_task
	.align	2
	.global	start_scheduler
	.syntax unified
	.arm
	.type	start_scheduler, %function
start_scheduler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	ldr	r0, .L41
	bl	systick_init
	bl	start_first_task
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L42:
	.align	2
.L41:
	.word	16000000
	.size	start_scheduler, .-start_scheduler
	.data
	.align	2
	.type	next_task_index, %object
	.size	next_task_index, 4
next_task_index:
	.word	1
	.text
	.align	2
	.syntax unified
	.arm
	.type	reschedule, %function
reschedule:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	ldr	r3, .L48
	ldr	r3, [r3, #140]
	cmp	r3, #1
	beq	.L47
	ldr	r3, .L48
	ldr	r2, [r3, #140]
	ldr	r3, .L48+4
	ldr	r3, [r3]
	cmp	r2, r3
	bhi	.L46
	ldr	r3, .L48+4
	mov	r2, #0
	str	r2, [r3]
.L46:
	ldr	r3, .L48+4
	ldr	r3, [r3]
	add	r2, r3, #1
	ldr	r1, .L48+4
	str	r2, [r1]
	ldr	r2, .L48
	add	r3, r3, #2
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3, #4]
	ldr	r2, .L48
	str	r3, [r2, #4]
	ldr	r3, .L48
	ldr	r3, [r3]
	ldr	r2, .L48
	str	r3, [r2, #8]
	ldr	r3, .L48
	ldr	r3, [r3, #4]
	ldr	r2, .L48
	str	r3, [r2]
	bl	trigger_pendsv
	b	.L43
.L47:
	nop
.L43:
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L49:
	.align	2
.L48:
	.word	tm
	.word	next_task_index
	.size	reschedule, .-reschedule
	.bss
	.align	2
s_ticks:
	.space	4
	.size	s_ticks, 4
	.text
	.align	2
	.global	SysTick_Handler
	.syntax unified
	.arm
	.type	SysTick_Handler, %function
SysTick_Handler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	ldr	r3, .L53
	ldr	r3, [r3]
	add	r3, r3, #1
	ldr	r2, .L53
	str	r3, [r2]
	ldr	r3, .L53
	ldr	r3, [r3]
	and	r3, r3, #1
	cmp	r3, #0
	bne	.L52
	bl	reschedule
.L52:
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L54:
	.align	2
.L53:
	.word	s_ticks
	.size	SysTick_Handler, .-SysTick_Handler
	.bss
	.align	2
s_pendsv_count:
	.space	4
	.size	s_pendsv_count, 4
	.text
	.align	2
	.global	PendSV_Handler
	.syntax unified
	.arm
	.type	PendSV_Handler, %function
PendSV_Handler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	ldr	r3, .L56
	ldr	r3, [r3]
	add	r3, r3, #1
	ldr	r2, .L56
	str	r3, [r2]
	ldr	r3, .L56+4
	ldr	r3, [r3, #8]
	.syntax divided
@ 109 "main.c" 1
	MRS R0, PSP            
STMDB R0!, {R4-R11}    
STR R0, [r3]             

@ 0 "" 2
	.arm
	.syntax unified
	ldr	r3, .L56+4
	ldr	r3, [r3, #4]
	.syntax divided
@ 119 "main.c" 1
	LDR R0, [r3]     
LDMIA R0!, {R4-R11}    
MSR PSP, R0            

@ 0 "" 2
@ 129 "main.c" 1
	BX LR
@ 0 "" 2
	.arm
	.syntax unified
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L57:
	.align	2
.L56:
	.word	s_pendsv_count
	.word	tm
	.size	PendSV_Handler, .-PendSV_Handler
	.section	.rodata
	.align	2
.LC0:
	.ascii	"This is task 1, %d\015\012\000"
	.text
	.align	2
	.global	task1
	.syntax unified
	.arm
	.type	task1, %function
task1:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	mov	r3, #0
	str	r3, [fp, #-8]
.L59:
	ldr	r3, [fp, #-8]
	add	r2, r3, #1
	str	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, .L60
	bl	printf
	ldr	r0, .L60+4
	bl	spin
	b	.L59
.L61:
	.align	2
.L60:
	.word	.LC0
	.word	1000000
	.size	task1, .-task1
	.section	.rodata
	.align	2
.LC1:
	.ascii	"This is task 2, %d\015\012\000"
	.text
	.align	2
	.global	task2
	.syntax unified
	.arm
	.type	task2, %function
task2:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r3, .L64
	str	r3, [fp, #-8]
.L63:
	ldr	r3, [fp, #-8]
	sub	r2, r3, #1
	str	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, .L64+4
	bl	printf
	ldr	r0, .L64+8
	bl	spin
	b	.L63
.L65:
	.align	2
.L64:
	.word	10000000
	.word	.LC1
	.word	1000000
	.size	task2, .-task2
	.section	.rodata
	.align	2
.LC2:
	.ascii	"This is task 3. LED : %d\015\012\000"
	.text
	.align	2
	.global	task3
	.syntax unified
	.arm
	.type	task3, %function
task3:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	mov	r3, #1
	strb	r3, [fp, #-5]
	ldr	r3, .L68
	strh	r3, [fp, #-8]	@ movhi
	ldr	r3, .L68+4
	ldr	r2, [r3, #48]
	ldrh	r3, [fp, #-8]
	lsr	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	mov	r1, r3
	mov	r3, #1
	lsl	r3, r3, r1
	ldr	r1, .L68+4
	orr	r3, r2, r3
	str	r3, [r1, #48]
	ldrh	r3, [fp, #-8]
	mov	r1, #1
	mov	r0, r3
	bl	gpio_set_mode
.L67:
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, .L68+8
	bl	printf
	ldrb	r2, [fp, #-5]	@ zero_extendqisi2
	ldrh	r3, [fp, #-8]
	mov	r1, r2
	mov	r0, r3
	bl	gpio_write
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	cmp	r3, #0
	movne	r3, #1
	moveq	r3, #0
	and	r3, r3, #255
	eor	r3, r3, #1
	and	r3, r3, #255
	strb	r3, [fp, #-5]
	ldrb	r3, [fp, #-5]
	and	r3, r3, #1
	strb	r3, [fp, #-5]
	ldr	r0, .L68+12
	bl	spin
	b	.L67
.L69:
	.align	2
.L68:
	.word	263
	.word	1073887232
	.word	.LC2
	.word	1000000
	.size	task3, .-task3
	.align	2
	.global	main
	.syntax unified
	.arm
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 6184
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #6144
	sub	sp, sp, #40
	ldr	r1, .L72
	ldr	r0, .L72+4
	bl	uart_init
	sub	r3, fp, #2048
	sub	r3, r3, #4
	sub	r3, r3, #12
	ldr	r1, .L72+8
	mov	r0, r3
	bl	create_task
	sub	r3, fp, #4096
	sub	r3, r3, #4
	sub	r3, r3, #24
	ldr	r1, .L72+12
	mov	r0, r3
	bl	create_task
	sub	r3, fp, #6144
	sub	r3, r3, #4
	sub	r3, r3, #36
	ldr	r1, .L72+16
	mov	r0, r3
	bl	create_task
	bl	start_scheduler
.L71:
	b	.L71
.L73:
	.align	2
.L72:
	.word	115200
	.word	1073760256
	.word	task1
	.word	task2
	.word	task3
	.size	main, .-main
	.ident	"GCC: (15:13.2.rel1-2) 13.2.1 20231009"
