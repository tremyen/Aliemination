; =============================================================================
; Mover os Aliens na tela
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
; Desce os aliens de acordo com sua velocidade.
; Os aliens são todos os sprites maiores ou iguais a 10.
; =============================================================================
; Altera
; A
; =============================================================================
MoverAliens:
	ld a,(NumAliens)						; pega o numero de aliens
  cp 0                        ; se nao existem aliens
  jp z,FimMoveAliens          ; nao preciso mover nada
  add a,9 										; pego ultimo alien
LoopMoveAliens:
	push af
	push bc
	push de
	push hl
		ld d,a										; guarda o numero do alien testado
		call CALATR  							; pega o endereco do sprite atual
		call RDVRM								; pega o conteudo do endereco byte 1(y)
		inc a                     ; desce uma posicao
  	call WRTVRM               ; atualiza		
	pop hl
	pop de
	pop bc
	pop af
  dec a                       ; controla o loop
  cp 9	                      ; verifica se movemos todos os aliens
  jr z,FimMoveAliens 		      ; acabou o loop
  jr LoopMoveAliens	          ; move o proximo
FimMoveAliens:
ret
; =============================================================================
