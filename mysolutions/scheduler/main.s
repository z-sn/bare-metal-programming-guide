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
task1_stack:
	.space	1024
	.size	task1_stack, 1024
	.align	2
task1_op_stack:
	.space	1024
	.size	task1_op_stack, 1024
	.global	regs_main
	.align	2
	.type	regs_main, %object
	.size	regs_main, 32
regs_main:
	.space	32
	.global	regs_pendsv
	.align	2
	.type	regs_pendsv, %object
	.size	regs_pendsv, 32
regs_pendsv:
	.space	32
	.global	regs_task1
	.align	2
	.type	regs_task1, %object
	.size	regs_task1, 32
regs_task1:
	.space	32
	.align	2
s_task1_counter:
	.space	4
	.size	s_task1_counter, 4
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Starting task 1\015\000"
	.align	2
.LC1:
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
	ldr	r0, .L31
	bl	puts
	bl	save_core_regs_task1
	mov	r3, #0
	str	r3, [fp, #-8]
.L30:
	ldr	r3, [fp, #-8]
	add	r2, r3, #1
	str	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, .L31+4
	bl	printf
	ldr	r0, .L31+8
	bl	spin
	b	.L30
.L32:
	.align	2
.L31:
	.word	.LC0
	.word	.LC1
	.word	1000000
	.size	task1, .-task1
	.bss
	.align	2
task1_sp:
	.space	4
	.size	task1_sp, 4
	.align	2
task1_last_element:
	.space	4
	.size	task1_last_element, 4
	.text
	.align	2
	.global	set_PSP
	.syntax unified
	.arm
	.type	set_PSP, %function
set_PSP:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	.syntax divided
@ 39 "main.c" 1
	MSR PSP, r3
@ 0 "" 2
	.arm
	.syntax unified
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	set_PSP, .-set_PSP
	.align	2
	.global	create_task
	.syntax unified
	.arm
	.type	create_task, %function
create_task:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	ldr	r3, .L37
	ldr	r2, .L37+4
	str	r2, [r3]
	ldr	r3, .L37
	ldr	r3, [r3]
	ldr	r2, .L37+8
	str	r3, [r2]
	ldr	r3, .L37
	ldr	r3, [r3]
	sub	r3, r3, #4
	ldr	r2, .L37
	str	r3, [r2]
	ldr	r3, .L37
	ldr	r3, [r3]
	mov	r2, #16777216
	str	r2, [r3]
	ldr	r3, .L37
	ldr	r3, [r3]
	sub	r3, r3, #4
	ldr	r2, .L37
	str	r3, [r2]
	ldr	r3, .L37
	ldr	r3, [r3]
	ldr	r2, .L37+12
	str	r2, [r3]
	ldr	r3, .L37
	ldr	r3, [r3]
	sub	r3, r3, #4
	ldr	r2, .L37
	str	r3, [r2]
	ldr	r3, .L37
	ldr	r3, [r3]
	mvn	r2, #2
	str	r2, [r3]
	ldr	r3, .L37
	ldr	r2, .L37+16
	str	r2, [r3]
	ldr	r3, .L37
	ldr	r3, [r3]
	sub	r3, r3, #4
	ldr	r2, .L37
	str	r3, [r2]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L35
.L36:
	ldr	r3, .L37
	ldr	r3, [r3]
	sub	r3, r3, #4
	ldr	r2, .L37
	str	r3, [r2]
	ldr	r3, .L37
	ldr	r3, [r3]
	mov	r2, #0
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L35:
	ldr	r3, [fp, #-8]
	cmp	r3, #12
	ble	.L36
	nop
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L38:
	.align	2
.L37:
	.word	task1_sp
	.word	task1_stack+1024
	.word	task1_last_element
	.word	task1
	.word	task1_op_stack+1024
	.size	create_task, .-create_task
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
	ldr	r3, .L40
	.syntax divided
@ 67 "main.c" 1
	LDR R0, [r3]    
LDMIA SP!, {R0-R12}   
LDR PC, =task1        

@ 0 "" 2
	.arm
	.syntax unified
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L41:
	.align	2
.L40:
	.word	task1_sp
	.size	PendSV_Handler, .-PendSV_Handler
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
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	ldr	r3, .L43
	ldr	r3, [r3]
	add	r3, r3, #1
	ldr	r2, .L43
	str	r3, [r2]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L44:
	.align	2
.L43:
	.word	s_ticks
	.size	SysTick_Handler, .-SysTick_Handler
	.align	2
	.syntax unified
	.arm
	.type	elapsed_time, %function
elapsed_time:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-12]
	sub	r3, r2, r3
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	elapsed_time, .-elapsed_time
	.align	2
	.syntax unified
	.arm
	.type	save_core_regs_main, %function
save_core_regs_main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, fp, lr}
	add	fp, sp, #16
	.syntax divided
@ 92 "main.c" 1
	MOV r5, R0        
MOV r4, R1        
MOV lr, R2        
MOV ip, R3        
MOV r0, R12       
MOV r1, LR        
MOV r2, PC        
MRS r3, PSR       

@ 0 "" 2
	.arm
	.syntax unified
	ldr	r6, .L48
	str	r5, [r6]
	ldr	r5, .L48
	str	r4, [r5, #4]
	ldr	r4, .L48
	str	lr, [r4, #8]
	ldr	lr, .L48
	str	ip, [lr, #12]
	ldr	ip, .L48
	str	r0, [ip, #16]
	ldr	r0, .L48
	str	r1, [r0, #20]
	ldr	r1, .L48
	str	r2, [r1, #24]
	ldr	r2, .L48
	str	r3, [r2, #28]
	nop
	sub	sp, fp, #16
	@ sp needed
	pop	{r4, r5, r6, fp, lr}
	bx	lr
.L49:
	.align	2
.L48:
	.word	regs_main
	.size	save_core_regs_main, .-save_core_regs_main
	.align	2
	.syntax unified
	.arm
	.type	save_core_regs_task1, %function
save_core_regs_task1:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, fp, lr}
	add	fp, sp, #16
	.syntax divided
@ 134 "main.c" 1
	MOV r5, R0         
MOV r4, R1         
MOV lr, R2         
MOV ip, R3         
MOV r0, R12        
MOV r1, LR         
MOV r2, PC         
MRS r3, PSR       

@ 0 "" 2
	.arm
	.syntax unified
	ldr	r6, .L51
	str	r5, [r6]
	ldr	r5, .L51
	str	r4, [r5, #4]
	ldr	r4, .L51
	str	lr, [r4, #8]
	ldr	lr, .L51
	str	ip, [lr, #12]
	ldr	ip, .L51
	str	r0, [ip, #16]
	ldr	r0, .L51
	str	r1, [r0, #20]
	ldr	r1, .L51
	str	r2, [r1, #24]
	ldr	r2, .L51
	str	r3, [r2, #28]
	nop
	sub	sp, fp, #16
	@ sp needed
	pop	{r4, r5, r6, fp, lr}
	bx	lr
.L52:
	.align	2
.L51:
	.word	regs_task1
	.size	save_core_regs_task1, .-save_core_regs_task1
	.section	.rodata
	.align	2
.LC2:
	.ascii	"%s\015\012\000"
	.align	2
.LC3:
	.ascii	"xPSR : 0x%lX \015\012\000"
	.align	2
.LC4:
	.ascii	"PC   : 0x%lX \015\012\000"
	.align	2
.LC5:
	.ascii	"LR   : 0x%lX \015\012\000"
	.align	2
.LC6:
	.ascii	"R12  : 0x%lX \015\012\000"
	.align	2
.LC7:
	.ascii	"R3   : 0x%lX \015\012\000"
	.align	2
.LC8:
	.ascii	"R2   : 0x%lX \015\012\000"
	.align	2
.LC9:
	.ascii	"R1   : 0x%lX \015\012\000"
	.align	2
.LC10:
	.ascii	"R0   : 0x%lX \015\012\000"
	.text
	.align	2
	.syntax unified
	.arm
	.type	print_core_regs, %function
print_core_regs:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r1, [fp, #-12]
	ldr	r0, .L54
	bl	printf
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #28]
	mov	r1, r3
	ldr	r0, .L54+4
	bl	printf
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #24]
	mov	r1, r3
	ldr	r0, .L54+8
	bl	printf
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #20]
	mov	r1, r3
	ldr	r0, .L54+12
	bl	printf
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #16]
	mov	r1, r3
	ldr	r0, .L54+16
	bl	printf
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #12]
	mov	r1, r3
	ldr	r0, .L54+20
	bl	printf
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #8]
	mov	r1, r3
	ldr	r0, .L54+24
	bl	printf
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #4]
	mov	r1, r3
	ldr	r0, .L54+28
	bl	printf
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	mov	r1, r3
	ldr	r0, .L54+32
	bl	printf
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L55:
	.align	2
.L54:
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.size	print_core_regs, .-print_core_regs
	.section	.rodata
	.align	2
.LC11:
	.ascii	"#### main ####\000"
	.align	2
.LC12:
	.ascii	"#### pendsv ####\000"
	.align	2
.LC13:
	.ascii	"#### task1 ####\000"
	.align	2
.LC14:
	.ascii	"Done switching (This should not be printed if conte"
	.ascii	"xt is switched to task1.)\015\000"
	.align	2
.LC15:
	.ascii	"Wait done\015\000"
	.align	2
.LC16:
	.ascii	"%d  : LED : %d, tick: %lu, pendsv : %lu, task1 coun"
	.ascii	"ter : %lu\015\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	ldr	r3, .L59
	strh	r3, [fp, #-18]	@ movhi
	ldr	r3, .L59+4
	ldr	r2, [r3, #48]
	ldrh	r3, [fp, #-18]
	lsr	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	mov	r1, r3
	mov	r3, #1
	lsl	r3, r3, r1
	ldr	r1, .L59+4
	orr	r3, r2, r3
	str	r3, [r1, #48]
	mov	r0, #16000
	bl	systick_init
	ldrh	r3, [fp, #-18]
	mov	r1, #1
	mov	r0, r3
	bl	gpio_set_mode
	ldr	r1, .L59+8
	ldr	r0, .L59+12
	bl	uart_init
	ldr	r3, .L59+16
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3, #1
	strb	r3, [fp, #-9]
	mov	r3, #0
	str	r3, [fp, #-16]
	bl	save_core_regs_main
	ldr	r1, .L59+20
	ldr	r0, .L59+24
	bl	print_core_regs
	bl	create_task
	bl	trigger_pendsv
	ldr	r1, .L59+28
	ldr	r0, .L59+32
	bl	print_core_regs
	ldr	r1, .L59+36
	ldr	r0, .L59+40
	bl	print_core_regs
	ldr	r0, .L59+44
	bl	puts
	ldr	r0, .L59+48
	bl	spin
	ldr	r0, .L59+52
	bl	puts
.L58:
	ldr	r3, .L59+16
	ldr	r3, [r3]
	ldr	r1, [fp, #-8]
	mov	r0, r3
	bl	elapsed_time
	mov	r3, r0
	cmp	r3, #500
	bls	.L58
	ldrb	r2, [fp, #-9]	@ zero_extendqisi2
	ldrh	r3, [fp, #-18]
	mov	r1, r2
	mov	r0, r3
	bl	gpio_write
	ldrb	r3, [fp, #-9]	@ zero_extendqisi2
	cmp	r3, #0
	movne	r3, #1
	moveq	r3, #0
	and	r3, r3, #255
	eor	r3, r3, #1
	and	r3, r3, #255
	strb	r3, [fp, #-9]
	ldrb	r3, [fp, #-9]
	and	r3, r3, #1
	strb	r3, [fp, #-9]
	ldr	r3, .L59+16
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	ldrb	r1, [fp, #-9]	@ zero_extendqisi2
	ldr	r3, .L59+16
	ldr	r0, [r3]
	ldr	r3, .L59+56
	ldr	r3, [r3]
	ldr	r2, .L59+60
	ldr	r2, [r2]
	str	r2, [sp, #4]
	str	r3, [sp]
	mov	r3, r0
	mov	r2, r1
	ldr	r1, [fp, #-16]
	ldr	r0, .L59+64
	bl	printf
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
	b	.L58
.L60:
	.align	2
.L59:
	.word	263
	.word	1073887232
	.word	115200
	.word	1073760256
	.word	s_ticks
	.word	.LC11
	.word	regs_main
	.word	.LC12
	.word	regs_pendsv
	.word	.LC13
	.word	regs_task1
	.word	.LC14
	.word	1000000000
	.word	.LC15
	.word	s_pendsv_count
	.word	s_task1_counter
	.word	.LC16
	.size	main, .-main
	.ident	"GCC: (15:13.2.rel1-2) 13.2.1 20231009"