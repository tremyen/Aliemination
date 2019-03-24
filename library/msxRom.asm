;-==============================================-
; Cabecalho de ROM MSX
; Manoel Neto (c) 2019-03-24
;-==============================================-
__VERSION:  equ 1
__RELEASE:  equ 0
PAL:        equ  5                      ; 1/10s em 50Hz (PAL-B/G/N)
NTSC:       equ  6                      ; 1/10s em 60Hz (NTSC & PAL-M)

makeROM:
romSize:    equ 16384                   ; o tamanho que a ROM deve ter
romArea:    equ 0x4000                  ; minha ROM começa aqui
ramArea:    equ 0xe000                  ; inicio da área de variáveis
            org romArea
            db "AB"                     ; identifica como ROM
            dw startCode                ; endereço de execução
