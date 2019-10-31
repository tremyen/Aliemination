; -===================================================================-
;  Desenhar a tela de entrada do jogo
; -===================================================================-
TelaInicial:
  call DISSCR
    call LimparTela
    call LoadSpritesTable

    ; seta a linha dos sprites
    ld a,94
    ld (PosicaoYNave),a
    ld (PosicaoYAlienigena),a
    ld (PosicaoYCidade),a

    ; seta a coluna dos sprites
    ld a,105
    ld (PosicaoXNave),a
    ld a,170
    ld (PosicaoXAlienigena),a
    ld a,230
    ld (PosicaoXCidade),a

    ; Coloca Sprite da nave
    ; D => Posicao Y
    ; E => Posicao X
    ; B => Numero do Sprite
    ; C => Early / Cor
    ld d,100
    ld e,100
    ld b,0
    ld c,%00001011
    call PutSprite

    ; todo - Coloca Sprite da cidade
    ld d,120
    ld e,120
    ld b,0
    ld c,%00001011
    call PutSprite

    ; todo - Coloca Sprite da nave alienigena
    ld d,140
    ld e,140
    ld b,0
    ld c,%00001011
    call PutSprite

  call ENASCR
TelaIntroLoop:
  call CHGET
  cp 13
  jr z,SairTelaIntro
  jr TelaIntroLoop
SairTelaIntro:
ret
