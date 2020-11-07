; =============================================================================
; ChecarColisao.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Testa as colisoes dos sprites na tela
; =============================================================================
; Para que haja uma colisao, devemos checar se um dos aliens da fila de aliens 
; esta dentro da hitbox dos objetos destruiveis (Nave, cidades ou torpedos).
; devemos checar a posicao X/Y do alien contra todas as posicoes da hitbox do
; objeto, e entao preencher o flag de colisao.
;
; Flag de colisao =>  0 0 0 0 0 N X Y
; como so existe colisao se tanto X quanto Y estiverem na hitbox, uma colisao 
; sera igual a 00000011 = 3. 
;
; Caso a nave sofra uma colisao, o jogo termina. Bit 3 do flag é setado
; Caso o alien colida na cidade, a cidade e destruida.
; Caso o contador de cidades cheque a zero, o jogo termina.
; Caso um torpedo colida com um alien, o torpedo e o alien são removidos 
; =============================================================================
ChecarColisao:
  call CheckVdpColision         ; checar se o vdp detectou uma colisao de sprites
  cp 0                          ; se nao rolou uma batida
  jp z,FimColisoes              ; nao houve colisao, terminar
  call ChecarColisaoNave        ; verifica se a nave colidiu
  cp 3                          ; se temos colisao em x e Y
  ret z                         ; retornamos, o jogo acabou
  ;call ChecarColisaoCidades    ; limpa as cidades e os aliens que colidiram
  ;call ChecarColisaoTorpedos   ; limpa os torpedos e alien que colidiram
FimColisoes:
ret

 ; ===============================================================
 ; Checar se Nave colidiu
 ; ===============================================================
ChecarColisaoNave: 
  ld a,(NumPosYNave)
  ld h,a
  ld a,(NumPosXNave)
  ld l,a
  call ChecarAlienXY
  ld a,(flgColisaoAlien)
ret 

ChecarColisaoTorpedos:
  ; ===============================================================
  ; Checar se Torpedos colidiram
  ; ===============================================================
  ld a,28
  call ReadSprite         ; le o torpedo 28
  ld h,d                  ; pegamos y do torpedo
  ld l,e                  ; pegamos x do torpedo
  call ChecarAlienXY      ; Checar se temos um alien nessa hitbox
  cp 1                    ; se teve colizao
  call z,RemoveTorp28     ; remove o torpedo 28
  ; ===============================================================
  ld a,29
  call ReadSprite         ; le o torpedo
  ld h,d                  ; pegomos y do torpedo
  ld l,e                  ; pegamos x do torpedo
  call ChecarAlienXY      ; Checar se temos um alien nessa hitbox
  cp 1                    ; se teve colizao
  call z,RemoveTorp29     ; remove o torpedo
  ; ===============================================================
  ld a,30
  call ReadSprite         ; le o torpedo
  ld h,d                  ; pegomos y do torpedo
  ld l,e                  ; pegamos x do torpedo
  call ChecarAlienXY      ; Checar se temos um alien nessa hitbox
  cp 1                    ; se teve colizao
  call z,RemoveTorp30     ; remove o torpedo
  ; ===============================================================
  ld a,31
  call ReadSprite         ; le o torpedo
  ld h,d                  ; pegomos y do torpedo
  ld l,e                  ; pegamos x do torpedo
  call ChecarAlienXY      ; Checar se temos um alien nessa hitbox
  cp 1                    ; se teve colizao
  call z,RemoveTorp31     ; remove o torpedo
ret 

ChecarColisaoCidades:
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
ret