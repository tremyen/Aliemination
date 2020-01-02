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
    jp z,FimMoveTorpedos          ; nao preciso mover nada
		add a,27											; os torpedos comecam no sprite 28
		ld b,a												; guarda o maior sprite para loop
		ld a,28     									; os torpedos comecam no sprite 28
LoopRemoveTorpedos:
		ld c,a 												; guarda o numero do sprite para uso
		push af												; alterado por CALATR
		push de												; alterado por CALATR
			call CALATR  								; pega o endereco do sprite atual
			call RDVRM									; pega o conteudo do endereco byte 1(y)
    	cp 1                        ; se a coordenada eh 1
			call z,RemoverTorpedo       ; matamos o sprite
		pop de
		pop af
    cp b                          ; verifica se removemos todos os torpedos
    jr z,FimRemoveTorpedos        ; acabou o loop
		inc a
jr LoopRemoveTorpedos          		; move o proximo
FimRemoveTorpedos:
	ld a,(NumTorpedos)		        ; pega o numero de torpedos
  cp 0                          ; se nao existem torpedos
  jp z,FimMoveTorpedos          ; nao preciso mover nada
	add a,27											; os torpedos comecam no sprite 28
	ld b,a												; guarda para loop
	ld a,28     									; os torpedos comecam no sprite 28
LoopMoveTorpedos:
	ld c,a 												; guarda o numero do sprite para uso
	push af												; alterado por CALATR
	push de												; alterado por CALATR
		call CALATR  								; pega o endereco do sprite atual
		call RDVRM									; pega o conteudo do endereco byte 1(y)
		dec a												; sobe uma posicao
		call WRTVRM									; grava a nova posicao
	pop de
	pop af
	cp b                          ; verifica se movemos todos os torpedos
	jr z,FimMoveTorpedos        	; acabou o loop
	inc a
jr LoopMoveTorpedos          	; move o proximo
FimMoveTorpedos:
ret
; =============================================================================
