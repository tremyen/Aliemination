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
  ; Checar se Torpedo colidiu
  ; ===============================================================
  ;call EliminarAliens
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
  ; Checar se Cidade 1 colidiu
  ; ===============================================================
  ld a,PosYCidade1
  ld h,a
  ld a,PosXCidade1
  ld l,a
  call ChecarAlienXY
  cp 1
  call z,DestroiCidade1    ; A cidade 1 foi destruida!
  ; ===============================================================
  ; ===============================================================
  ; Checar se Cidade 2 colidiu
  ; ===============================================================
  ld a,PosYCidade2
  ld h,a
  ld a,PosXCidade2
  ld l,a
  call ChecarAlienXY
  cp 1
  call z,DestroiCidade2    ; A cidade 2 foi destruida!
  ; ===============================================================
  ; ===============================================================
  ; Checar se Cidade 3 colidiu
  ; ===============================================================
  ld a,PosYCidade3
  ld h,a
  ld a,PosXCidade3
  ld l,a
  call ChecarAlienXY
  cp 1
  call z,DestroiCidade3    ; A cidade 3 foi destruida!
  ; ===============================================================
  ; ===============================================================
  ; Checar se Cidade 4 colidiu
  ; ===============================================================
  ld a,PosYCidade4
  ld h,a
  ld a,PosXCidade4
  ld l,a
  call ChecarAlienXY
  cp 1
  call z,DestroiCidade4    ; A cidade 4 foi destruida!
  ; ===============================================================
FimColisoes:
ret

; ============================================================================
; Destruir Cidade
; ============================================================================
DestroiCidade1:
  ld a,1
  call RemoverCidade
ret
DestroiCidade2:
  ld a,2
  call RemoverCidade
ret
DestroiCidade3:
  ld a,3
  call RemoverCidade
ret
DestroiCidade4:
  ld a,4
  call RemoverCidade
ret
; ============================================================================
