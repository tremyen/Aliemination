; =============================================================================
; Mover os Aliens na tela
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
; Desce os aliens de acordo com sua velocidade. Os aliens são todos os sprites
; maiores ou iguais a 18.
; =============================================================================
MoverAliens:
	push af
		push bc
			ld a,(NumInimigos)						; pega o ultimo sprite inimigo
			ld b,a												; guarda para comparacao
			ld d,14
LoopMoveAlien:
			ld a,d	 											; pega o sprite atual (comeca no 18)
			add a,4												; cada bloco tem 4 bytes
			ld d,a												; guarda o ultimo sprite movido
			call CALATR 									; pega o endereco do sprite atual
			ld a,(hl)											; pega o conteudo do endereco
			ld c,a												; guarda a posicao y do sprite (byte 1)
			ld a,(VelAlien)								; pega a velociadade atual
			add a,c												; soma a posicao atual com a velocidade
			cp 191 												; testa se a posicao e a mais baixa da tela
			jp nc,PosicaoMaisBaixa				; se for sempre chapa 191
			ld (hl),a											; carrega a nova posicao
PosicaoOk:
			ld a,d												; pega o sprite atual
			cp b													; verifica se eh o ultimo
			jp nc,MoveuTodosAliens
			jp LoopMoveAlien
MoveuTodosAliens:
		pop bc
	pop af
ret

PosicaoMaisBaixa:
			ld (hl),191
jp PosicaoOk

; =============================================================================
