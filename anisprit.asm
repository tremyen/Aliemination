; ==============================
;  Teste de animacao de sprite
;  Manoel Neto (C) 2019-03-24;
;  Animacao basica de um sprite
; ==============================
spriteArea: equ 14336
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
            call INIT32
            call setSprites32
            call loadSprites

            ;======================================
            ; desabilito a atualização da tela por
            ; interrupção com 'ret' no hook
            ;======================================
            ; ld a,0xc9
            ; ld (HTIMI),a

            ;===========================
            ; Sprite na posicao Inicial
            ;===========================
            ld b,0
            ld hl,125
            ld a,80
            ld d,11
            ld e,0
            call putSprite
            call waitASec
loop:            
            xor a
            call CHGET
            cp 97
            jp z,moveLeft
            cp 115
            jp z,moveRight
            jp loop

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
            ld b,0
            ld e,0
            call putSprite
            call waitASec
            ret

moveLeft:
            dec hl
            ld b,2
            ld a,80
            ld d,11
            ld e,2
            call putSprite
            call waitASec
            ld b,0
            ld e,0
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

clearSprite:
            ld a,192                    ; Um valor que não atrapalha ninguém
            ld bc,8                     ; 16/4 = 4, quatro sprites
            ld hl,6912                  ; início da tabela de sprites
            call FILVRM                 ; preenche com zero!
            ret                         ; sai da rotina

print:
            ld a,(hl)                   ; coloca em A o endereço indicado em HL
            cp 0                        ; compara com 0
            ret z                       ; se é zero, fim da string
            call CHPUT                  ; chama CHPUT
            inc hl                      ; HL=HL+1
            jr print                    ; vai para print

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

entrei:
            DB "Entrei", 0

romPad:
            ds romSize-(romPad-romArea),0
            end
