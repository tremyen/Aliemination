; =============================================================================
; Library.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Funcoes ASM de uso geral para o MSX
; =============================================================================

; =============================================================================
; Sortear Numero randomico
; =============================================================================
; A => Numero maximo do sorteio
; =============================================================================
; Altera => A (Numero aleatorio de 0 ate A)
; =============================================================================
RandomNumber:
	push bc
	push de
		ld b,a						; Numero Maximo Sorteio
		ld a,128					; Dividir 128 pelo tamanho numero maximo
		ld d,0						; contador de subtracao sucessivas
DvPTamanho:
		sub b    					; comeca a divisao pelo tamanho maximo
		inc d						; aumenta o acumulador
		jr nc, DvPTamanho		  	; repete enquanto nao tem "vai um"
		dec d						; elimina o resto
		ld a,d						; nesse momento D tem o divisior ideal
		ld b,a						; carrega o divisor ideal
		ld a,r						; Gera um aleatorio entre 0 e 127
		ld d,0						; contador de subtracao sucessivas
DvPIdeal:
		sub b 						; comeca a divisao pelo divisor ideal
		inc d						; aumenta o acumulador
		jr nc, DvPIdeal 			; repete enquanto nao tem "vai um"
		dec d						; elimina o resto
		ld a,d						; Retorna o numero aleatorio
	pop de
	pop bc
ret
; =============================================================================

; =============================================================================
; Desenhar a Nave
; =============================================================================
; Parametros
; d => Coordenada Y da nave
; e => Coordenada X da nave
; =============================================================================
; Altera => Nada
; =============================================================================
DesenharNave:
	push af
	push bc
	  	;=============================
	  	; Coloca Sprite da nave cor 1
	  	;=============================
	  	ld b,0
	  	ld c,1
		xor a
	  	call PutSprite
		;=============================
	 	; Coloca Sprite da nave cor 11
	 	;=============================
	  	ld b,4
	  	ld c,11
		ld a,1
	  	call PutSprite
	pop bc
	pop af
ret
;=============================================================================

; =============================================================================
; DesenharCidade
; =============================================================================
; Parametros
; d => Coordenada Y da cidade
; e => Coordenada X da cidade
; =============================================================================
; Altera => Nada
; =============================================================================
DesenharCidade:
	push af
	push bc
	  	;=============================
	  	; Coloca Sprite cor 6
	  	;=============================
	  	ld b,12
	  	ld c,6
	  	call PutSprite
	pop bc
	pop af
ret
;=============================================================================

; =============================================================================
; RemoverCidade
; =============================================================================
; Parametros
; A => Numero da cidade a ser destruida (1 a 4)
; =============================================================================
; Altera
; Nada
; =============================================================================
RemoverCidade:
	cp 1
	jr z,Remove1
	cp 2
	jr z,Remove2
	cp 3
	jr z,Remove3
	cp 4
	jr z,Remove4
ret

Remove1:
	push af
		ld a,2
		call RemoveSprite
		ld a,(NumCidades)
		dec a
		ld (NumCidades),a
	pop af
ret

Remove2:
	push af
		ld a,3
		call RemoveSprite
		ld a,(NumCidades)
		dec a
		ld (NumCidades),a
	pop af
ret

Remove3:
	push af
		ld a,4
		call RemoveSprite
		ld a,(NumCidades)
		dec a
		ld (NumCidades),a
	pop af
ret

Remove4:
	push af
		ld a,5
		call RemoveSprite
		ld a,(NumCidades)
		dec a
		ld (NumCidades),a
	pop af
ret
;=============================================================================

; =============================================================================
; AumentaInimigos
; =============================================================================
AumentaInimigos:
	push af 
		ld a,(NumAliens)            ; pegamos o numero de aliens
		inc a                       ; adicinamos mais um
		ld (NumAliens),a            ; atualizamos
	pop af
ret 
; ============================================================================

; =============================================================================
; AumentaInimigosNaColuna
; =============================================================================
; Parametros
; A => Coluna onde entra o Alien (0 a 3) 
; =============================================================================
AumentaInimigosNaColuna:
	push af 
		cp 0
		jp z,SomaColuna0
		cp 1
		jp z,SomaColuna1
		cp 2
		jp z,SomaColuna2
		cp 3
		jp z,SomaColuna3
		jp FimSomaColuna
SomaColuna0:
		ld a,(NumContColuna1)       ; pegamos o numero de inimigos na coluna
		inc a                       ; adicionamos mais um
		ld (NumContColuna1),a       ; atualizamos
		jp FimSomaColuna
