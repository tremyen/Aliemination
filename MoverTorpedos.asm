; =============================================================================
; Mover os torpedos na tela
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
; Sobe os torpedos de acordo com sua velocidade.
; Os torpedos são os sprites 28,29,30 e 31.
; =============================================================================
MoverTorpedos:
	call LimparTorpedos							; remove os torpedos que erraram
	call MoverRestantes 						; move os torpedos que sobraram
ret

LimparTorpedos:
	  ld a,(NumTorpedos)		        ; pega o numero de torpedos
    cp 0                          ; se nao existem torpedos
    jp z,FimLimparTorpedos        ; nao preciso mover nada
		add a,27											; os torpedos comecam no sprite 28
		ld b,a												; guarda o maior sprite para loop
		ld c,28     									; os torpedos comecam no sprite 28
LoopLimparTorpedos:
		push af 											; bkp
			push bc 										; bkp
			push de											; bkp
				ld a,c 										; pega o sprite atual
				call ReadSprite 					; pega o sprite atual
				ld a,d										; pega coordenada y
			pop de											; volta bkp
			pop bc											; volta bkp
    	cp 5	                      ; se a coordenada eh menor que 5 
			call c,RemoverTorpedo       ; matamos o sprite
		pop af												; volta bkp
		ld a,c 												; pega o sprite atual
    cp b                          ; verifica se removemos todos os torpedos
    jr z,FimLimparTorpedos        ; acabou o loop
		inc a													; proximo sprite
		ld c,a 												; guadra proximo sprite
jr LoopLimparTorpedos          		; move o proximo
FimLimparTorpedos:
ret

MoverRestantes:
	ld a,(NumTorpedos)		        ; pega o numero de torpedos
  cp 0                          ; se nao existem torpedos
  jp z,FimMoverRestantes        ; nao preciso mover nada
	add a,27											; os torpedos comecam no sprite 28
	ld b,a												; guarda para loop
	ld a,28     									; os torpedos comecam no sprite 28
LoopMoverRestantes:
	push af												; bkp
	push de												; bkp
	push hl												; bkp
		call CALATR  								; pega o endereco do sprite atual
		call RDVRM									; pega o conteudo do endereco byte 1(y)
		sub 5		                    ; a velocidade do torpedo eh 5
		call WRTVRM									; grava a nova posicao
	pop hl												; volta bkp
	pop de												; volta bkp
	pop af												; volta bkp
	cp b                          ; verifica se movemos todos os torpedos
	jr z,FimMoverRestantes       	; acabou o loop
	inc a													; proximo torpedo
jr LoopMoverRestantes        		; move o proximo
FimMoverRestantes:
ret
; =============================================================================
