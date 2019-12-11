; =============================================================================
; KEYBOARD.ASM
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Driver para teclado do MSX
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

; =============================================================================
; Portas para uso da entrada do MSX
; =============================================================================
; #A8     PPI-register A				Registrador de selecao do slot primário.
; #A9 (R) PPI-register B				registrador de linha da Matrix do teclado.
; #AA     PPI-register C				Interface com o teclado e com o gravador.
; #AB (W) Registrador de envio de comando.
; =============================================================================
PPIA:				EQU 0xA8
PPIB:				EQU 0xA9
PPIC:				EQU 0xAA
PPICOMMAND:	EQU 0xAB
; =============================================================================
; PPI - Registrador C (#AA) - descrição dos bits
; =============================================================================
; 0-3 => Registrador de selecao de linha da matrix do teclado.
; A linha da matrix pode ser lida pelo registardor do PPI B (#A9)
; 4 => Controle do motor do K7. 1 = Desligado.
; 5 => Sinal de escrita do K7. 1 = Alto.
; 6 => Led do capslock do teclado. 1 = Desligado.
; 7 => Saída do som de clique do teclado. 1 = Alto.
; =============================================================================

; =============================================================================
; O PSG tem duas portas adicionais de entrada e saida nos registradores 15/15.
; No padrão MSX elas são usadas para as operacoes de I/O de diversos aparelhos,
; comparavel com o PPI e trabalhando em conjunto com ele.
; =============================================================================
; PSG I/O port A (r#14) ? Apenas leitura
; 0 Input joystick pin 1 0 = up
; 1 Input joystick pin 2 0 = down
; 2 Input joystick pin 3 0 = left
; 3 Input joystick pin 4 0 = right
; 4 Input joystick pin 6 0 = trigger A
; 5 Input joystick pin 7 0 = trigger B
; 6 Japanese keyboard layout bit 1 = JIS, 0 = ANSI/AIUEO/50on
; 7 Cassette input signal
; =============================================================================
; PSG I/O port B (r#15) ? Leitura e escrita
; 0 Output joystick port 1, pin 6 Set to 1 to allow input
; 1 Output joystick port 1, pin 7 Set to 1 to allow input
; 2 Output joystick port 2, pin 6 Set to 1 to allow input
; 3 Output joystick port 2, pin 7 Set to 1 to allow input
; 4 Output joystick port 1, pin 8
; 5 Output joystick port 2, pin 8
; 6 Joystick input selection, for r#14 inputs 1 = port 2
; 7 Kana led control 1 = off
; =============================================================================

; =============================================================================
; Ler a entrada do teclado em seu buffer
; =============================================================================
; Parametros
; A => linha do teclado a ser lida
; =============================================================================
; Altera
; A => byte com as teclas (0 solta 1 pressionada)
; =============================================================================
Keyboard:
	call SNSMAT								; le a linha na matrix do teclado
ret
; =============================================================================