SomaColuna1:
		ld a,(NumContColuna2)       ; pegamos o numero de inimigos na coluna
		inc a                       ; adicionamos mais um
		ld (NumContColuna2),a       ; atualizamos
		jp FimSomaColuna
SomaColuna2:
		ld a,(NumContColuna3)       ; pegamos o numero de inimigos na coluna
		inc a                       ; adicionamos mais um
		ld (NumContColuna3),a       ; atualizamos
		jp FimSomaColuna
SomaColuna3:
		ld a,(NumContColuna4)       ; pegamos o numero de inimigos na coluna
		inc a                       ; adicionamos mais um
		ld (NumContColuna4),a       ; atualizamos
		jp FimSomaColuna
FimSomaColuna:
	pop af
ret 
; ============================================================================

; =============================================================================
; AdicionarAlien
; =============================================================================
; Parametros
; A => Coluna onde entra o Alien (entre 0 e 3)
; =============================================================================
; Altera
; Adiciona um alien na pilha de aliens
; =============================================================================
AdicionarAlien:
	push af
		call AumentaInimigos
		call AumentaInimigosNaColuna				
		cp 0
		jp z,Coluna0
		cp 1
		jp z,Coluna1
		cp 2
		jp z,Coluna2
		cp 3
		jp z,Coluna3
		jp FimAdicionarAlien
Coluna0:
		;===================================
		; Desenhar Alien na coluna 0
		;===================================
		ld a,(NumContColuna1)       ; pegamos o numero de inimigos na coluna
		sla a
		sla a
		sla a
		sla a						; multiplicamos por 16 (4x shift left)
		ld d,a                      ; posicao y = num na coluna x comp do sprite
		ld e,10                     ; posicao x = fixa
		ld a,(NumAliens)            ; a posicao na tabela de atributos
		add a,9                     ; eh igual a seu numero +9
		call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
		jp FimAdicionarAlien
Coluna1:
		;===================================
		; Desenhar Alien na coluna 1
		;===================================
		ld a,(NumContColuna2)       ; pegamos o numero de inimigos na coluna
		sla a
		sla a
		sla a
		sla a						; multiplicamos por 16 (4x shift left)
		ld d,a                      ; posicao y = num na coluna x comp do sprite
		ld e,40                     ; posicao x
		ld a,(NumAliens)            ; a posicao na tabela de atributos
		add a,9                     ; eh igual a seu numero +9
		call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
		jp FimAdicionarAlien
Coluna2:
		;===================================
		; Desenhar Alien na coluna 2
		;===================================
		ld a,(NumContColuna3)
		sla a
		sla a
		sla a
		sla a						; multiplicamos por 16 (4x shift left)
		ld d,a                      ; posicao y
		ld e,184                    ; posicao x
		ld a,(NumAliens)            ; a posicao na tabela de atributos
		add a,9                     ; eh igual a seu numero+9
		call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
		jp FimAdicionarAlien
Coluna3:
		;===================================
		; Desenhar Alien coluna 3
		;===================================
		ld a,(NumContColuna4)
		sla a
		sla a
		sla a
		sla a						; multiplicamos por 16 (4x shift left)
		ld d,a                      ; posicao y
		ld e,240                    ; posicao x
		ld a,(NumAliens)            ; a posicao na tabela de atributos
		add a,9                     ; e igual a seu numero +9
		call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
		jp FimAdicionarAlien
FimAdicionarAlien:
	pop af
ret
; =============================================================================

; =============================================================================
; RemoverAlien
; =============================================================================
; Parametros
; A => numero do alien a ser removido (10 a 25)
; B => coluna onde o alien se encontra (0 a 3)
; =============================================================================
; Altera
; Remove um alien da pilha de aliens
; decrementa o contador de alien e o contador de aliens na coluna 
; =============================================================================
RemoverAlien:
	push af
	push bc 
		call RemoveSprite				; Remove o alien
		ld a,(NumAliens) 				; pega contador de aliens
		dec a 							; decrementa o contador de aliens
		ld (NumAliens),a 				; atualiza contador de aliens
		ld a,b							; verifica a coluna do alien 
		cp 0
		jp z,DecrementaColuna1			; decrementa coluna 1
		cp 0
		jp z,DecrementaColuna2			; decrementa coluna 2
		cp 0
		jp z,DecrementaColuna3			; decrementa coluna 3
		cp 0
		jp z,DecrementaColuna4			; decrementa coluna 4
DecrementaColuna1:
		ld a,(NumContColuna1)
		dec a 
		ld (NumContColuna1),a 
		jp FimRemoverAlien
DecrementaColuna2:
		ld a,(NumContColuna2)
		dec a 
		ld (NumContColuna2),a 
		jp FimRemoverAlien
