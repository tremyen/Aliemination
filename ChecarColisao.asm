; =============================================================================
; ChecarColisao.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Testa as colisoes dos sprites na tela
; =============================================================================
ChecarColisao:
  call CheckVdpColision ; checar se o vdp detectou uma colisao de sprites
  cp 0                  ; se nao rolou uma batida
  jp z,FimColisoes      ; nao houve colisao, terminar
  ; ===============================================================
  ; Checar se Nave colidiu
  ; ===============================================================
  ld a,(NumPosYNave)
  ld h,a
  ld a,(NumPosXNave)
  ld l,a
  call ChecarAlienXY
  cp 1
  jp z,RecomecaNivel      ; a nave foi atingida! fim do jogo
  ; ===============================================================
  ; Checar se Cidade colidiu
  ; ===============================================================
  ld a,(PosYCidade1)
  ld h,a
  ld a,(PosXCidade1)
  ld l,a
  call ChecarAlienXY
  cp 1
  jp z,DestroiCidade1    ; A cidade 1 foi destruida!
FimColisoes:
ret

; ============================================================================
; Recomecar o nivel em caso de colisao com a nave
; ============================================================================
RecomecaNivel:
  push af
    ld a,(NumVidaJogador)
    dec a
    ld (NumVidaJogador),a
  pop af
  jp startCode
ret
; ============================================================================

; ============================================================================
; Destruir Cidade
; ============================================================================
DestroiCidade1:
  ld a,1
  call RemoverCidade
ret
