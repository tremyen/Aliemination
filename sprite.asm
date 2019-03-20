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
            call CHGCLR                 ; COLOR 15,14,1
            call SetScreen2             ; entra no modo screen2

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
            ; HL — a coordenada X do sprite; (0 ate 255)
            ; A  — a coordenada Y do sprite (0 ate 191);
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

SetScreen2:
            LD HL,0x0101
          	LD (BAKCLR),HL
          	LD A,2
            call CHGMOD    ; CHGMOD troca o modo de tela
          	LD A,(RG1SAV)
          	OR 2
          	LD B,A
          	LD C,1
            call 0x0047  ;;WRTVDP escreve dados nos registradores do VDP.
            ret

sprite:
            DB 000,000,000,028,031,031,028,227
            DB 031,227,031,227,031,224,000,000
            DB 000,000,000,127,255,255,127,255
            DB 255,255,255,255,255,127,000,000

romPad:
            ds romSize-(romPad-romArea),0
            end
