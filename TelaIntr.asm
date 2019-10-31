; -===================================================================-
;  Desenhar a tela de entrada do jogo
; -===================================================================-
TelaInicial:
  call DISSCR

    call LimparTela
    call LoadSpritesTable

    ; Coloca Sprite da nave
    ld bc,4
    ld de,ADRATRIBUTETBL
    ld hl,NavePattern
    call LDIRVM

    ; Coloca Sprite da cidade
    ld bc,4
    ld de,ADRATRIBUTETBL+4
    ld hl,CidadePattern
    call LDIRVM

    ; Coloca Sprite da nave alienigena
    ld bc,4
    ld de,ADRATRIBUTETBL+8
    ld hl,InimigoPattern
    call LDIRVM

call ENASCR
TelaIntroLoop:
  call CHGET
  cp 13
  jr z,SairTelaIntro
  jr TelaIntroLoop
SairTelaIntro:
ret

NavePattern:
  db 100,100,0,13
CidadePattern:
  db 120,120,0,13
InimigoPattern:
  db 140,140,0,13
