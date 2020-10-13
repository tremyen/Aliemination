; =============================================================================
; Desenhar a tela de entrada do jogo
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
TelaInicial:
  call SetScreen2_16x16       ; Seta a tela para screen 2 com sprites 16 x 16
  ; =========================================================================
  ; Escrever a mensagem de inicio de jogo
  ; =========================================================================
  ld hl,MsgInicioJogo
  ld d,1
  ld e,15
  call PrintString
  xor a
  call WaitEnter
  call ClearScreen
  call DISSCR    
    ; =========================================================================
    ; CARREGA AS TABELAS DO VDP
    ; =========================================================================
    call LoadSpritesTable     ; Carrega os sprites
    ; =========================================================================
    ; Desenhar Nave usa 2 sprites (0,1)
    ; =========================================================================
    ld a,(NumPosYNave)
    ld d,a
    ld a,(NumPosXNave)
    ld e,a
    call DesenharNave
    ; =========================================================================
    ; Desenhar Cidade usa 1 sprites (2)
    ; =========================================================================
    ld a,PosYCidade1
    ld d,a
    ld a,PosXCidade1
    ld e,a
    ld a,2                      ; posicao do sprite na tabela de atributos
    call DesenharCidade
    ; =========================================================================
    ; Desenhar Cidade 2 usa 1 sprite (3)
    ; =========================================================================
    ld a,PosYCidade2
    ld d,a
    ld a,PosXCidade2
    ld e,a
    ld a,3                      ; posicao do sprite na tabela de atributos
    call DesenharCidade
    ; =========================================================================
    ; Desenhar Cidade 3 usa 1 sprite (4)
    ; =========================================================================
    ld a,PosYCidade3
    ld d,a
    ld a,PosXCidade3
    ld e,a
    ld a,4                     ; posicao do sprite na tabela de atributos
    call DesenharCidade
    ; =========================================================================
    ; Desenhar Cidade 4 usa 1 sprite (5)
    ; =========================================================================
    ld a,PosYCidade4
    ld d,a
    ld a,PosXCidade4
    ld e,a
    ld a,5                     ; posicao do sprite na tabela de atributos
    call DesenharCidade
  call ENASCR  
ret