; -===================================================================-
;  Desenhar a tela da Crazy People
; -===================================================================-
TelaCrazy:
  call DISSCR
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
