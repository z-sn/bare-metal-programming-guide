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
	.bss
	.align	2
tm:
	.space	64
	.size	tm, 64
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
	b	.L27
.L28:
	ldr	r3, [fp, #-8]
	sub	r3, r3, #4
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L27:
	ldr	r3, [fp, #-12]
	cmp	r3, #7
	ble	.L28
	ldr	r3, .L29
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r3, [fp, #-16]
	str	r2, [r3, #8]
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-8]
	str	r2, [r3]
	ldr	r3, .L29
	ldr	r3, [r3, #60]
	add	r2, r3, #1
	ldr	r1, .L29
	str	r2, [r1, #60]
	ldr	r2, .L29
	add	r3, r3, #4
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r2, [fp, #-16]
	str	r2, [r3, #4]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L30:
	.align	2
.L29:
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
	ldr	r3, .L35
	ldr	r3, [r3, #60]
	cmp	r3, #0
	beq	.L34
	ldr	r3, .L35
	ldr	r3, [r3, #20]
	ldr	r2, .L35
	str	r3, [r2]
	ldr	r3, .L35
	ldr	r3, [r3, #20]
	ldr	r3, [r3]
	.syntax divided
@ 58 "main.c" 1
	MSR PSP, r3
@ 0 "" 2
@ 59 "main.c" 1
	MOV R0, #2
@ 0 "" 2
@ 60 "main.c" 1
	MSR CONTROL, R0
@ 0 "" 2
	.arm
	.syntax unified
	ldr	r3, .L35
	ldr	r3, [r3, #20]
	.syntax divided
@ 62 "main.c" 1
	LDR R0, [r3, #0]      
MSR PSP, R0                
LDR R0, [r3, #4]      
BX R0                      

@ 0 "" 2
	.arm
	.syntax unified
	b	.L31
.L34:
	nop
.L31:
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L36:
	.align	2
.L35:
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
	ldr	r0, .L38
	bl	systick_init
	bl	start_first_task
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L39:
	.align	2
.L38:
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
	ldr	r3, .L45
	ldr	r3, [r3, #60]
	cmp	r3, #1
	beq	.L44
	ldr	r3, .L45
	ldr	r2, [r3, #60]
	ldr	r3, .L45+4
	ldr	r3, [r3]
	cmp	r2, r3
	bhi	.L43
	ldr	r3, .L45+4
	mov	r2, #0
	str	r2, [r3]
.L43:
	ldr	r3, .L45+4
	ldr	r3, [r3]
	add	r2, r3, #1
	ldr	r1, .L45+4
	str	r2, [r1]
	ldr	r2, .L45
	add	r3, r3, #4
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3, #4]
	ldr	r2, .L45
	str	r3, [r2, #4]
	ldr	r3, .L45
	ldr	r3, [r3, #4]
	ldr	r2, .L45
	str	r3, [r2]
	bl	trigger_pendsv
	b	.L40
.L44:
	nop
.L40:
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L46:
	.align	2
.L45:
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
	ldr	r3, .L50
	ldr	r3, [r3]
	add	r3, r3, #1
	ldr	r2, .L50
	str	r3, [r2]
	ldr	r3, .L50
	ldr	r1, [r3]
	ldr	r3, .L50+4
	umull	r2, r3, r1, r3
	lsr	r2, r3, #3
	mov	r3, r2
	lsl	r3, r3, #2
	add	r3, r3, r2
	lsl	r3, r3, #1
	sub	r2, r1, r3
	cmp	r2, #0
	bne	.L49
	bl	reschedule
.L49:
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L51:
	.align	2
.L50:
	.word	s_ticks
	.word	-858993459
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
	ldr	r3, .L53
	ldr	r3, [r3]
	add	r3, r3, #1
	ldr	r2, .L53
	str	r3, [r2]
	ldr	r3, .L53+4
	ldr	r3, [r3, #8]
	.syntax divided
@ 108 "main.c" 1
	MRS R0, PSP            
STMDB R0!, {R4-R11}    
STR R0, [r3]             

@ 0 "" 2
	.arm
	.syntax unified
	ldr	r3, .L53+4
	ldr	r3, [r3, #4]
	.syntax divided
@ 118 "main.c" 1
	LDR R0, [r3]     
LDMIA R0!, {R4-R11}    
MSR PSP, R0            

@ 0 "" 2
@ 128 "main.c" 1
	BX LR
@ 0 "" 2
	.arm
	.syntax unified
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L54:
	.align	2
.L53:
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
.L56:
	ldr	r3, [fp, #-8]
	add	r2, r3, #1
	str	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, .L57
	bl	printf
	ldr	r0, .L57+4
	bl	spin
	b	.L56
.L58:
	.align	2
.L57:
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
	ldr	r3, .L61
	str	r3, [fp, #-8]
.L60:
	ldr	r3, [fp, #-8]
	sub	r2, r3, #1
	str	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, .L61+4
	bl	printf
	ldr	r0, .L61+8
	bl	spin
	b	.L60
.L62:
	.align	2
.L61:
	.word	10000000
	.word	.LC1
	.word	1000000
	.size	task2, .-task2
	.align	2
	.global	main
	.syntax unified
	.arm
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 4136
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #4096
	sub	sp, sp, #40
	ldr	r3, .L65
	strh	r3, [fp, #-12]	@ movhi
	ldr	r3, .L65+4
	ldr	r2, [r3, #48]
	ldrh	r3, [fp, #-12]
	lsr	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	mov	r1, r3
	mov	r3, #1
	lsl	r3, r3, r1
	ldr	r1, .L65+4
	orr	r3, r2, r3
	str	r3, [r1, #48]
	ldr	r0, .L65+8
	bl	systick_init
	ldrh	r3, [fp, #-12]
	mov	r1, #1
	mov	r0, r3
	bl	gpio_set_mode
	ldr	r1, .L65+12
	ldr	r0, .L65+16
	bl	uart_init
	ldr	r3, .L65+20
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3, #1
	strb	r3, [fp, #-9]
	mov	r3, #0
	str	r3, [fp, #-16]
	sub	r3, fp, #2064
	sub	r3, r3, #4
	sub	r3, r3, #8
	ldr	r1, .L65+24
	mov	r0, r3
	bl	create_task
	sub	r3, fp, #4096
	sub	r3, r3, #4
	sub	r3, r3, #36
	ldr	r1, .L65+28
	mov	r0, r3
	bl	create_task
	bl	start_scheduler
.L64:
	b	.L64
.L66:
	.align	2
.L65:
	.word	263
	.word	1073887232
	.word	16000000
	.word	115200
	.word	1073760256
	.word	s_ticks
	.word	task1
	.word	task2
	.size	main, .-main
	.ident	"GCC: (15:13.2.rel1-2) 13.2.1 20231009"
