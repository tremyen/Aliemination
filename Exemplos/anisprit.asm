; ==============================
;  Teste de animacao de sprite
;  Manoel Neto (C) 2019-03-24;
;  Animacao basica de um sprite
; ==============================
spriteArea: equ 14336
ramArea:    equ 0xe000                  ; inicio da área de variáveis
shipY:      equ ramArea
shipFrame:  equ ramArea+1
shipLeft:   equ ramArea+2
shipRight:  equ ramArea+3
vdpCycle1:  equ ramArea+4
vdpCycle5:  equ ramArea+5
shipBuffer: equ ramArea+6              ; coordenadas da nave
framebuff3: equ shipBuffer+32           ; o 3º framebuffer (64 bytes)
framebuff2: equ framebuff3+64           ; o 2º framebuffer (140 bytes)
framebuff1: equ framebuff2+140          ; o 1º framebuffer (640 bytes)
videoData:  equ framebuff3

ident:
            dw startCode
            db "AS01"
            db __VERSION+48
            db __RELEASE+65
            ds 6,0

startCode:
            call INIT32
            call setSprites32
            call loadSprites
            ld bc,640                   ; quantidade de bytes para copiar
            ld de,6144+64               ; endereço iniciual da VRAM
            ld hl,framebuff1            ; endereço do framebuffer
            call LDIRVM
            ld a,0xc9                   ; desabilito a atualização da tela por
            ld (HTIMI),a                ; interrupção com 'ret' no hook          

loop:
            ld hl,JIFFY
            ld (hl),0                   ; zero o temporizador
            call drawShip

            xor a
            call CHGET
            ld h,a                     ; salva o valor em H
            cp 97
            jr nz,moveLeft
            ld a,h
            cp 115
            jp nz,moveRight
            jp loop

            include "library/msx1bios.asm"
            include "library/msx1variables.asm"
            include "library/msxRom.asm"
            include "library/putSprite.asm"
            include "library/waitASec.asm"

moveRight:
            inc hl
            ld b,1
            ld a,80
            ld d,11
            ld e,1
            call putSprite
            call waitASec
            ret

moveLeft:
            dec hl
            ld b,1
            ld a,80
            ld d,11
            ld e,2
            call putSprite
            call waitASec
            ret

setSprites32:
            LD A,(RG1SAV)
            OR 2
            LD B,A
            LD C,1
            call WRTVDP
            ret

loadSprites:
            ld bc,96
            ld de,spriteArea
            ld hl,data
            call LDIRVM
            ret

data:
shipFront:
            ; Nave - Cada Bloco tem 32 bytes
            ; --- Slot 0
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

shipLeft:
            ; --- Slot 1
            ; color 11
            DB 00000000b
            DB 00000000b
            DB 00000110b
            DB 00000111b
            DB 00001111b
            DB 00011011b
            DB 01010001b
            DB 01110101b
            DB 01111111b
            DB 00111011b
            DB 00010001b
            DB 00010001b
            DB 00010001b
            DB 00000001b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 10000000b
            DB 11010000b
            DB 11110000b
            DB 11110000b
            DB 11111000b
            DB 11111100b
            DB 11111100b
            DB 11000000b
            DB 10000000b
            DB 10000000b
            DB 00000000b
            DB 00000000b

shipRight:
            ; --- Slot 2
            ; color 11
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000001b
            DB 00010111b
            DB 00011111b
            DB 00011111b
            DB 00111111b
            DB 01111111b
            DB 01111111b
            DB 00011111b
            DB 00001110b
            DB 00001110b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 11100000b
            DB 11100000b
            DB 11100000b
            DB 10110000b
            DB 00010100b
            DB 01011100b
            DB 11111110b
            DB 10111110b
            DB 00011110b
            DB 00011100b
            DB 00011000b
            DB 00000000b
            DB 00000000b
            DB 00000000b

romPad:
            ds romSize-(romPad-romArea),0
            end
