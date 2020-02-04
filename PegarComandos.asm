; =============================================================================
; PegarComandos.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Pegar as entradas do jogador e gravar no buffer
; =============================================================================

; =============================================================================
; layout do buffer de entrada
; =============================================================================
; Todas as teclas que usamos estao na linha 8 do teclado
; 00000000 => 76543210
; se o bit 0 esta ligado,espaco foi pressionado
; se o bit 4 esta ligado,esquerda foi pressionado
; se o bit 5 esta ligado,cima foi pressionado
; se o bit 6 esta ligado,baixo foi pressionado
; se o bit 7 esta ligado,direita foi pressionado
; =============================================================================
PegarComandos:
    xor a                     ; limpa o buffer
    ld a,8                    ; le a linha 8 para ver se as setas estao ligadas
    call Keyboard             ; carrega linha 8 no acumulador
    bit 0,a                   ; Se 0, adiciona um torpedo na posx da nave
    call z,Tiro
    bit 4,a                   ; Se 4 foi ligado, Esquerda
    call z,Esquerda
    bit 5,a                   ; Se 5 foi ligado, Subir
    call z,Subir
    bit 6,a                   ; Se 6 foi ligado, Descer
    call z,Descer
    bit 7,a                   ; Se 7 foi ligado, Direita
    call z,Direita
ret
Tiro:
  push af
    ld a,(NumTorpedos)      	; pegar numero de torpedos
    cp 5                    	; fila cheia
    jp z,FimAdicionarTorpedo 	; se tiver 4, nao adiciona
    inc a                   	; adicionamos um torpedo
    ld (NumTorpedos),a      	; atualizamos a variavel NumTorpedos
  	ld a,(flgTorpedos)				; pega o flag de torpedos
  	bit 0,a
  	jp z,AdicionaPosicao28
  	bit 1,a
  	jp z,AdicionaPosicao29
  	bit 2,a
  	jp z,AdicionaPosicao30
  	bit 3,a
  	jp z,AdicionaPosicao31
AdicionaPosicao28:
    ld a,(NumPosYNave)      		; pegar posicao y da nave
    sub 16                 			; coordenada y = NumPosYNave-16
    ld d,a                  		; Guarda a posicao y
    ld a,(NumPosXNave)      		; pegar posicao x da nave
    ld e,a                  		; Guarda a posicao X
    ld a,28											; desenhar o torpedo na posicao 28
    call DesenharTorpedo				; da tabela de atributos
    ld a,(flgTorpedos)					; pega o flag de torpedos
    set 0,a 										; liga o flag
    ld (flgTorpedos),a 					; salva o flag
    jp FimAdicionarTorpedo
AdicionaPosicao29:
  	ld a,(NumPosYNave)      		; pegar posicao y da nave
  	sub 16                 			; coordenada y = NumPosYNave-16
  	ld d,a                  		; Guarda a posicao y
  	ld a,(NumPosXNave)      		; pegar posicao x da nave
  	ld e,a                  		; Guarda a posicao X
  	ld a,29
  	call DesenharTorpedo
  	ld a,(flgTorpedos)					; pega o flag de torpedos
  	set 1,a 										; liga o flag
  	ld (flgTorpedos),a 					; salva o flag
  	jp FimAdicionarTorpedo
AdicionaPosicao30:
  	ld a,(NumPosYNave)      		; pegar posicao y da nave
  	sub 16                 			; coordenada y = NumPosYNave-16
  	ld d,a                  		; Guarda a posicao y
  	ld a,(NumPosXNave)      		; pegar posicao x da nave
  	ld e,a                  		; Guarda a posicao X
  	ld a,30
  	call DesenharTorpedo
  	ld a,(flgTorpedos)					; pega o flag de torpedos
  	set 2,a 										; liga o flag
  	ld (flgTorpedos),a 					; salva o flag
  	jp FimAdicionarTorpedo
AdicionaPosicao31:
  	ld a,(NumPosYNave)      		; pegar posicao y da nave
  	sub 16                 			; coordenada y = NumPosYNave-16
  	ld d,a                  		; Guarda a posicao y
  	ld a,(NumPosXNave)      		; pegar posicao x da nave
  	ld e,a                  		; Guarda a posicao X
  	ld a,31
  	call DesenharTorpedo
  	ld a,(flgTorpedos)					; pega o flag de torpedos
  	set 3,a 										; liga o flag
  	ld (flgTorpedos),a 					; salva o flag
FimAdicionarTorpedo:
  pop af
ret

Direita:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosXNave         ; pega posicao x da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    cp 240                    ; A nave nao pode sair da tela
    jp nc,PosMaximaDir        ; na posicao maxima, nao se move mais
    add a,d                   ; tira a velocidade da coordenada X
    ld (hl),a                 ; guarda a posicao da nave
PosMaximaDir:
  pop af
ret

Subir:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosYNave         ; pega posicao y da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    cp 70                     ; A nave nao pode sair da tela
    jp c,PosMaximaSub         ; na posicao maxima, nao se move mais
    sub d                     ; tira a velocidade da coordenada y
    ld (hl),a                 ; guarda a posicao da nave
PosMaximaSub:
  pop af
ret

Descer:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosYNave         ; pega posicao y da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    cp 101                    ; A nave nao pode sair da tela
    jp nc,PosMaximaDes        ; na posicao maxima, nao se move mais
    add a,d                   ; tira a velocidade da coordenada y
    ld (hl),a                 ; guarda a posicao da nave
PosMaximaDes:
  pop af
ret

Esquerda:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosXNave         ; pega posicao x da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    cp 1                      ; A nave nao pode sair da tela
    jp c,PosMaximaEsq         ; na posicao maxima, nao se move mais
    sub d                     ; tira a velocidade da coordenada X
    ld (hl),a                 ; guarda a posicao da nave
PosMaximaEsq:
  pop af
ret
