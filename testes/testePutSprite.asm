CHGCLR:     equ 0x0062
CHPUT:      equ 0x00a2
ERAFNK:     equ 0x00cc
INIT32:     equ 0x006f
FILVRM:     equ 0x0056
WRTVDP:     equ 0x0047
WRTVRM:     equ 0x004d

BAKCLR:     equ 0xf3ea
BDRCLR:     equ 0xf3eb
FORCLR:     equ 0xf3e9
LINL32:     equ 0xF3AF
RG1SAV:     equ 0xf3e0

macro	____put_sprite,Sprite_Layer,Sprite_Pos_X,Sprite_Pos_Y,Sprite_Color,Sprite_Pattern
            ld b,Sprite_Layer
            ld hl,Sprite_Pos_X
            ld a,Sprite_Pos_Y
            ld d,Sprite_Color
            ld e,Sprite_Pattern
            call putSprite
            endm

romSize:    equ 8192                    ; O tamanho da ROM (8192 ou 16384)
romArea:    equ 0x4000                  ; Endereço inicial da ROM (0x4000 ou 0x8000)
ramArea:    equ 0xe000                  ; Início da RAM (0xc000 ou 0xe000)

            org romArea

            db "AB"                     ; ID
            dw startProgram             ; INIT
            dw 0x0000                   ; STATEMENT
            dw 0x0000                   ; DEVICE
            dw 0x0000                   ; TEXT
            ds 6,0                      ; RESERVED

startProgram:
            proc

            call ERAFNK                 ; => KEY OFF

            ld hl,LINL32
            ld (hl),32                  ; => WIDTH 32 -- ou quase :-)

            call INIT32                 ; => SCREEN 1

            ld a,15                     ; BRANCO (15)
            ld (FORCLR),a               ; cor da frente em branco
            ld a,4                      ; AZUL (4)
            ld (BAKCLR),a               ; cor de fundo
            xor a                       ; TRANSPARENTE (0)
            ld (BDRCLR),a               ; cor da borda
            call CHGCLR                 ; => COLOR 15,4,0

            ld a,(RG1SAV)               ; leio o valor do registro 1
            and 0xec
            or 2                        ; e ajusto os sprites em 32x32
            ld b,a                      ; B=A
            ld c,1                      ; registrador 1
            call WRTVDP                 ; altero o valor do registro 1

            ld hl,7
            ld a,0xff
            call WRTVRM                 ; => VPOKE 7,&HFF

            ld hl,8192
            ld a,0x14
            call WRTVRM                 ; => VPOKE 8192,&H14

            ld a,0
            ld bc,32
            ld hl,6144+10*32
            call FILVRM                 ; faz 32 caracteres NULL na linha 10

            ld bc,32
            ld hl,14336
            ld a,0xff
            call FILVRM                 ; => SPRITE$(0)=STRING$(32,255)


sprites:
            ld b,3
            ld hl,120
            ld a,72
            ld d,1
            ld e,0
            call putSprite              ; ou você pode chamar do jeito "clássico"

loop:
            jr loop                     ; trava a execução neste ponto
            endp

romPad:
            ds romSize-(romPad-romArea),0
            end
