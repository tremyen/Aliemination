; -===================================================================-
;  Desenhar a tela de entrada do jogo
; -===================================================================-
TelaInicial:
  call DISSCR
    call LimparTela

    ; DESENHA O CENARIO
    ld de,0                   ; Base da memoria da VRAM
    ld hl,Cenario+7           ; os primeiros 7 bytes sao cabecalho
    ld bc,15360               ; tamanho da BMP
    call LDIRVM               ; copio para a VRAM

    ; CARREGA AS TABELAS DO VDP
    call LoadSpritesTable
    call LoadPatternTable


    ; Coloca Sprite da nave cor 1
    ;=============================
    ld bc,4
    ld de,ADRATRIBUTETBL
    ld hl,NavePatternOne
    call LDIRVM

    ; Coloca Sprite da nave cor 2
    ;=============================
    ld bc,4
    ld de,ADRATRIBUTETBL+4
    ld hl,NavePatternTwo
    call LDIRVM

call ENASCR
TelaIntroLoop:
  call CHGET
  cp 13
  jr z,SairTelaIntro
  jr TelaIntroLoop
SairTelaIntro:
ret

NavePatternOne:
  db 100,100,0,1
NavePatternTwo:
  db 100,100,4,11
