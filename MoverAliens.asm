; =============================================================================
; Mover os Aliens na tela
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
; Desce os aliens de acordo com sua velocidade.
; Os aliens são todos os sprites maiores ou iguais a 10.
; =============================================================================
MoverAliens:
	ld a,(NumAliens)						; pega o numero de aliens
  cp 0                        ; se nao existem aliens
  jp z,FimMoveAliens          ; nao preciso mover nada
	ld b,a											; guarda numero de aliens para loop
  add a,9 										; pego ultimo alien
	ld c,a											; guardo ultimo alien para uso futuro
LoopMoveAliens:
	push af
	push bc
	push de
	push hl
		call CALATR  								; pega o endereco do sprite atual
		call RDVRM									; pega o conteudo do endereco byte 1(y)
		inc a                       ; desce uma posicao
  	call WRTVRM                 ; atualiza
	pop hl
	pop de
	pop bc
	pop af
  dec b                       ; controla o loop
  ld a,b                      ; move para comparar
  cp 0                        ; verifica se movemos todos os aliens
  jr z,FimMoveAliens 		      ; acabou o loop
	ld a,c 											; se nao acabamos pegamos o alien atual
  dec a                       ; pega o alien anterior
	ld c,a											; guarda novo alien atual para uso futuro
  jr LoopMoveAliens	          ; move o proximo
FimMoveAliens:
ret
; =============================================================================
