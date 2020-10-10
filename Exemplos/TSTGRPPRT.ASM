romSize:    equ 8192                    ; o tamanho que a ROM deve ter
romArea:    equ 0x4000                  ; minha ROM comeca aqui
ramArea:    equ 0xe000                  ; inicio da area de variaveis
INITXT:     equ 0x006C
CHPUT:      equ 0x00A2
INIGRP:     equ 0x0072
GRPPRT:     equ 0x008D

org romArea
    db "AB"                     ; ID
    dw startProgram             ; INIT
    dw 0x0000                   ; STATEMENT
    dw 0x0000                   ; DEVICE
    dw 0x0000                   ; TEXT
    ds 6,0                      ; RESERVED

startProgram:
    call INIGRP
    ld hl,helloWorld
getChar: 
    ld a,(hl)
    cp 13
    jr z,loop
    call GRPPRT
    inc hl
    jr getChar
loop:
    jr loop
    
helloWorld:
    db "Hello World!",13

romPad:
    ds romSize-(romPad-romArea),0