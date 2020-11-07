; =============================================================================
;  Atualizar HUD
; =============================================================================
;  (C) 2019 Manoel Neto - tremyen@gmail.com
;  Mude, compartilhe e estude. Conhecimento é de graça.
;
; Atualiza os dados para o jogador
; =============================================================================
AtualizarHud:
    push de
    push hl
    push af 
    ; ===========================================================================
    ; Atualizar nivel
    ; =========================================================================== 
    ld d,1					; carregamos posicao x da mensagem
	ld e,1					; carregamos posicao y da mensagem
	ld hl,MsgNivel			; carregamos a mensagem
	call PrintString		; imprimimos a mensagem
    ld a,(NumNivel)         ; lemos a variavel com o valor 
	call ConvNumChar		; Convertemos em CHR
	call GRPPRT				; imprimimos o numero do nivel atual
    ; ===========================================================================
    ; Atualizar Inimigos
    ; =========================================================================== 
    ld d,65 				; carregamos posicao x da mensagem
	ld e,1					; carregamos posicao y da mensagem
	ld hl,MsgInimigos		; carregamos a mensagem
	call PrintString		; imprimimos a mensagem
    ld a,(NumAliens)        ; lemos a variavel com o valor 
	call ConvNumChar		; Convertemos em CHR
	call GRPPRT				; imprimimos o numero do nivel atual
    pop af 
    pop hl 
    pop de
ret
; =============================================================================