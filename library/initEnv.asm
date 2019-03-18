;  -=========================-
;   inicializa o ambiente msx
;  -=========================-

include "library/turboMode.asm"

initEnv:
            proc
            local palAdjust
            local noPalAdjust

            call turboMode          ; e um turbo R? pare de sofrer!
            call BEEP               ; bipo (e zero os registros do PSG)
            call DISSCR             ; desligo a exibição da tela
            ld a,(JIFFY+1)          ; inicializo a semente do meu gerador
            ld (rndSeed),a          ; de números pseudo-aleatórios
            ld a,(0x002b)           ; leio a versão do MSX na ROM
            bit 7,a                 ; se o bit 7 for 1 é 50Hz senão é 60Hz
            jr z, noPalAdjust       ; sendo 0 eu sigo adiante

palAdjust:
            ld a,PAL                ; defino o novo valor para PAL
            ld (vdpCycle1),a        ; o valor para 1/10s em PAL
            ld a,PAL*10             ; 1/10*10=1, certo?
            ld (vdpCycle5),a        ; o valor é o de 1s em PAL

noPalAdjust:
            xor a                   ; A=0
            ld (CLIKSW),a           ; desligo o click das teclas e
            call ERAFNK             ; desligo as teclas de função

            ;Definicao das cores da tela
            ld a,15                 ; BRANCO
            ld (FORCLR),a           ; cor da frente em branco
            ld a,1                  ;
            ld (BAKCLR),a           ; Cor do fundo
            ld a,14                 ;
            ld (BDRCLR),a           ; Cor da borda
            call CHGCLR             ; agora mudo as cores da tela
            ld a,32
            ld (LINL32),a           ; largura da tela em 32 colunas
            call INIGRP             ; entro na SCREEN2
            call ENASCR             ; religo a tela
            ret                     ; sai da rotina

            endp
