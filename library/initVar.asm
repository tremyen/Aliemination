;  -==========================-
;   inicializacao de variáveis
;  -==========================-

ringRing:   equ ramArea+7
score:      equ ramArea+8               ; 16-bit
hiScore:    equ ramArea+10              ; 16-bit
vdpCycle1:  equ ramArea+12
vdpCycle5:  equ ramArea+13
rndSeed:    equ ramArea+14


initVar:
            proc
            xor a                       ; zero A
            ld (ringRing),a             ; flag do som de pontuação
            ld hl,0                     ; recorde do dia (sempre zero)
            ld (hiScore),hl
            ld a,NTSC
            ld (vdpCycle1),a            ; a princípio 6 -- 1/10s
            ld a,NTSC*10
            ld (vdpCycle5),a            ; a princípio 60 - 1s
            ret                         ; sai da rotina
            endp
