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

            org romArea
            db "AB"                     ; ID
            dw startProgram             ; INIT
            dw 0x0000                   ; STATEMENT
            dw 0x0000                   ; DEVICE
            dw 0x0000                   ; TEXT
            ds 6,0                      ; RESERVED

startProgram:
            proc
            call INIGRP                 ; Modo de tela

            ld a,15                     ; BRANCO (15)
            ld (FORCLR),a               ; cor da frente em branco
            ld a,14                     ; CINZA (14)
            ld (BAKCLR),a               ; cor de fundo
            LD a,1                      ; Preto (1)
            ld (BDRCLR),a               ; cor da borda
            call CHGCLR                 ; => COLOR 15,14,1


            ;Você pode colar até trinta e dois sprites
            ;só quatro podem estar presentes na mesma linha horizontal
            ;o processador sempre irá desenhá-los uma linha abaixo de onde
            ;você realmente mandou

            ; Preencher a VRAM
            ; tabela de padroes
            ;-================================
            ; A  - data byte
            ; BC - length (8x8:8 16x16:32)
            ; HL - start address (entre 14.336 e 16.385)
            ; Ou seja, dependendo do tamanho utilizado você pode ter
            ; 256 ou 64 sprites
            ;-================================
            ld a,sprite
            ld bc,32
            ld hl,14336
            call FILVRM

            ; putsprite
            ; -===========================-
            ; B  — a camada do sprite;
            ; HL — a coordenada X do sprite;
            ; A  — a coordenada Y do sprite (0 até 191);
            ; D  — a cor do sprite
            ; E  — o padrão do sprite.
            ; -===========================-
            ld b,3
            ld hl,100
            ld a,80
            ld d,10
            ld e,0
            call putSprite

            include "library/putSprite.asm"

loop:
            jr loop
            endp

sprite:
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
            DB 00000011b
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
            DB 11000000b
            DB 11000011b
            DB 11001110b
            DB 01001000b
            DB 01111000b
            DB 00000000b
            ret
romPad:
            ds romSize-(romPad-romArea),0
            end
