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
WRTVDP:     equ 0x0047
FILVRM:     equ 0x0056
CHPUT:      equ 0x00a2
FORCLR:     equ 0xf3e9
BAKCLR:     equ 0xf3ea
BDRCLR:     equ 0xf3eb
LINL32:     equ 0xF3AF
RG1SAV:     equ 0xf3e0
CHGCLR:     equ 0x0062
CHGMOD:		  equ 0x005F			; Altera modo do VDP


spriteArea: equ 14336

            org romArea
            db "AB"                     ; ID
            dw startProgram             ; INIT
            dw 0x0000                   ; STATEMENT
            dw 0x0000                   ; DEVICE
            dw 0x0000                   ; TEXT
            ds 6,0                      ; RESERVED

startProgram:
            proc
            call setScreen2             ; entra no modo screen2
            ld a,15                     ;
            ld (FORCLR),a               ; cor da frente em branco
            ld a,5                      ;
            ld (BAKCLR),a               ; cor de fundo
            LD a,5                      ;
            ld (BDRCLR),a               ; cor da borda
            call CHGCLR                 ;



            ; Preencher a Tabela de imagens dos Sprite
            ; Block transfer to VRAM from memory
            ;-===========================================-
            ; BC - blocklength
            ; DE - Start address of VRAM (entre 14336 e 16385)
            ; HL - start address of RAM
            ; Ou seja, dependendo do tamanho utilizado
            ; você pode ter 256 ou 64 sprites
            ;-===========================================-
            ld bc,257
            ld de,spriteArea
            ld hl,sprite
            call LDIRVM

            ; Preencher a Tabela de Atributos dos sprites
            ; putsprite
            ;-===========================================-
            ; B  — a camada do sprite;
            ; HL — a coordenada X do sprite (0 ate 255)
            ; A  — a coordenada Y do sprite (0 ate 190);
            ; D  — a cor do sprite
            ; E  — o padrão do sprite.
            ;-===========================================-

            ;-===========================================-
            ; Nave
            ;-===========================================-
            ld b,0
            ld hl,127
            ld a,150
            ld d,1
            ld e,0
            call putSprite

            ld b,1
            ld hl,127
            ld a,150
            ld d,11
            ld e,1
            call putSprite
            ;-===========================================-

            ;-===========================================-
            ; Cidade 1
            ;-===========================================-
            ld b,2
            ld hl,127
            ld a,170
            ld d,1
            ld e,2
            call putSprite

            ld b,3
            ld hl,127
            ld a,170
            ld d,6
            ld e,3
            call putSprite

            ld b,4
            ld hl,127
            ld a,170
            ld d,8
            ld e,4
            call putSprite

            ld b,5
            ld hl,127
            ld a,170
            ld d,9
            ld e,5
            call putSprite
            ;-===========================================-

            ;-===========================================-
            ; Alien!
            ;-===========================================-
            ld b,14
            ld hl,127
            ld a,32
            ld d,1
            ld e,6
            call putSprite

            ld b,15
            ld hl,127
            ld a,32
            ld d,3
            ld e,7
            call putSprite

            ld b,16
            ld hl,127
            ld a,32
            ld d,6
            ld e,8
            call putSprite
            ;-===========================================-

loop:
            jr loop
            endp

            include "library/putSprite.asm"
            include "library/setScreen2.asm"

