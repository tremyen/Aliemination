; ============================================================================
; PassarDeNivel
; ============================================================================
; Passar de nivel
; ============================================================================
PassarDeNivel:
push af
	ld a,(NumNivel)			; pega o numero do nivel 
	inc a					; aumenta o nivel em 1 
	cp 5                    ; se for 5 ja chegamos no maximo
	jr z,NivelMaximo		; não podemos passar do nivel 4
  	ld (NumNivel),a			; carregamos o novo nivel
NivelMaximo:	
	ld a,10					; prepara o loop de limpeza de aliens
LoopLimpaAliens:
	call RemoverAlien		; remove o alien atual
	cp 25 					; os aliens vao ate a posicao 25
	jp z,LimpeiOsAliens		; se eh zero limpamos todos
	inc a					; senao limpamos o proximo
	jp LoopLimpaAliens		; loop
LimpeiOsAliens:
	xor a                   ; seta o numero de aliens para zero
	ld (NumAliens),a        ; limpa o contador de aliens geral 
    ld (NumContColuna1),a   ; limpa o contador da coluna
    ld (NumContColuna2),a   ; limpa o contador da coluna
    ld (NumContColuna3),a   ; limpa o contador da coluna
    ld (NumContColuna4),a   ; limpa o contador da coluna
pop af
ret
; ============================================================================