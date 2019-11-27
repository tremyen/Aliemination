; =============================================================================
; Inputs.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Driver para teclado e joystick do MSX
; =============================================================================

; =============================================================================
; Portas para uso da entrada do MSX
; =============================================================================
; #A8     PPI-register A				Registrador de selecao do slot primário.
; #A9 (R) PPI-register B				registrador de linha da Matrix do teclado.
; #AA     PPI-register C				Interface com o teclado e com o gravador.
; #AB (W) Registrador de envio de comando.
; =============================================================================

; =============================================================================
; PPI - Registrador C (#AA) - descrição dos bits
; =============================================================================
; 0-3 => Registrador de selecao de linha da matrix do teclado.
; A linha da matrix pode ser lida pelo registardor do PPI B (#A9).;
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
KeyboardScanner_LineCount equ 13
KeyboardScanner_LineWidth equ 8

KeyboardScanner_AllowJoysticks:
	xor a
	ld (KeyboardScanner_NoJoy-1),a
ret

Keyboard:
KeyboardScanner_Read:
	di
		ld hl,KeyboardScanner_KeyPresses
		ld b,0														; lets read the keyboard!
keynextline:
		in	a,(#AA)	;Read current state
		and	#F0														; only change bits 0-3
		or	b															; take row number from B
	  out	(#AA),a 											; Update new state
		in a,(#A9)												; read row into A
		ld (hl),a
		inc hl
		inc b
		ld a,b
		cp 11
		jp nz,keynextline									; Stop when we get to line 11
ret
KeyboardScanner_NoJoy:
		ld b,2															; vamos ler 2 joysticks
joynextjoy:
		ld a, 15		 												; AY port 15 (kana LED state)
		out	(&A0), a												; &A0 = AY Register write port
		in a, (&A2) 												; &A2 = Value read port
		and	128															; kana led state
		ld c,a															; store it for later
		ld a,b															; Joystick no (2/1)
		dec a 															; Converted to 1/0
		rrca
		rrca																; Coverted to 64/0
		add 15															; Allow input from all joystick ports
		or c
		out	(&A1), a												; &A1 = Value Write ports
		ld	a, 14														; Select Reg 14 (AY Port 14)
		out	(&A0), a												; &A0 = Register write port
		in	a, (&A2) 												; &A2 = read left right up down
																				; and button 1 and 2
		or %11000000												; fill in the blanks
		ld (hl),a
		inc hl
		djnz joynextjoy											;Repeat for Joy 1
	ei
ret

; Mapa de teclado do MSX
HardwareKeyMap:
		db "0","1","2","3","4","5","6","7"
		db "8","9","-","=","\","[","]",";"
		db "'","`",",",".","/","d","A","B"
		db "C","D","E","F","G","H","I","J"
		db "K","L","M","N","O","P","Q","R"
		db "S","T","U","V","W","X","Y","Z"
		db "s","c","g","c","o","1","2","3"
		db "4","5","e","t","s",KeyChar_Backspace,"s",KeyChar_Enter
		db " ","h","i","d","1","3","+","q"
		db "*","+","/","0","1","2","3","4"
		db "5","6","7","8","9","-",",","."
