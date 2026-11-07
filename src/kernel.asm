
DEFC APP_MAX_THREADS = 16

DEFC APP_SP = 0
DEFC APP_PID = 1
DEFC APP_STRUCT_LEN = 3

SECTION KERNEL_BSS

KERNEL_THREAD_PTR:
DW 0

KERNEL_ACTIVE_THREAD_TOP:
DW 0

KERNEL_THREADS_TABLE:
DEFS APP_MAX_THREADS * APP_STRUCT_LEN

SECTION KERNEL_CORE

kernel_Init:
	ld hl, KERNEL_THREADS_TABLE
	ld (KERNEL_THREAD_PTR), hl
	ld (KERNEL_ACTIVE_THREAD_TOP), hl
	ret

contextSwitch:
	push af
	ex af, af
	push af
	push bc
	push de
	push hl
	ld hl, KERNEL_THREADS_TABLE
	ld bc, (KERNEL_ACTIVE_THREAD_TOP)
	xor a
	sbc hl, bc
	jr nc, contextSwitch_NoThreadIsRunning
	exx
	push bc
	push de
	push hl
	push ix
	push iy
	; All registry for current thread saved
	
	; Get the SP
	xor h
	xor l
	add hl, sp

	; Save the SP into the thread context
	ld ix, (KERNEL_THREAD_PTR)
	ld (ix + APP_SP + 0), h
	ld (ix + APP_SP + 1), l
	ld hl, (KERNEL_THREAD_PTR)
	
	; Add the thread context len to the pointer
	ld de, APP_STRUCT_LEN
	add ix, de
	add hl, de
	ex de, hl
	; IX and DE has the pointer of the next thread
	
	; Check if thread pointer is overflowing
	ld hl, (KERNEL_ACTIVE_THREAD_TOP)
	xor a
	sbc hl, de
	jr nc, contextSwitch_NotEndOfTable
	
	; Thread pointer is overflow, reload the thread context table popinter for thread 0
	ld ix, KERNEL_THREADS_TABLE
	ld (KERNEL_THREAD_PTR), ix
contextSwitch_NotEndOfTable:

	; DE has the next thread context pointer
	ld h, (ix + APP_SP + 0)
	ld l, (ix + APP_SP + 1)
	ld sp, hl
	
	; Restore registry for next thread
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	exx
contextSwitch_NoThreadIsRunning:
	pop hl
	pop de
	pop bc
	pop af
	ex af, af
	pop af
	retn

