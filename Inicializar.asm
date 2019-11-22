; =============================================================================
;  Inicializar o ambiente do jogo
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
Inicializar:
  call LimpaMem

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
  ld (PosXNave),a             ; Carrega a posicao X da nave
  ld a,88                     ; Prepara a posicao inicial da Nave (Y)
  ld (PosYNave),a             ; Carrega a posicao Y da nave
  ld a,1                      ; Prepara as vidas do jogador
  ld (VidaJogador),a          ; Carrega a vida do jogador
  ld a,3
  ld (VelAlien),a             ; Carrega a velocidade do Alien
  ld a, 16                    ; inicializa primeiro Alien (Y)
  ld (PosYAlien),a            ; Carrega posicao Y ALien
  ld a, 120                   ; inicializa primeiro Alien (X)
  ld (PosXAlien),a            ; Carrega posicao X ALien
  xor a                       ; Zera a pontuacao
  ld (Semana),a               ; Carrega a pontuacao na sua variavel
  ld a,18
  ld (NumInimigos),a          ; Carrega a posicao dos inimigos
  ; ===========================================================================

ret