DecrementaColuna3:
		ld a,(NumContColuna3)
		dec a 
		ld (NumContColuna3),a 
		jp FimRemoverAlien
DecrementaColuna4:
		ld a,(NumContColuna4)
		dec a 
		ld (NumContColuna4),a 
		jp FimRemoverAlien
FimRemoverAlien:
	pop bc 
	pop af
ret
; =============================================================================

; =============================================================================
; Desenhar Alienigena
; =============================================================================
; Parametros
; d => Coordenada Y
; e => Coordenada X
; =============================================================================
; Altera => Nada
; =============================================================================
DesenharAlienigena:
	push af
		push bc
		  ;=============================
		  ; Coloca Sprite cor 13
		  ;=============================
		  ld b,16
		  ld c,13
		  call PutSprite
		pop bc
	pop af
ret
;==============================================================================

; =============================================================================
; Esperar a tecla ENTER
; =============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera => A
; =============================================================================
WaitEnter:
		call CHGET
		cp 13
		jr z,EndWaitEnter
		jr WaitEnter
EndWaitEnter:
ret
; =============================================================================

; =============================================================================
; RemoverTorpedo
; remover um torpedo da fila de torpedos
; =============================================================================
; Altera
; NumTorpedos
; flgTorpedos
; =============================================================================
RemoveTorp28:
	push af
		ld a,28
		call RemoveSprite
		ld a,(flgTorpedos)
		res 0,a
		ld (flgTorpedos),a
		ld a,(NumTorpedos)
		dec a
		ld (NumTorpedos),a
	pop af
ret

RemoveTorp29:
	push af
		ld a,29
		call RemoveSprite
		ld a,(flgTorpedos)
		res 1,a
		ld (flgTorpedos),a
		ld a,(NumTorpedos)
		dec a
		ld (NumTorpedos),a
	pop af
ret

RemoveTorp30:
	push af
		ld a,30
		call RemoveSprite
		ld a,(flgTorpedos)
		res 2,a
		ld (flgTorpedos),a
		ld a,(NumTorpedos)
		dec a
		ld (NumTorpedos),a
	pop af
ret

RemoveTorp31:
	push af
		ld a,31
		call RemoveSprite
		ld a,(flgTorpedos)
		res 3,a
		ld (flgTorpedos),a
		ld a,(NumTorpedos)
		dec a
		ld (NumTorpedos),a
	pop af
ret
; =============================================================================

; =============================================================================
; Desenhar Torpedo
; =============================================================================
; Parametros
; d => Coordenada Y
; e => Coordenada X
; =============================================================================
; Altera
;	Adiciona o sprite do torpedo na fila de atributos
; =============================================================================
DesenharTorpedo:
	push bc
	  ;==================================
	  ; Coloca Sprite pattern 20 na cor 8
	  ;==================================
	  ld b,20
	  ld c,8
	  call PutSprite
	pop bc
ret
;==============================================================================

; =============================================================================
; ChecarAlienXY
; =============================================================================
; Parametros
; h => Coordenada Y
; l => Coordenada X
; =============================================================================
; Altera
; A => Se existe um alien nessa posicao, retorna 1, se nao existe retorna 0
; =============================================================================
ChecarAlienXY:
	; ====================================================
	; Vamos fazer um loop de tras para fente da posicao
	; 9+NumAliens até a posicao 10 (inicio dos aliens na
	; tabela de atributos de sprite)
	; ====================================================
	push bc
		ld a,(NumAliens)      	; pega o numero de Aliens
		cp 0 					; se nao tem aliens
		jp z,ChecouTodos		; nao tem colisao
		add a,9                	; somo com 9 pois os aliens estao na posicao 10
		ld b,a                	; carrega o ultimo alien
loopAlienPosicao:
		call ChecarPosicaoAlien	; Checa todos os pontos da hitbox do alien
		ld a,b					; Pega o alien sendo testado
		cp 10	                ; Os aliens terminam na posicao 10
  		jp z,ChecouTodos       	; checamos todos os aliens
  		dec a                 	; proximo alien
		ld b,a					; atualiza o alien que estamos testando
		jr loopAlienPosicao
ChecouTodos:
	pop bc
	ld a,(flgHouveColisao)
ret

