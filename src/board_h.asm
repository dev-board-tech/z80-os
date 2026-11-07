IFNDEF BOARD_H
DEFINE BOARD_H

DEFC CORE_CLK   = 7372800

; _bp = bit position
; _gp = group position
; _gm = group mask
; _m = mode
; _bm = bit mask

; Config IO register
DEFC IO_CFG_REG = 0xE8
DEFC IO_CFG_REG_LCD_RESET_bp = 5
DEFC IO_CFG_REG_LCD_RESET_bm = 1 << IO_CFG_REG_LCD_RESET_bp

DEFC IO_CFG_REG_RS232_MOUSE_bp = 6
DEFC IO_CFG_REG_RS232_bm = 0 << IO_CFG_REG_RS232_MOUSE_bp
DEFC IO_CFG_REG_MOUSE_bm = 1 << IO_CFG_REG_RS232_MOUSE_bp

DEFC IO_CFG_REG_CLK2_CTC_bp = 7
DEFC IO_CFG_REG_CLK2_bm = 0 << IO_CFG_REG_CLK2_CTC_bp
DEFC IO_CFG_REG_CTC_bm = 1 << IO_CFG_REG_CLK2_CTC_bp

; MMU pages configuration I/O address
DEFC IO_MMU_BANK_0 = 0xF0
DEFC IO_MMU_BANK_1 = 0xF1
DEFC IO_MMU_BANK_2 = 0xF2
DEFC IO_MMU_BANK_3 = 0xF3

; Config IO register
DEFC IO_MMU_REG = 0xF8
DEFC IO_MMU_ENABLE = 0x01
DEFC IO_MMU_DISABLE = 0x00

; SIO
DEFC SIO_BASE_ADDR=0xB0
DEFC SIOA = 0
DEFC SIOB = 2
DEFC SIOA_ADDR = 0
DEFC SIOB_ADDR = 2
DEFC SIO_DAT_ADDR = 0
DEFC SIO_CMD_ADDR = 1

;PIO
DEFC PIO_BASE_ADDR=0xB8
DEFC PIOA = 0
DEFC PIOB = 2
DEFC PIOA_ADDR = 0
DEFC PIOB_ADDR = 2
DEFC PIO_DAT_ADDR = 0
DEFC PIO_CMD_ADDR = 1

; I2C
DEFC I2CS_SDA_PIN = 1
DEFC I2CS_SDA_PIN_MASK = (1 << I2CS_SDA_PIN)
DEFC I2CS_SCL_PIN = 2
DEFC I2CS_SCL_PIN_MASK = (1 << I2CS_SCL_PIN)

; SPI
DEFC SPI_CLK_PIN = 5
DEFC SPI_CLK_PIN_MASK = (1 << SPI_CLK_PIN)
DEFC SPI_MISO_PIN = 4
DEFC SPI_MISO_PIN_MASK = (1 << SPI_MISO_PIN)
DEFC SPI_MOSI_PIN = 3
DEFC SPI_MOSI_PIN_MASK = (1 << SPI_MOSI_PIN)
DEFC SPI_CS0_PIN = 6
DEFC SPI_CS0_PIN_MASK = (1 << SPI_CS0_PIN)
DEFC SPI_CS1_PIN = 7
DEFC SPI_CS1_PIN_MASK = (1 << SPI_CS1_PIN)

; CF
DEFC CF_BASE_ADDR = 0xA0


;-----------------------------------------------------------------------
; Altered:
; a
;-----------------------------------------------------------------------
MACRO BOARD_LOAD_IO_ADDR addr
	push af
	ld a, (addr)
	ld c, a
	pop af
ENDM

MACRO BOARD_LOAD_PIO_REGS addr
	ld ix, addr
ENDM

;-------------------------
; "reg" can be HL, IX or IY
;-------------------------
MACRO GET_SP reg
	ld reg, 0
	add reg, sp
ENDM

ENDIF
