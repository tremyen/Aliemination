;  -==========================-
;   inicializacao de variáveis
;  -==========================-
rndSeed:          equ ramArea
vdpCycle1:        equ ramArea+1
vdpCycle5:        equ ramArea+2
score:            equ ramArea+3
backgrn:          equ 6144
spriteArea:       equ 14336
spriteNave:       equ spriteArea
spriteCidade:     equ spriteArea+32

initVar:
  proc
  ld a,NTSC
  ld (vdpCycle1),a            ; a princípio 6 -- 1/10s
  ld a,NTSC*10
  ld (vdpCycle5),a            ; a princípio 60 - 1s
  ret                         ; sai da rotina
  endp
