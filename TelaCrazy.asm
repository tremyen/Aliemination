; -===================================================================-
;  Desenhar a tela da Crazy People
; -===================================================================-
TelaCrazy:
  call DISSCR
   ld b,1
   ld c,0
   call GetBMPScreenPos
   ld d,h
   ld e,l
  ; ld de,0
  ld hl,CPLogo
  ld bc,14000
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
  incbin "Assets\CRAZYPEO.SC2"
