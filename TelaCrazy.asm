; -===================================================================-
;  Desenhar a tela da Crazy People
; -===================================================================-
TelaCrazy:
  call DISSCR
    ld d,%00000010            ; [0][0][0][0][0][0][M3][EV]
    ld e,%00000010            ; [16K][BLK][IE][M1][M2][0][SPR][MAG]
    call SetScreenMode
    call INIGRP               ; inicia modo grafico
    call LimparTela
    ld de,0
    ld hl,CPLogo+7            ; os primeiros 7 bytes sao cabecalho
    ld bc,15360
    call LDIRVM
  call ENASCR
TelaCrazyLoop:
  call CHGET
  cp 13
  jr z,SairTelaCrazy
  jr TelaCrazyLoop
SairTelaCrazy:
ret
; -===================================================================-
