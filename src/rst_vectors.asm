INCLUDE "boot_h.asm"
INCLUDE "boot.asm"
INCLUDE "kernel.asm"

SECTION KERNEL_RST_VECTORS
rst_vector_0:
    ; In theory, on reset the Z80 interrupt are disabled, let's be 100% sure
    ; and disable them again
    di
    jp boot
    nop
    nop
    nop
    nop
entryFromBootLoader:
rst_vector_8:
    call set_Mmu
    nop
    nop
    nop
    nop
    rst 0
rst_vector_10:
    reti ; 2bytes
    nop
    nop
    nop
    nop
    nop
    nop
rst_vector_18:
    reti ; 2bytes
    nop
    nop
    nop
    nop
    nop
    nop
rst_vector_20:
    reti ; 2bytes
    nop
    nop
    nop
    nop
    nop
    nop
rst_vector_28:
    reti ; 2bytes
    nop
    nop
    nop
    nop
    nop
    nop
rst_vector_30:
    reti ; 2bytes
    nop
    nop
    nop
    nop
    nop
    nop
rst_vector_38:
    reti ; 2bytes
    nop
    nop
    nop
    nop
    nop
    nop
;
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
nmi_vector:
    jp contextSwitch
set_Mmu:
    MMU_SET_ADDR(MMU_RAM_ADDR, IO_MMU_BANK_0)
    ret

    ; Assert that these reset vectors are at the right place
    ASSERT(rst_vector_0  = 0x00)
    ASSERT(rst_vector_8  = 0x08)
    ASSERT(rst_vector_10 = 0x10)
    ASSERT(rst_vector_18 = 0x18)
    ASSERT(rst_vector_20 = 0x20)
    ASSERT(rst_vector_28 = 0x28)
    ASSERT(rst_vector_30 = 0x30)
    ASSERT(rst_vector_38 = 0x38)
    ASSERT(nmi_vector = 0x66)
    



