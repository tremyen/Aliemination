; =============================================================================
;  Desenhar a tela de entrada do jogo
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
TelaInicial:
  call DISSCR

    call LimparTela
    ;==========================
    ; DESENHA O CENARIO
    ;==========================
    ld de,0                     ; Base da memoria da VRAM
    ld hl,Cenario+7             ; os primeiros 7 bytes sao cabecalho
    ld bc,15360                 ; tamanho da BMP
    call LDIRVM                 ; copio para a VRAM
    ;==========================
    ; CARREGA AS TABELAS DO VDP
    ;==========================
    call LoadSpritesTable
    ;call LoadPatternTable
    ;==========================
    ; Desenhar Nave
    ; A Nave usa 2 sprites
    ; (0,1)
    ;==========================
    ld a,(PosYNave)
    ld d,a
    ld a,(PosXNave)
    ld e,a
    ld a,0                      ; posicao do sprite na tabela de atributos
    call DesenharNave
    ;==========================
    ; Desenhar Cidade 1
    ; a cidade usa 4 sprites
    ; (2,3,4,5)
    ;==========================
    ld a,PosYCidade1
    ld d,a
    ld a,PosXCidade1
    ld e,a
    ld a,2                      ; posicao do sprite na tabela de atributos
    call DesenharCidade
    ;==========================
    ; Desenhar Cidade 2
    ; a cidade usa 4 sprites
    ; (6,7,8,9)
    ;==========================
    ld a,PosYCidade2
    ld d,a
    ld a,PosXCidade2
    ld e,a
    ld a,6                      ; posicao do sprite na tabela de atributos
    call DesenharCidade
    ;==========================
    ; Desenhar Cidade 3
    ; a cidade usa 4 sprites
    ; (10,11,12,13)
    ;==========================
    ld a,PosYCidade3
    ld d,a
    ld a,PosXCidade3
    ld e,a
    ld a,10                     ; posicao do sprite na tabela de atributos
    call DesenharCidade
    ;==========================
    ; Desenhar Cidade 4
    ; a cidade usa 4 sprites
    ; (14,15,16,17)
    ;==========================
    ld a,PosYCidade4
    ld d,a
    ld a,PosXCidade4
    ld e,a
    ld a,14                     ; posicao do sprite na tabela de atributos
    call DesenharCidade
    ;==========================
    ; Desenhar Alien
    ; O Alien usa 3 sprites
    ; (18,19,20)
    ;==========================
    ld a,(PosYAlien)
    ld d,a
    ld a,(PosXAlien)
    ld e,a
    ld a,18                     ; posicao do sprite na tabela de atributos
    call DesenharAlienigena
    ;==========================

  call ENASCR  
ret