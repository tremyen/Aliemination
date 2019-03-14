;  -==========================-
;   inicializacao de variáveis
;  -==========================-
birdY:      equ ramArea
birdFrame:  equ ramArea+1
birdUp:     equ ramArea+2
birdDown:   equ ramArea+3
pipeFrame:  equ ramArea+4
pipeSize:   equ ramArea+5
pipeGap:    equ ramArea+6
ringRing:   equ ramArea+7
score:      equ ramArea+8               ; 16-bit
hiScore:    equ ramArea+10              ; 16-bit
vdpCycle1:  equ ramArea+12
vdpCycle5:  equ ramArea+13
rndSeed:    equ ramArea+14
birdBuffer: equ ramArea+15              ; coordenadas do pássaro
framebuff3: equ birdBuffer+32           ; o 3º framebuffer (64 bytes)
framebuff2: equ framebuff3+64           ; o 2º framebuffer (140 bytes)
framebuff1: equ framebuff2+140          ; o 1º framebuffer (640 bytes)
videoData:  equ framebuff3

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
