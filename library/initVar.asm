;  -==========================-
;   inicializacao de variáveis
;  -==========================-
rndSeed:    equ ramArea
vdpCycle1:  equ ramArea+1
vdpCycle5:  equ ramArea+2
videoData:  equ ramArea+3

initVar:
            proc
            ld a,NTSC
            ld (vdpCycle1),a            ; a princípio 6 -- 1/10s
            ld a,NTSC*10
            ld (vdpCycle5),a            ; a princípio 60 - 1s
            ret                         ; sai da rotina
            endp
