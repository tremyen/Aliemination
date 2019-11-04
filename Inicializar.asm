; =============================================================================
;  Inicializar o ambiente do jogo
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
Inicializar:

  ; ===========================================================================
  ; Inicializa a tela
  ; ===========================================================================
  call DISSCR                 ; desligo a tela
    call SetScreen2_16x16     ; Seta a tela para screen 2 com sprites 16 x 16
    call LimparTela           ; e limpa a tela
  call ENASCR                 ; ligo a tela
  ; ===========================================================================

  ; ===========================================================================
  ; Inicializar momento 0 do jogo
  ; ===========================================================================
  ld a,120                    ; Prepara a posicao inicial da Nave (X)
  ld (PosicaoXNave),a         ; Carrega a posicao X da nave
  ld a,88                     ; Prepara a posicao inicial da Nave (Y)
  ld (PosicaoYNave),a         ; Carrega a posicao Y da nave
  xor a                       ; Zera a pontuacao
  ld (Semana),a               ; Carrega a pontuacao na sua variavel
  ; ===========================================================================

ret
