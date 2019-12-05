; =============================================================================
; PegarComandos.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Pegar as entradas do jogador e gravar no buffer
; =============================================================================

; =============================================================================
; layout do buffer de entrada (BufKeyPresses)
; =============================================================================
; 00000000 => 76543210
; ESQUERDA = 0
; DIREITA  = 1
; BAIXO    = 2
; CIMA     = 3
; TIRO     = 4
; NU       = 5
; NU       = 6
; NU       = 7
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
  call KeyboardCleanBuffer
  ld a,8                    ; le a linha 8 para ver se as setas estao ligadas
  bit 7,
  call KeyboardReadLine     ; carrega no buffer a linha 1


ret