sprite:
            ; Nave - Cada Bloco tem 32 bytes
            ; --- Slot 0
            ; color 1
            DB 00000000b
            DB 00000011b
            DB 00000010b
            DB 00000110b
            DB 00111100b
            DB 00101001b
            DB 00100011b
            DB 01100010b
            DB 11000000b
            DB 10000001b
            DB 10000011b
            DB 11100011b
            DB 00110011b
            DB 00010010b
            DB 00011110b
            DB 00000000b
            DB 00000000b
            DB 11000000b
            DB 01000000b
            DB 01100000b
            DB 00111100b
            DB 10010100b
            DB 11000100b
            DB 01000110b
            DB 00000011b
            DB 10000001b
            DB 11000001b
            DB 11000111b
            DB 11001100b
            DB 01001000b
            DB 01111000b
            DB 00000000b
            ; color 11
            DB 00000000b
            DB 00000000b
            DB 00000001b
            DB 00000001b
            DB 00000011b
            DB 00010110b
            DB 00011100b
            DB 00011101b
            DB 00111111b
            DB 01111110b
            DB 01111100b
            DB 00011100b
            DB 00001100b
            DB 00001100b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 10000000b
            DB 10000000b
            DB 11000000b
            DB 01101000b
            DB 00111000b
            DB 10111000b
            DB 11111100b
            DB 01111110b
            DB 00111110b
            DB 00111000b
            DB 00110000b
            DB 00110000b
            DB 00000000b
            DB 00000000b
            ; Cidade
            ; color 1 - 2
            DB 00000000b
            DB 00000000b
            DB 00000100b
            DB 00001000b
            DB 00010000b
            DB 00111000b
            DB 01111100b
            DB 00000000b
            DB 00010000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000001b
            DB 00000001b
            DB 01111111b
            DB 11111111b
            DB 00000000b
            DB 00000000b
            DB 00000010b
            DB 00000100b
            DB 00001000b
            DB 00011100b
            DB 00111110b
            DB 00000000b
            DB 00001000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 10000000b
            DB 10000000b
            DB 11111110b
            DB 11111111b
            ; color 6 - 3
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00101000b
            DB 00111000b
            DB 00111000b
            DB 00111000b
            DB 00111000b
            DB 00111000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00010100b
            DB 00011100b
            DB 00011100b
            DB 00011100b
            DB 00011100b
            DB 00011100b
            DB 00000000b
            DB 00000000b
            ; color 8 - 4
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000001b
            DB 00000011b
            DB 00000011b
            DB 00000011b
            DB 00000010b
            DB 00000010b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 10000000b
            DB 11000000b
            DB 11000000b
            DB 11000000b
            DB 01000000b
            DB 01000000b
            DB 00000000b
            DB 00000000b
            ; color 9 - 5
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 01111100b
            DB 01000100b
            DB 01000100b
            DB 01000100b
            DB 01000100b
            DB 01000100b
            DB 01000100b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00111110b
            DB 00100010b
            DB 00100010b
            DB 00100010b
            DB 00100010b
            DB 00100010b
            DB 00100010b
            DB 00000000b
            DB 00000000b
            ; nave alienigena
            ; color 1 - 6
            DB 11100011b
            DB 10110010b
            DB 11011010b
            DB 01101110b
            DB 00100100b
            DB 00010001b
            DB 00010001b
            DB 00010000b
            DB 00010001b
            DB 00011001b
            DB 00001100b
            DB 00000110b
            DB 00000011b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 10001110b
            DB 10011010b
            DB 10110110b
            DB 11101100b
            DB 01001000b
            DB 00011000b
            DB 00010000b
            DB 00010000b
            DB 00010000b
            DB 00110000b
            DB 01100000b
            DB 11000000b
            DB 10000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            ; color 3 - 7
            DB 00000000b
            DB 01000001b
            DB 00100001b
            DB 00010001b
            DB 00011011b
            DB 00001110b
            DB 00001000b
            DB 00001000b
            DB 00001000b
            DB 00000110b
            DB 00000011b
            DB 00000001b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000100b
            DB 00001000b
            DB 00010000b
            DB 10110000b
            DB 11100000b
            DB 00100000b
            DB 00100000b
            DB 00100000b
            DB 11000000b
            DB 10000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            ; color 6 - 8
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000110b
            DB 00000111b
            DB 00000110b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 11000000b
            DB 11000000b
            DB 11000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
romPad:
            ds romSize-(romPad-romArea),0
            end
