; =============================================================================
;  Inicializar o ambiente do jogo
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
Inicializar:
  call LimpaMem
  ; ===========================================================================
  ; Verifico se o MSX eh PAL ou NTSC
  ; ===========================================================================
  ld a,NTSC               ; a princípio eh NTSC
  ld (vdpCycle1),a        ; carrego o valor 1/10s (1 ciclo de VDP)
  ld a,NTSC*10            ; multiplico por 10
  ld (vdpCycle5),a        ; carrego o valor 1s (5 ciclos de VDP)
  ld a,(0x002b)           ; leio a versão do MSX na ROM
  bit 7,a                 ; se o bit 7 for 1 é 50Hz senão é 60Hz
  jr z, noPalAdjust       ; sendo 0 eu sigo adiante
palAdjust:
  ld a,PAL                ; defino o novo valor para PAL
  ld (vdpCycle1),a        ; o valor para 1/10s em PAL
  ld a,PAL*10             ; 1/10*10=1, certo?
  ld (vdpCycle5),a        ; o valor é o de 1s em PAL
noPalAdjust:
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
  ld (NumPosXNave),a          ; Carrega a posicao X da nave
  ld a,88                     ; Prepara a posicao inicial da Nave (Y)
  ld (NumPosYNave),a          ; Carrega a posicao Y da nave
  ld a,1                      ; Prepara as vidas do jogador
  ld (NumVidaJogador),a       ; Carrega a vida do jogador
  ld (NumVelNave),a           ; Carrega a velocidade da nave
  ld a,1                      ; Prepara a velocidade dos aliens
  ld (NumVelAlien),a          ; Carrega a velocidade do Alien
  xor a                       ; Zera A
  ld (NumSemana),a            ; zera a pontuacao
  ld (NumTorpedos),a          ; zera o numero de torpedo
  ld (NumAliens),a            ; zera o nuemro de aliens
  ld (NumContColuna1),a       ; zera os inimigos na coluna 1
  ld (NumContColuna2),a       ; zera os inimigos na coluna 2
  ld (NumContColuna3),a       ; zera os inimigos na coluna 3
  ld (NumContColuna4),a       ; zera os inimigos na coluna 4
  ; ===========================================================================
ret