ChecarPosicaoAlien:
	xor a						; zera acumulador
	ld (flgColisaoAlien),a		; zera o flag de colisao com alien
	ld (flgHouveColisao),a  	; zera flag de colisao geral
	ld a,b 						; pega o alien que vamos testar
	push bc						; bkp
	push de						; bkp
		call ReadSprite   		; le o sprite do alien (D=Y, E=X)
		call AlienPosYOK  		; seta o flag de colisao y (bit 0 flgColisaoAlien)
		call AlienPosXOK 		; seta o flag de colisao X (bit 1 flgColisaoAlien)
	pop de						; volta bkp
	pop bc						; volta bkp
	ld a,(flgColisaoAlien)		; pega o resultado das colisoes
	cp 3						; se bits 0 e 1 estao ligados houve colisao
	call z,Colidiu				; COLISAO
ret

Colidiu:
	push af
		ld a,b					; pega o numero do alien que estamos testando
		call RemoverAlien		; remove o alien
		ld a,1 					; carrega acumulador
		ld (flgHouveColisao),a 	; seta o indicador de colisao
	pop af
ret

AlienPosYOK:
	push af 					; BKP
	push bc						; BKP
		ld a,h					; pega o parametro y
		add a,8					; soma 8 para o limite da hitbox
		ld b,a					; guarda o limite da hitbox
		ld a,h					; pega o parametro y
		sub 8					; diminui 8 para o inicio da hitbox
loopHitboxY:
		cp d					; Compara com a pos y do alien
		call z,SetaFlagColisaoY	; se sim esse alien colidiu
		inc a					; pegamos proxima coordenada do hitbox
		cp b					; comparamos com o limite da hitbox
		jp z,FimHitboxX			; verificamos todos os pontos da hitbox
	jp loopHitboxY				; senao pegamos o proximo
FimHitboxY:
	pop bc						; volta bkp
	pop af						; volta bkp
ret

AlienPosXOK:
	push af
	push bc
		ld a,l					; pega o parametro x
		add a,8					; soma 8 para o limite da hitbox
		ld b,a					; guarda o limite da hitbox
		ld a,l					; pega o parametro x
		sub 8					; diminui 8 para o inicio da hitbox
loopHitboxX:
		cp e					; compara com a posicao x do alien
		call z,SetaFlagColisaoX	; se sim esse alien colidou
		inc a					; incrementa a posicao atual
		cp b					; compara com o limite superior
		jp z,FimHitboxX			; testamos toda a hitbox
		jp loopHitboxX			; testamos a proxima posicao
FimHitboxX:
	pop bc
	pop af
ret

SetaFlagColisaoY:
	push af
		ld a,(flgColisaoAlien)
		set 0,a
    ld (flgColisaoAlien),a
	pop af
ret

SetaFlagColisaoX:
	push af
		ld a,(flgColisaoAlien)
	 	set 1,a
    ld (flgColisaoAlien),a
	pop af
ret
; =============================================================================

; =============================================================================
; Print String (Tela Grafica)
; =============================================================================
; Parametros
; HL => Endereço da string
; D  => posicao x
; E  => posicao y
; =============================================================================
; Altera
; Escreve a mensagem em HL na tela nas coordenadas DE
; =============================================================================
PrintString:
	push af
		call PrintStringGRP
	pop af
ret
; =============================================================================

; =============================================================================
; Converter um numero de 0 a 15 em seu digito hexadecimal
; =============================================================================
; A => Numero a ser convertido
; =============================================================================
; ALTERA => A
; =============================================================================
ConvNumChar:
	cp 0
	jp z,Zero
	cp 1
	jp z,Um
	cp 2
	jp z,Dois
	cp 3
	jp z,Tres
	cp 4
	jp z,Quatro
	cp 5
	jp z,Cinco
	cp 6
	jp z,Seis
	cp 7
	jp z,Sete
	cp 8
	jp z,Oito
	cp 9
	jp z,Nove
	cp 10
	jp z,DezA
	cp 11
	jp z,OnzeB
	cp 12
	jp z,Dozec
	cp 13
	jp z,TrezeD
	cp 14
	jp z,QuatorzeE
	cp 15
	jp z,QuinzeF
	ret
Zero:
	ld a,'0'
ret

Um:
	ld a,'1'
ret

Dois:
	ld a,'2'
ret

Tres:
	ld a,'3'
ret

Quatro:
	ld a,'4'
ret

Cinco:
	ld a,'5'
ret

Seis:
	ld a,'6'
ret

Sete:
	ld a,'7'
ret

Oito:
	ld a,'8'
ret

Nove:
	ld a,'9'
ret

DezA:
	ld a,'A'
ret

OnzeB:
	ld a,'B'
ret

Dozec:
	ld a,'C'
ret

TrezeD:
	ld a,'D'
ret

QuatorzeE:
	ld a,'E'
ret

QuinzeF:
	ld a,'F'
ret
; =============================================================================