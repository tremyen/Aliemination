; -===========================-
;  copiar um bloco para a VRAM
;  Manoel Neto
; -===========================-
romSize:    equ 8192
romArea:    equ 0x4000
ramArea:    equ 0xe000
INITXT:     equ 0x006c
INIT32:	    equ 0x006F
INIGRP:		  equ 0x0072
LDIRVM:		  equ 0x005C
WRTVRM:		  equ 0x004D
FILVRM:     equ 0x0056
CHPUT:      equ 0x00a2
FORCLR:     equ 0xf3e9
BAKCLR:     equ 0xf3ea
BDRCLR:     equ 0xf3eb
LINL32:     equ 0xF3AF
RG1SAV:     equ 0xf3e0
CHGCLR:     equ 0x0062


            org romArea
            db "AB"                     ; ID
            dw startProgram             ; INIT
            dw 0x0000                   ; STATEMENT
            dw 0x0000                   ; DEVICE
            dw 0x0000                   ; TEXT
            ds 6,0                      ; RESERVED

startProgram:
            proc
            call INIT32                 ; Modo de tela

            ld a,15                     ; BRANCO (15)
            ld (FORCLR),a               ; cor da frente em branco
            ld a,4                      ; AZUL (4)
            ld (BAKCLR),a               ; cor de fundo
            xor a                       ; TRANSPARENTE (0)
            ld (BDRCLR),a               ; cor da borda
            call CHGCLR                 ; => COLOR 15,4,0

            ld hl,7
            ld a,0xff
            call WRTVRM                 ; => VPOKE 7,&HFF

            ld hl,8192
            ld a,0x14
            call WRTVRM                 ; => VPOKE 8192,&H14

            ; putsprite
            ; -===========================-
            ; B — a camada do sprite;
            ; HL — a coordenada X do sprite;
            ; A — a coordenada Y do sprite;
            ; D — a cor do sprite
            ; E — o padrão do sprite.
            ld b,3
            ld hl,120
            ld a,72
            ld d,1
            ld e,0
            call putSprite
            include "library/putSprite.asm"

loop:
            jr loop
            endp

sprite:
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00001000b
            DB 00011100b
            DB 00001000b
            DB 00000000b
            DB 00000001b
            DB 00000001b
            DB 00000000b
            DB 00000000b
            DB 00000101b
            DB 00001010b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00010000b
            DB 00111000b
            DB 00010000b
            DB 00000000b
            DB 10000000b
            DB 10000000b
            DB 00000000b
            DB 00000000b
            DB 01010000b
            DB 10100000b
            DB 00000000b
            DB 00001111b
            DB 00011111b
            DB 00111111b
            DB 01111111b
            DB 11111111b
            DB 11110111b
            DB 11100011b
            DB 11110111b
            DB 11111111b
            DB 11111110b
            DB 11111110b
            DB 01111111b
            DB 00111111b
            DB 00011010b
            DB 00010101b
            DB 00001111b
            DB 11110000b
            DB 11111000b
            DB 11111100b
            DB 11111110b
            DB 11111111b
            DB 11101111b
            DB 11000111b
            DB 11101111b
            DB 11111111b
            DB 01111111b
            DB 01111111b
            DB 11111110b
            DB 11111100b
            DB 10101000b
            DB 01011000b
            DB 11110000b

romPad:
            ds romSize-(romPad-romArea),0
            end
