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
	.space	60
	.size	tm, 60
	.global	tcb_scheduler
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
	.align	2
current_task_id:
	.space	4
	.size	current_task_id, 4
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
	ldr	r3, [fp, #-16]
	ldr	r2, [r3, #4]
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
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-8]
	str	r2, [r3]
	ldr	r3, .L29
	ldr	r3, [r3, #56]
	add	r2, r3, #1
	ldr	r1, .L29
	str	r2, [r1, #56]
	ldr	r1, .L29
	add	r3, r3, #4
	ldr	r2, [fp, #-16]
	str	r2, [r1, r3, lsl #2]
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
	.syntax unified
	.arm
	.type	reschedule, %function
reschedule:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	ldr	r3, .L35
	ldr	r2, [r3]
	ldr	r3, .L35
	ldr	r3, [r3, #16]
	cmp	r2, r3
	bne	.L32
	ldr	r3, .L35
	ldr	r3, [r3, #20]
	ldr	r2, .L35
	str	r3, [r2, #4]
	b	.L34
.L32:
	ldr	r3, .L35
	ldr	r3, [r3, #16]
	ldr	r2, .L35
	str	r3, [r2, #4]
.L34:
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L36:
	.align	2
.L35:
	.word	tm
	.size	reschedule, .-reschedule
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
.L38:
	ldr	r3, [fp, #-8]
	add	r2, r3, #1
	str	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, .L39
	bl	printf
	ldr	r0, .L39+4
	bl	spin
	b	.L38
.L40:
	.align	2
.L39:
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
	ldr	r3, .L43
	str	r3, [fp, #-8]
.L42:
	ldr	r3, [fp, #-8]
	sub	r2, r3, #1
	str	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, .L43+4
	bl	printf
	ldr	r0, .L43+8
	bl	spin
	b	.L42
.L44:
	.align	2
.L43:
	.word	10000000
	.word	.LC1
	.word	1000000
	.size	task2, .-task2
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
	ldr	r3, .L46
	ldr	r3, [r3, #16]
	ldr	r2, .L46
	str	r3, [r2]
	ldr	r3, .L46
	ldr	r3, [r3, #16]
	ldr	r3, [r3]
	.syntax divided
@ 96 "main.c" 1
	MSR PSP, r3
@ 0 "" 2
@ 97 "main.c" 1
	MOV R0, #2
@ 0 "" 2
@ 98 "main.c" 1
	MSR CONTROL, R0
@ 0 "" 2
	.arm
	.syntax unified
	ldr	r3, .L46
	ldr	r3, [r3, #16]
	.syntax divided
@ 100 "main.c" 1
	LDR R0, [r3, #0]      
MSR PSP, R0                
LDR R0, [r3, #4]      
BX R0                      

@ 0 "" 2
	.arm
	.syntax unified
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L47:
	.align	2
.L46:
	.word	tm
	.size	start_first_task, .-start_first_task
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
	ldr	r3, .L49
	ldr	r3, [r3]
	add	r3, r3, #1
	ldr	r2, .L49
	str	r3, [r2]
	ldr	r3, .L49+4
	ldr	r3, [r3]
	.syntax divided
@ 154 "main.c" 1
	MRS R0, PSP            
STMDB R0!, {R4-R11}    
STR R0, [r3]             

@ 0 "" 2
	.arm
	.syntax unified
	ldr	r3, .L49+4
	ldr	r3, [r3, #4]
	.syntax divided
@ 164 "main.c" 1
	LDR R0, [r3]     
LDMIA R0!, {R4-R11}    
MSR PSP, R0            

@ 0 "" 2
	.arm
	.syntax unified
	ldr	r3, .L49+4
	ldr	r3, [r3, #4]
	ldr	r2, .L49+4
	str	r3, [r2]
	.syntax divided
@ 174 "main.c" 1
	BX LR
@ 0 "" 2
	.arm
	.syntax unified
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L50:
	.align	2
.L49:
	.word	s_pendsv_count
	.word	tm
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
	push	{fp, lr}
	add	fp, sp, #4
	ldr	r3, .L54
	ldr	r3, [r3]
	add	r3, r3, #1
	ldr	r2, .L54
	str	r3, [r2]
	ldr	r3, .L54
	ldr	r1, [r3]
	ldr	r3, .L54+4
	umull	r2, r3, r1, r3
	lsr	r2, r3, #3
	mov	r3, r2
	lsl	r3, r3, #2
	add	r3, r3, r2
	lsl	r3, r3, #1
	sub	r2, r1, r3
	cmp	r2, #0
	bne	.L53
	bl	reschedule
	bl	trigger_pendsv
.L53:
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L55:
	.align	2
.L54:
	.word	s_ticks
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
	.section	.rodata
	.align	2
.LC2:
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
	ldr	r3, .L60
	strh	r3, [fp, #-12]	@ movhi
	ldr	r3, .L60+4
	ldr	r2, [r3, #48]
	ldrh	r3, [fp, #-12]
	lsr	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	mov	r1, r3
	mov	r3, #1
	lsl	r3, r3, r1
	ldr	r1, .L60+4
	orr	r3, r2, r3
	str	r3, [r1, #48]
	ldr	r0, .L60+8
	bl	systick_init
	ldrh	r3, [fp, #-12]
	mov	r1, #1
	mov	r0, r3
	bl	gpio_set_mode
	ldr	r1, .L60+12
	ldr	r0, .L60+16
	bl	uart_init
	ldr	r3, .L60+20
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3, #1
	strb	r3, [fp, #-9]
	mov	r3, #0
	str	r3, [fp, #-16]
	ldr	r3, .L60+24
	mov	r2, #1
	str	r2, [r3, #8]
	ldr	r3, .L60+24
	ldr	r2, .L60+28
	str	r2, [r3, #4]
	ldr	r0, .L60+24
	bl	create_task
	ldr	r3, .L60+32
	mov	r2, #2
	str	r2, [r3, #8]
	ldr	r3, .L60+32
	ldr	r2, .L60+36
	str	r2, [r3, #4]
	ldr	r0, .L60+32
	bl	create_task
	ldr	r3, .L60+24
	ldr	r3, [r3]
	ldr	r2, .L60+40
	str	r3, [r2]
	ldr	r3, .L60+24
	ldr	r3, [r3, #8]
	ldr	r2, .L60+44
	str	r3, [r2]
	ldr	r3, .L60+32
	ldr	r3, [r3]
	ldr	r2, .L60+48
	str	r3, [r2]
	ldr	r3, .L60+40
	ldr	r1, [r3]
	ldr	r3, .L60+48
	ldr	r2, [r3]
	ldr	r3, .L60+24
	ldr	r0, [r3]
	ldr	r3, .L60+32
	ldr	r3, [r3]
	str	r3, [sp]
	mov	r3, r0
	ldr	r0, .L60+52
	bl	printf
	bl	start_first_task
.L59:
	b	.L59
.L61:
	.align	2
.L60:
	.word	263
	.word	1073887232
	.word	16000000
	.word	115200
	.word	1073760256
	.word	s_ticks
	.word	tcb_task1
	.word	task1
	.word	tcb_task2
	.word	task2
	.word	current_task_sp
	.word	current_task_id
	.word	next_task_sp
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (15:13.2.rel1-2) 13.2.1 20231009"
