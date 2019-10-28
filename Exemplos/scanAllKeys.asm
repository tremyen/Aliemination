include "library/msx1bios.asm"
include "library/msx1variables.asm"
include "library/msxRom.asm"

ident:
            dw startCode
            db "AS01"
            db __VERSION+48
            db __RELEASE+65
            ds 6,0

startCode:
ScanAllKeys:
;Inputs:
;     HL points to the 7 bytes to output the result to
;Notes:
;     There is not enough delay for 15MHz
     ld bc,0701h
     ld a,$FE      ;test the keys
KeyUpdateLoop:
     out (1),a
     rlca
     nop
     ini
     jr nz,KeyUpdateLoop
     ret
