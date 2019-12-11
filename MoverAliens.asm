; =============================================================================
; Mover os Aliens na tela
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
; Desce os aliens de acordo com sua velocidade.
; Os aliens são todos os sprites maiores ou iguais a 10.
; =============================================================================
MoverAliens:
	push af
		push bc
	    ld hl,NumAliens		            ; pega o endereco do num de aliens
			ld a,(hl)							        ; pega o conteudo do endereco
	    cp 0                          ; se nao existem aliens
	    jp z,FimMoveAliens            ; nao preciso mover nada
			ld b,a												; guarda para loop
     	add a,9 											; comeco pelo ultimo alien
LoopMoveAliens:
			call CALATR  									; pega o endereco do sprite atual
			call RDVRM										; pega o conteudo do endereco byte 1(y)
			inc a                         ; desce uma posicao
      call WRTVRM                   ; atualiza
      dec b                         ; controla o loop
      ld a,b                        ; pega o sprite anterior
      cp 0                          ; verifica se movemos todos os aliens
      jr z,FimMoveAliens 		        ; acabou o loop
      add a,9                       ; pega o proximo
      jr LoopMoveAliens	            ; move o proximo
FimMoveAliens:
		pop bc
	pop af
ret
; =============================================================================
