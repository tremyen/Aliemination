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
  ld a,3                      ; Prepara a velocidade dos aliens
  ld (VelAlien),a             ; Carrega a velocidade do Alien
  ld a,9                      ; Prepara o num de inimigos
  ld (NumSprites),a           ; Os inimigos comecam a partir do sprite 9 
  xor a                       ; Zera A
  ld (Semana),a               ; zera a pontuacao
  ld (NumContColuna1),a       ; zera os inimigos na coluna 1
  ld (NumContColuna2),a       ; zera os inimigos na coluna 2
  ld (NumContColuna3),a       ; zera os inimigos na coluna 3
  ld (NumContColuna4),a       ; zera os inimigos na coluna 4
  ; ===========================================================================
ret
