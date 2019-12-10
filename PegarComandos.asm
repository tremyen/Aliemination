; =============================================================================
; PegarComandos.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Pegar as entradas do jogador e gravar no buffer
; =============================================================================

; =============================================================================
; layout do buffer de entrada (BufKeyPresses)
; =============================================================================
; Todas as teclas que usamos estao na linha 8 do teclado
; 00000000 => 76543210
; se o bit 0 esta ligado,espaco foi pressionado
; se o bit 4 esta ligado,esquerda foi pressionado
; se o bit 5 esta ligado,cima foi pressionado
; se o bit 6 esta ligado,baixo foi pressionado
; se o bit 7 esta ligado,direita foi pressionado
; =============================================================================

; =============================================================================
; layout do Teclado do MSX
; =============================================================================
; row	       7       6	      5	    4	    3	      2	     1	    0
; =============================================================================
; row 0   = 7&   = 6^	    = 5%   = 4$	  = 3#   = 2@    = 1!   = 0)
; row 1	  = ;:	 = ]}	    = [{	 = \    = =+	 = -_	   = 9(	  = 8*
; row 2	  = B	   = A	    = DEAD = /?	  = .>	 = ,<	   = `~	  = '"
; row 3	  = J	   = I	    = H	   = G    =	F	   = E	   = D	  = C
; row 4	  = R	   = Q	    = P	   = O	  = N	   = M	   = L	  = K
; row 5	  = Z	   = Y	    = X	   = W	  = V	   = U	   = T	  = S
; row 6	  = F3	 = F2	    = F1	 = CODE	= CAPS = GRAPH = CTRL = SHIFT
; row 7	  = RET	 = SELECT =	BS	 = STOP	= TAB	 = ESC	 = F5	  = F4
; row 8	  = →	   = ↓	    = ↑	   = ←	  = DEL	 = INS	 = HOME = SPACE
; row 9	  = NUM4 = NUM3	  = NUM2 = NUM1	= NUM0 = NUM/  = NUM+ = NUM*
; row 10  =	NUM. = NUM,	  = NUM- = NUM9	= NUM8 = NUM7	 = NUM6 = NUM5
; =============================================================================
PegarComandos:
  xor a                     ; limpa o buffer
  ld a,8                    ; le a linha 8 para ver se as setas estao ligadas
  call KeyboardReadLine     ; carrega linha 8 no acumulador
  bit 0,a                   ; Se 0, adiciona um torpedo na posx da nave
  call z,AdicionaTorpedo
  bit 4,a                   ; Se 4 foi ligado, Esquerda
  call z,Esquerda
  bit 5,a                   ; Se 5 foi ligado, Subir
  call z,Subir
  bit 6,a                   ; Se 6 foi ligado, Descer
  call z,Descer
  bit 7,a                   ; Se 7 foi ligado, Direita
  call z,Direita
ret

AdicionaTorpedo:
ret

Direita:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosXNave         ; pega posicao x da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    add a,d                   ; tira a velocidade da coordenada X
    ld (hl),a                 ; guarda a posicao da nave
  pop af
ret

Subir:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosYNave         ; pega posicao y da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    sub d                     ; tira a velocidade da coordenada y
    ld (hl),a                 ; guarda a posicao da nave
  pop af
ret

Descer:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosYNave         ; pega posicao y da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    add a,d                   ; tira a velocidade da coordenada y
    ld (hl),a                 ; guarda a posicao da nave
  pop af
ret

Esquerda:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosXNave         ; pega posicao x da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    sub d                     ; tira a velocidade da coordenada X
    ld (hl),a                 ; guarda a posicao da nave
  pop af
ret
