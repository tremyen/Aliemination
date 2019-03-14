; -===================================================================-
;  Aliemination 1.0
;  Meu primeiro jogo de MSX
;  (C) 2019-2016 Manoel Neto - tremyen@gmail.com;
;  Mude, compartilhe e estude. Conhecimento é de graça.
; -===================================================================-
__VERSION:  equ 1
__RELEASE:  equ 0

            include "library/msx1bios.asm"
            include "library/msx1variables.asm"
            include "library/msx1hooks.asm"
            include "library/initVar.asm"
            include "library/waitASec.asm"            
            include "TelaCrazyPeople.asm"

PAL:        equ  5                      ; 1/10s em 50Hz (PAL-B/G/N)
NTSC:       equ  6                      ; 1/10s em 60Hz (NTSC & PAL-M)

makeROM:
romSize:    equ 8192                    ; o tamanho que a ROM deve ter
romArea:    equ 0x4000                  ; minha ROM começa aqui
ramArea:    equ 0xe000                  ; inicio da área de variáveis
            org romArea
            db "AB"                     ; identifica como ROM
            dw startCode                ; endereço de execução
            db "AM01"                   ; string de identificação
            db __VERSION+48
            db __RELEASE+65
            ds 6,0

startCode:
            call initVar                ; variaveis principais
            call telaCrazyPeople        ; chama a tela da empresa

gameLoop:
            jr gameLoop                 ; volta para o laço do jogo

romPad:
            ds romSize-(romPad-romArea),0
            end
