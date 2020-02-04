romSize:    equ 32768       ; O tamanho da ROM (8192 ou 16384)
romArea:    equ 0x4000      ; Endereço inicial da ROM (0x4000 ou 0x8000)
ramArea:    equ 0xe000      ; Início da RAM (0xc000 ou 0xe000)
include "..\Hardware\BIOSMSX.ASM"

org romArea
  db "AB"                     ; ID
  dw startProgram             ; INIT
  dw 0x0000                   ; STATEMENT
  dw 0x0000                   ; DEVICE
  dw 0x0000                   ; TEXT
  ds 6,0                      ; RESERVED

startProgram:
TelaCrazy:
  call SetScreen2_16x16
  call DISSCR                 ; desligo a tela
    ld de,0                   ; Base da memoria da VRAM
    ld hl,Cenario+7           ; os primeiros 7 bytes sao cabecalho
    ld bc,15360               ; tamanho da BMP
    call LDIRVM               ; copio para a VRAM
  call ENASCR                 ; ligo a tela
TelaCrazyLoop:
  call CHGET                  ; recebo um caracter
  cp 13                       ; espero enter
  jr z,SairTelaCrazy          ; se foi enter, va para proxima tela
  jr TelaCrazyLoop            ; espere por enter
SairTelaCrazy:
ret

include "..\Hardware\TMS9918.ASM"
include "..\Library\Library.ASM"

Cenario:
  incbin "CPLOGOBW.SC2"
romPad:
  ds romSize-(romPad-romArea),0
  end
