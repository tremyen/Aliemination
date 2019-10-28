; -===================================================================-
;  Desenhar a tela da Crazy People
; -===================================================================-
TelaCrazy:
  call DISSCR
  ld b,1
  ld c,1
  call GetBMPScreenPos
  ld d,h
  ld e,l
  ld hl,CPLogo
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

CPLogo:
  incbin "Assets\CPLogo.SC2"
