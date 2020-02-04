; =============================================================================
; Mover os torpedos na tela
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
; Sobe os torpedos de acordo com sua velocidade.
; Os torpedos são os sprites 28,29,30 e 31.
; =============================================================================
MoverTorpedos:
	ld a,(NumTorpedos)		        ; pega o numero de torpedos
  cp 0                          ; se nao existem torpedos
  jp z,FimMoverRestantes        ; nao preciso mover nada
	ld a,(flgTorpedos)						; pego o flag de torpedos ativos
	bit 0,a												; se o bit 0 esta setado
	call nz,MoverTorp28						; movemos torpedo 28
	bit 1,a
	call nz,MoverTorp29						; movemos torpedo 29
	bit 2,a
	call nz,MoverTorp30						; movemos torpedo 30
	bit 3,a
	call nz,MoverTorp31						; movemos torpedo 31
FimMoverRestantes:
ret

MoverTorp28:
	push af
		ld a,28
		push de												; bkp
		push hl												; bkp
			call CALATR  								; pega o endereco do sprite atual
			call RDVRM									; pega o conteudo do endereco byte 1(y)
			sub 5		                    ; a velocidade do torpedo eh 5
			call WRTVRM									; grava a nova posicao
			cp 5												; verifica se a posicao eh menor que 5
			call c,RemoveTorp28					; remove esse torpedo
		pop hl												; volta bkp
		pop de												; volta bkp
	pop af
ret

MoverTorp29:
	push af													; bkp
		ld a,29
		push de												; bkp
		push hl												; bkp
			call CALATR  								; pega o endereco do sprite atual
			call RDVRM									; pega o conteudo do endereco byte 1(y)
			sub 5		                    ; a velocidade do torpedo eh 5
			call WRTVRM									; grava a nova posicao
			cp 5												; verifica se a posicao eh menor que 5
			call c,RemoveTorp29					; remove esse torpedo
		pop hl												; volta bkp
		pop de												; volta bkp
	pop af 													; bkp
ret

MoverTorp30:
	push af
		ld a,30
		push de												; bkp
		push hl												; bkp
			call CALATR  								; pega o endereco do sprite atual
			call RDVRM									; pega o conteudo do endereco byte 1(y)
			sub 5		                    ; a velocidade do torpedo eh 5
			call WRTVRM									; grava a nova posicao
			cp 5												; verifica se a posicao eh menor que 5
			call c,RemoveTorp30					; remove esse torpedo
		pop hl												; volta bkp
		pop de												; volta bkp
	pop af
ret

MoverTorp31:
	push af
		ld a,31
		push de												; bkp
		push hl												; bkp
			call CALATR  								; pega o endereco do sprite atual
			call RDVRM									; pega o conteudo do endereco byte 1(y)
			sub 5		                    ; a velocidade do torpedo eh 5
			call WRTVRM									; grava a nova posicao
			cp 5												; verifica se a posicao eh menor que 5
			call c,RemoveTorp31					; remove esse torpedo
		pop hl												; volta bkp
		pop de												; volta bkp
	pop af
ret

; =============================================================================
