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
	bcs	.L13
	ldr	r2, .L14
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	str	r3, [r2, #4]
	ldr	r3, .L14
	mov	r2, #0
	str	r2, [r3, #8]
	ldr	r3, .L14
	mov	r2, #7
	str	r2, [r3]
	ldr	r3, .L14+4
	ldr	r3, [r3, #68]
	ldr	r2, .L14+4
	orr	r3, r3, #16384
	str	r3, [r2, #68]
	b	.L10
.L13:
	nop
.L10:
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L15:
	.align	2
.L14:
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
	ldr	r2, .L24
	cmp	r3, r2
	bne	.L18
	ldr	r3, .L24+4
	ldr	r3, [r3, #68]
	ldr	r2, .L24+4
	orr	r3, r3, #16
	str	r3, [r2, #68]
.L18:
	ldr	r3, [fp, #-16]
	ldr	r2, .L24+8
	cmp	r3, r2
	bne	.L19
	ldr	r3, .L24+4
	ldr	r3, [r3, #64]
	ldr	r2, .L24+4
	orr	r3, r3, #131072
	str	r3, [r2, #64]
.L19:
	ldr	r3, [fp, #-16]
	ldr	r2, .L24+12
	cmp	r3, r2
	bne	.L20
	ldr	r3, .L24+4
	ldr	r3, [r3, #64]
	ldr	r2, .L24+4
	orr	r3, r3, #262144
	str	r3, [r2, #64]
.L20:
	ldr	r3, [fp, #-16]
	ldr	r2, .L24
	cmp	r3, r2
	bne	.L21
	mov	r3, #9
	strh	r3, [fp, #-8]	@ movhi
	mov	r3, #10
	strh	r3, [fp, #-6]	@ movhi
.L21:
	ldr	r3, [fp, #-16]
	ldr	r2, .L24+8
	cmp	r3, r2
	bne	.L22
	mov	r3, #2
	strh	r3, [fp, #-8]	@ movhi
	mov	r3, #3
	strh	r3, [fp, #-6]	@ movhi
.L22:
	ldr	r3, [fp, #-16]
	ldr	r2, .L24+12
	cmp	r3, r2
	bne	.L23
	mov	r3, #776
	strh	r3, [fp, #-8]	@ movhi
	ldr	r3, .L24+16
	strh	r3, [fp, #-6]	@ movhi
.L23:
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
	ldr	r0, .L24+20
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
.L25:
	.align	2
.L24:
	.word	1073811456
	.word	1073887232
	.word	1073759232
	.word	1073760256
	.word	777
	.word	16000000
	.size	uart_init, .-uart_init
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
@ 9 "main.c" 1
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
	.global	tcb_scheduler
	.bss
	.align	2
	.type	tcb_scheduler, %object
	.size	tcb_scheduler, 2060
tcb_scheduler:
	.space	2060
	.global	tcb_task1
	.align	2
	.type	tcb_task1, %object
	.size	tcb_task1, 2060
tcb_task1:
	.space	2060
	.global	tcb_task2
	.align	2
	.type	tcb_task2, %object
	.size	tcb_task2, 2060
tcb_task2:
	.space	2060
	.text
	.align	2
	.global	create_task_tcb
	.syntax unified
	.arm
	.type	create_task_tcb, %function
create_task_tcb:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	add	r3, r3, #2048
	add	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r2, #16777216
	str	r2, [r3]
	ldr	r3, [fp, #-16]
	ldr	r2, [r3, #2052]
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
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
	b	.L28
.L29:
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L28:
	ldr	r3, [fp, #-12]
	cmp	r3, #7
	ble	.L29
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-8]
	str	r2, [r3, #2056]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	create_task_tcb, .-create_task_tcb
	.bss
	.align	2
task_switch_count:
	.space	4
	.size	task_switch_count, 4
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Scheduling %lu\015\012\000"
	.text
	.align	2
	.global	task_scheduler
	.syntax unified
	.arm
	.type	task_scheduler, %function
task_scheduler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
.L31:
	ldr	r3, .L32
	ldr	r3, [r3]
	add	r2, r3, #1
	ldr	r1, .L32
	str	r2, [r1]
	mov	r1, r3
	ldr	r0, .L32+4
	bl	printf
	ldr	r0, .L32+8
	bl	spin
	b	.L31
.L33:
	.align	2
.L32:
	.word	task_switch_count
	.word	.LC0
	.word	1000000
	.size	task_scheduler, .-task_scheduler
	.bss
	.align	2
current_task_id:
	.space	4
	.size	current_task_id, 4
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
	mov	r3, #0
	str	r3, [fp, #-8]
.L35:
	ldr	r3, [fp, #-8]
	add	r2, r3, #1
	str	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, .L36
	bl	printf
	ldr	r0, .L36+4
	bl	spin
	b	.L35
.L37:
	.align	2
.L36:
	.word	.LC1
	.word	4000000
	.size	task2, .-task2
	.bss
	.align	2
s_task1_counter:
	.space	4
	.size	s_task1_counter, 4
	.section	.rodata
	.align	2
.LC2:
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
.L39:
	ldr	r3, [fp, #-8]
	add	r2, r3, #1
	str	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, .L40
	bl	printf
	ldr	r0, .L40+4
	bl	spin
	b	.L39
.L41:
	.align	2
.L40:
	.word	.LC2
	.word	4000000
	.size	task1, .-task1
	.bss
	.align	2
s_pendsv_count:
	.space	4
	.size	s_pendsv_count, 4
	.align	2
current_task_sp:
	.space	4
	.size	current_task_sp, 4
	.align	2
next_task_sp:
	.space	4
	.size	next_task_sp, 4
	.align	2
sp_before:
	.space	4
	.size	sp_before, 4
	.align	2
sp_after:
	.space	4
	.size	sp_after, 4
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
	ldr	r3, .L45
	ldr	r3, [r3]
	ldr	r2, .L45+4
	str	r3, [r2]
	ldr	r3, .L45
	.syntax divided
@ 84 "main.c" 1
	MRS R0, PSP            
STMDB R0!, {R4-R11}    
STR R0, [r3]             

@ 0 "" 2
	.arm
	.syntax unified
	ldr	r3, .L45
	ldr	r3, [r3]
	ldr	r2, .L45+8
	str	r3, [r2]
	ldr	r3, .L45+12
	ldr	r2, [r3]
	ldr	r3, .L45+16
	ldr	r3, [r3]
	cmp	r2, r3
	bne	.L43
	ldr	r3, .L45
	ldr	r3, [r3]
	ldr	r2, .L45+12
	str	r3, [r2, #2056]
	ldr	r3, .L45+20
	ldr	r3, [r3, #2056]
	ldr	r2, .L45
	str	r3, [r2]
	ldr	r3, .L45+20
	ldr	r3, [r3, #2056]
	ldr	r2, .L45+24
	str	r3, [r2]
	ldr	r3, .L45+16
	mov	r2, #2
	str	r2, [r3]
	b	.L44
.L43:
	ldr	r3, .L45
	ldr	r3, [r3]
	ldr	r2, .L45+20
	str	r3, [r2, #2056]
	ldr	r3, .L45+12
	ldr	r3, [r3, #2056]
	ldr	r2, .L45
	str	r3, [r2]
	ldr	r3, .L45+12
	ldr	r3, [r3, #2056]
	ldr	r2, .L45+24
	str	r3, [r2]
	ldr	r3, .L45+16
	mov	r2, #1
	str	r2, [r3]
.L44:
	ldr	r3, .L45+24
	.syntax divided
@ 109 "main.c" 1
	LDR R0, [r3]     
LDMIA R0!, {R4-R11}    
MSR PSP, R0            

@ 0 "" 2
@ 117 "main.c" 1
	BX LR
@ 0 "" 2
	.arm
	.syntax unified
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L46:
	.align	2
.L45:
	.word	current_task_sp
	.word	sp_before
	.word	sp_after
	.word	tcb_task1
	.word	current_task_id
	.word	tcb_task2
	.word	next_task_sp
	.size	PendSV_Handler, .-PendSV_Handler
	.bss
	.align	2
s_ticks:
	.space	4
	.size	s_ticks, 4
	.section	.rodata
	.align	2
.LC3:
	.ascii	"SysTick Handler %lu, cur_sp=%p, next_sp=%p, task1_s"
	.ascii	"p=%p, task2_sp=%p, current_task_id=%ld, sp_before=%"
	.ascii	"p, sp_after=%p \015\012\000"
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
	push	{r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #24
	ldr	r3, .L50
	ldr	lr, [r3]
	ldr	r3, .L50+4
	ldr	r4, [r3]
	ldr	r3, .L50+8
	ldr	r5, [r3]
	ldr	r3, .L50+12
	ldr	r3, [r3, #2056]
	ldr	r2, .L50+16
	ldr	r2, [r2, #2056]
	ldr	r1, .L50+20
	ldr	r1, [r1]
	ldr	r0, .L50+24
	ldr	r0, [r0]
	ldr	ip, .L50+28
	ldr	ip, [ip]
	str	ip, [sp, #16]
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	str	r2, [sp, #4]
	str	r3, [sp]
	mov	r3, r5
	mov	r2, r4
	mov	r1, lr
	ldr	r0, .L50+32
	bl	printf
	ldr	r3, .L50
	ldr	r3, [r3]
	add	r3, r3, #1
	ldr	r2, .L50
	str	r3, [r2]
	ldr	r3, .L50
	ldr	r1, [r3]
	ldr	r3, .L50+36
	umull	r2, r3, r1, r3
	lsr	r2, r3, #3
	mov	r3, r2
	lsl	r3, r3, #2
	add	r3, r3, r2
	lsl	r3, r3, #1
	sub	r2, r1, r3
	cmp	r2, #0
	bne	.L49
	bl	trigger_pendsv
.L49:
	nop
	sub	sp, fp, #12
	@ sp needed
	pop	{r4, r5, fp, lr}
	bx	lr
.L51:
	.align	2
.L50:
	.word	s_ticks
	.word	current_task_sp
	.word	next_task_sp
	.word	tcb_task1
	.word	tcb_task2
	.word	current_task_id
	.word	sp_before
	.word	sp_after
	.word	.LC3
	.word	-858993459
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
	.bss
	.align	2
sched_start:
	.space	4
	.size	sched_start, 4
	.text
	.align	2
	.global	reschedule
	.syntax unified
	.arm
	.type	reschedule, %function
reschedule:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	ldr	r3, .L58
	ldr	r3, [r3]
	ldr	r2, .L58+4
	ldr	r2, [r2]
	mov	r1, r2
	mov	r0, r3
	bl	elapsed_time
	mov	r3, r0
	cmp	r3, #10
	bls	.L55
	ldr	r3, .L58
	ldr	r3, [r3]
	ldr	r2, .L58+4
	str	r3, [r2]
	ldr	r3, .L58+8
	ldr	r2, [r3]
	ldr	r3, .L58+12
	ldr	r3, [r3]
	cmp	r2, r3
	bne	.L56
	ldr	r3, .L58+16
	ldr	r3, [r3, #2056]
	b	.L57
.L56:
	ldr	r3, .L58+8
	ldr	r3, [r3, #2056]
	b	.L57
.L55:
	mov	r3, #0
.L57:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L59:
	.align	2
.L58:
	.word	s_ticks
	.word	sched_start
	.word	tcb_task1
	.word	current_task_id
	.word	tcb_task2
	.size	reschedule, .-reschedule
	.section	.rodata
	.align	2
.LC4:
	.ascii	"Before first pendsv. cur_sp=%p, next_sp=%p, task1_s"
	.ascii	"p=%p, task2_sp=%p\015\012\000"
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
	ldr	r3, .L62
	strh	r3, [fp, #-14]	@ movhi
	ldr	r3, .L62+4
	ldr	r2, [r3, #48]
	ldrh	r3, [fp, #-14]
	lsr	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	mov	r1, r3
	mov	r3, #1
	lsl	r3, r3, r1
	ldr	r1, .L62+4
	orr	r3, r2, r3
	str	r3, [r1, #48]
	ldr	r0, .L62+8
	bl	systick_init
	ldrh	r3, [fp, #-14]
	mov	r1, #1
	mov	r0, r3
	bl	gpio_set_mode
	ldr	r1, .L62+12
	ldr	r0, .L62+16
	bl	uart_init
	ldr	r3, .L62+20
	ldr	r3, [r3]
	str	r3, [fp, #-20]
	mov	r3, #1
	strb	r3, [fp, #-5]
	mov	r3, #0
	str	r3, [fp, #-12]
	ldr	r3, .L62+24
	mov	r2, #99
	str	r2, [r3]
	ldr	r3, .L62+24
	ldr	r2, .L62+28
	str	r2, [r3, #2052]
	ldr	r0, .L62+24
	bl	create_task_tcb
	ldr	r3, .L62+32
	mov	r2, #1
	str	r2, [r3]
	ldr	r3, .L62+32
	ldr	r2, .L62+36
	str	r2, [r3, #2052]
	ldr	r0, .L62+32
	bl	create_task_tcb
	ldr	r3, .L62+40
	mov	r2, #2
	str	r2, [r3]
	ldr	r3, .L62+40
	ldr	r2, .L62+44
	str	r2, [r3, #2052]
	ldr	r0, .L62+40
	bl	create_task_tcb
	ldr	r3, .L62+32
	ldr	r3, [r3, #2056]
	ldr	r2, .L62+48
	str	r3, [r2]
	ldr	r3, .L62+32
	ldr	r3, [r3]
	ldr	r2, .L62+52
	str	r3, [r2]
	ldr	r3, .L62+40
	ldr	r3, [r3, #2056]
	ldr	r2, .L62+56
	str	r3, [r2]
	ldr	r3, .L62+48
	ldr	r1, [r3]
	ldr	r3, .L62+56
	ldr	r2, [r3]
	ldr	r3, .L62+32
	ldr	r0, [r3, #2056]
	ldr	r3, .L62+40
	ldr	r3, [r3, #2056]
	str	r3, [sp]
	mov	r3, r0
	ldr	r0, .L62+60
	bl	printf
	ldr	r3, .L62+48
	ldr	r3, [r3]
	.syntax divided
@ 219 "main.c" 1
	MSR PSP, r3
@ 0 "" 2
@ 220 "main.c" 1
	MOV R0, #2
@ 0 "" 2
@ 221 "main.c" 1
	MSR CONTROL, R0
@ 0 "" 2
	.arm
	.syntax unified
	ldr	r3, .L62+48
	ldr	r1, [r3]
	ldr	r3, .L62+56
	ldr	r2, [r3]
	ldr	r3, .L62+32
	ldr	r0, [r3, #2056]
	ldr	r3, .L62+40
	ldr	r3, [r3, #2056]
	str	r3, [sp]
	mov	r3, r0
	ldr	r0, .L62+60
	bl	printf
	bl	trigger_pendsv
.L61:
	ldr	r0, .L62+64
	bl	spin
	b	.L61
.L63:
	.align	2
.L62:
	.word	263
	.word	1073887232
	.word	16000000
	.word	115200
	.word	1073760256
	.word	s_ticks
	.word	tcb_scheduler
	.word	task_scheduler
	.word	tcb_task1
	.word	task1
	.word	tcb_task2
	.word	task2
	.word	current_task_sp
	.word	current_task_id
	.word	next_task_sp
	.word	.LC4
	.word	100000
	.size	main, .-main
	.ident	"GCC: (15:13.2.rel1-2) 13.2.1 20231009"
