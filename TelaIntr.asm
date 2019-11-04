; =============================================================================
;  Desenhar a tela de entrada do jogo
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
TelaInicial:
  call DISSCR

    call LimparTela
    ;=============================
    ; DESENHA O CENARIO
    ;=============================
    ld de,0                   ; Base da memoria da VRAM
    ld hl,Cenario+7           ; os primeiros 7 bytes sao cabecalho
    ld bc,15360               ; tamanho da BMP
    call LDIRVM               ; copio para a VRAM
    ;=============================
    ; CARREGA AS TABELAS DO VDP
    ;=============================
    call LoadSpritesTable
    ;call LoadPatternTable
    ;=============================
    ; Desenhar Nave
    ;=============================
    ld a,(PosicaoYNave)
    ld d,a
    ld a,(PosicaoXNave)
    ld e,a
    call DesenharNave
    ;=============================
    ; Desenhar Cidade 1
    ;=============================
    ld a,PosYCidade1
    ld d,a
    ld a,PosXCidade1
    ld e,a
    call DesenharCidade
    ;=============================
    ; Desenhar Cidade 2
    ;=============================
    ; ld a,PosYCidade2
    ; ld d,a
    ; ld a,PosXCidade2
    ; ld e,a
    ; call DesenharCidade
    ;=============================
    ; Desenhar Cidade 3
    ;=============================
    ; ld a,PosYCidade3
    ; ld d,a
    ; ld a,PosXCidade3
    ; ld e,a
    ; call DesenharCidade
    ;=============================
    ; Desenhar Cidade 4
    ;=============================
    ; ld a,PosYCidade4
    ; ld d,a
    ; ld a,PosXCidade4
    ; ld e,a
    ; call DesenharCidade
    ;=============================

  call ENASCR
  call WaitEnter
ret
