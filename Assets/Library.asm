; =============================================================================
; Library.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Funcoes ASM de uso geral para o MSX
; =============================================================================

; =============================================================================
; LimparTela
; =============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera
; Nada
; =============================================================================
LimparTela:
	push af
	push bc
	push de
		xor a
		call CLS
	pop de
	pop bc
	pop af
ret
; =============================================================================

; =============================================================================
; Limpar as variaveis
; =============================================================================
; Nao tem parametros
; =============================================================================
; Altera => Todas as variaveis para 0
; =============================================================================
LimpaMem:
	push af
		xor a
  	ld (NumCentenas),a
		ld (NumDezenas),a
		ld (NumUnidades),a
		ld (NumPosXNave),a
		ld (NumPosYNave),a
		ld (NumSemana),a
		ld (NumVelAlien),a
		ld (NumTorpedos),a
		ld (NumAliens),a
		ld (NumVelNave),a
		ld (NumContColuna1),a
		ld (NumContColuna2),a
		ld (NumContColuna3),a
		ld (NumContColuna4),a
		ld (NumSorteios),a
		ld (NumCidades),a
		ld (vdpCycle1),a
		ld (vdpCycle5),a
		ld (flgColisaoAlien),a
		ld (flgTorpedos),a
		ld (flgHouveColisao),a
		ld (flgNovoNivel),a
	pop af
ret
; =============================================================================

; =============================================================================
; Causar uma pausa em segundos
; =============================================================================
; BC => Tempo de parada
; =============================================================================
; Altera => A,C
; =============================================================================
Delay:
  nop
  dec BC
  ld A,B
  or C
  ret Z
jr Delay
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
			ld b,a								; Numero Maximo Sorteio
			ld a,128							; Dividir 128 pelo tamanho numero maximo
			ld d,0								; contador de subtracao sucessivas
DvPTamanho:
			sub b    							; comeca a divisao pelo tamanho maximo
			inc d									; aumenta o acumulador
			jr nc, DvPTamanho		  ; repete enquanto nao tem "vai um"
			dec d									; elimina o resto
			ld a,d								; nesse momento D tem o divisior ideal
			ld b,a								; carrega o divisor ideal
			ld a,r								; Gera um aleatorio entre 0 e 127
			ld d,0								; contador de subtracao sucessivas
DvPIdeal:
			sub b 								; comeca a divisao pelo divisor ideal
			inc d									; aumenta o acumulador
			jr nc, DvPIdeal 			; repete enquanto nao tem "vai um"
			dec d									; elimina o resto
			ld a,d								; Retorna o numero aleatorio
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
		  ; Coloca Sprite cor 1
		  ;=============================
		  ld b,8
		  ld c,1
		  call PutSprite
		  ;=============================
		  ; Coloca Sprite cor 6
		  ;=============================
		  ld b,12
		  ld c,6
			inc a
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
		ld a,3
		call RemoveSprite
		ld a,(NumCidades)
		dec a
		ld (NumCidades),a
	pop af
ret

Remove2:
	push af
		ld a,4
		call RemoveSprite
		ld a,5
		call RemoveSprite
		ld a,(NumCidades)
		dec a
		ld (NumCidades),a
	pop af
ret

Remove3:
	push af
		ld a,6
		call RemoveSprite
		ld a,7
		call RemoveSprite
		ld a,(NumCidades)
		dec a
		ld (NumCidades),a
	pop af
ret

Remove4:
	push af
		ld a,8
		call RemoveSprite
		ld a,9
		call RemoveSprite
		ld a,(NumCidades)
		dec a
		ld (NumCidades),a
	pop af
ret
;=============================================================================

; =============================================================================
; AdicionarAlien
; =============================================================================
; Parametros
; A => Coluna onde entra o ALien (entre 0 e 3)
; =============================================================================
; Altera
; Adiciona um alien na pilha de aliens
; =============================================================================
AdicionarAlien:
	cp 0
	jp z,Coluna0
	cp 1
	jp z,Coluna1
	cp 2
	jp z,Coluna2
	cp 3
	jp z,Coluna3
ret

Coluna0:
	;===================================
	; Atualiza num de inimigos
	;===================================
	ld a,(NumAliens)            ; pegamos o numero de aliens
	inc a                       ; adicinamos mais um
	ld (NumAliens),a            ; atualizamos
  ;===================================
  ; Atualiza num de inimigos na coluna
  ;===================================
  ld a,(NumContColuna1)       ; pegamos o numero de inimigos na coluna
  inc a                       ; adicionamos mais um
  ld (NumContColuna1),a       ; atualizamos
  ;===================================
  ; Desenhar Alien na coluna 0
  ;===================================
  ld a,(NumContColuna1)       ; pegamos o numero de inimigos na coluna
	sla a
	sla a
	sla a
	sla a												; multiplicamos por 16 (4x shift left)
  ld d,a                      ; posicao y = num na coluna x comp do sprite
  ld e,10                     ; posicao x = fixa
  ld a,(NumAliens)            ; a posicao na tabela de atributos
  add a,9                     ; e igual a seu numero +9
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
ret

Coluna1:
	;===================================
	; Atualiza num de aliens
	;===================================
	ld a,(NumAliens)           	; pegamos o numero de sprites na tela
	inc a                       ; adicinamos mais um
	ld (NumAliens),a           	; atualizamos
	;===================================
  ; Atualiza num de inimigos na coluna
  ;===================================
  ld a,(NumContColuna2)       ; pegamos o numero de inimigos na coluna
  inc a                       ; adicionamos mais um
  ld (NumContColuna2),a       ; atualizamos
	;===================================
	; Desenhar Alien na coluna 1
	;===================================
	ld a,(NumContColuna2)       ; pegamos o numero de inimigos na coluna
	sla a
	sla a
	sla a
	sla a												; multiplicamos por 16 (4x shift left)
	add a,16                    ; As cidades mais baixas os aliens saem na frente
	ld d,a                      ; posicao y = num na coluna x comp do sprite
	ld e,40                     ; posicao x
	ld a,(NumAliens)            ; a posicao na tabela de atributos
	add a,9                     ; e igual a seu numero +9
	call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
ret

Coluna2:
	;===================================
	; Atualiza num de aliens
	;===================================
	ld a,(NumAliens)
	inc a                       ; adicinamos mais um
	ld (NumAliens),a
	;===================================
	; Atualiza num de inimigos na coluna
  ;===================================
  ld a,(NumContColuna3)
  inc a
  ld (NumContColuna3),a
  ;===================================
  ; Desenhar Alien na coluna 2
  ;===================================
  ld a,(NumContColuna3)
	sla a
	sla a
	sla a
	sla a												; multiplicamos por 16 (4x shift left)
  add a,16
  ld d,a                      ; posicao y
  ld e,184                    ; posicao x
  ld a,(NumAliens)            ; a posicao na tabela de atributos
  add a,9                     ; e igual a seu numero+9
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
ret

Coluna3:
	;===================================
	; Atualiza num de aliens
	;===================================
	ld a,(NumAliens)           ; pegamos o numero de sprites na tela
	inc a                      ; adicinamos mais um
	ld (NumAliens),a           ; atualizamos
	;===================================
	; Atualiza num de inimigos na coluna
	;===================================
	ld a,(NumContColuna4)       ; pega o numero de inimigos na coluna 4
	inc a                       ; adicionamos mais um
	ld (NumContColuna4),a       ; atualizamos o valor
	;===================================
	; Desenhar Alien coluna 3
	;===================================
	ld a,(NumContColuna4)
	sla a
	sla a
	sla a
	sla a												; multiplicamos por 16 (4x shift left)
	ld d,a                      ; posicao y
	ld e,240                    ; posicao x
	ld a,(NumAliens)            ; a posicao na tabela de atributos
	add a,9                     ; e igual a seu numero +9
	call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
ret
; =============================================================================

; =============================================================================
; RemoverAlien
; =============================================================================
; Parametros
; A => numero do alien a ser removido (10 a 25)
; =============================================================================
; Altera
; Remove um alien da pilha de aliens
; =============================================================================
RemoverAlien:
	push af
		call RemoveSprite				; Remove o alien
		ld a,(NumAliens) 				; pega contador de aliens
		dec a 									; decrementa o contador de aliens
		ld (NumAliens),a 				; atualiza contador de aliens
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
; B
; =============================================================================
ChecarAlienXY:
	; ====================================================
	; Vamos fazer um loop de tras para fente da posicao
	; 9+NumAliens até a posicao 10 (inicio dos aliens na
	; tabela de atributos de sprite)
	; ====================================================
	push bc
		ld a,(NumAliens)      	; pega o numero de Aliens
		cp 0 										; se nao tem aliens
		jp z,ChecouTodos				; nao tem colisao
		add a,9                	; somo com 9 pois os aliens estao na posicao 10
		ld b,a                	; carrega o ultimo alien
loopAlienPosicao:
		call ChecarPosicaoALien	; Checa todos os pontos da hitbox do alien
		ld a,b									; Pega o alien sendo testado
		cp 10	                 	; Os aliens terminam na posicao 10
  	jp z,ChecouTodos       	; checamos todos os aliens
  	dec a                 	; proximo alien
		ld b,a									; atualiza o alien que estamos testando
		jr loopAlienPosicao
ChecouTodos:
	pop bc
	ld a,(flgHouveColisao)
ret

ChecarPosicaoALien:
	xor a										; zera acumulador
	ld (flgColisaoAlien),a	; zera o flag de colisao com alien
	ld (flgHouveColisao),a  ; zera flag de colisao geral
	ld a,b 									; pega o alien que vamos testar
	push bc									; bkp
	push de									; bkp
		call ReadSprite   		; le o sprite do alien (D=Y, E=X)
		call AlienPosYOK  		; seta o flag de colisao y (bit 0 flgColisaoAlien)
		call AlienPosXOK 			; seta o flag de colisao X (bit 1 flgColisaoAlien)
	pop de									; volta bkp
	pop bc									; volta bkp
	ld a,(flgColisaoAlien)	; pega o resultado das colisoes
	cp 3										; se bits 0 e 1 estao ligados houve colisao
	call z,Colidiu					;	COLISAO
ret

Colidiu:
	push af
		ld a,b								 	; pega o numero do alien que estamos testando
		call RemoverAlien				; remove o alien
		ld a,1 									; carrega acumulador
		ld (flgHouveColisao),a 	; seta o indicador de colisao
	pop af
ret

AlienPosYOK:
	push af 										; BKP
	push bc											; BKP
		ld a,h										; pega o parametro y
		add a,8										; soma 8 para o limite da hitbox
		ld b,a										; guarda o limite da hitbox
		ld a,h										; pega o parametro y
		sub 8										  ; diminui 8 para o inicio da hitbox
loopHitboxY:
		cp d 											; Compara com a pos y do alien
		call z,SetaFlagColisaoY		; se sim esse alien colidiu
		inc a											; pegamos proxima coordenada do hitbox
		cp b											; comparamos com o limite da hitbox
		jp z,FimHitboxX						; verificamos todos os pontos da hitbox
	jp loopHitboxY							; senao pegamos o proximo
FimHitboxY:
	pop bc											; volta bkp
	pop af											; volta bkp
ret

AlienPosXOK:
	push af
	push bc
		ld a,l										; pega o parametro x
		add a,8										; soma 8 para o limite da hitbox
		ld b,a										; guarda o limite da hitbox
		ld a,l										; pega o parametro x
		sub 8											; diminui 8 para o inicio da hitbox
loopHitboxX:
		cp e											; compara com a posicao x do alien
		call z,SetaFlagColisaoX		; se sim esse alien colidou
		inc a											; incrementa a posicao atual
		cp b											; compara com o limite superior
		jp z,FimHitboxX						; testamos toda a hitbox
		jp loopHitboxX						; testamos a proxima posicao
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

; ============================================================================
; PassarSemana
; ============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera
; Nada
; =============================================================================
PassarSemana:
	push af
  	ld a,(NumSemana)				; pega o numero da semana
  	inc a										; aumenta a semana
		cp 5                    ; se for a 5 semana ja chegamos no maximo
		jr z,SemanaMaxima				; não podemos passar da quarta semana
  	ld (NumSemana),a				; carregamos a nova semana
SemanaMaxima:
		ld a,10									; prepara o loop de limpeza de aliens
LoopLimpaAliens:
		call RemoverAlien				; remove o alien atual
		cp 25 									; os aliens vao ate a posicao 25
		jp z,LimpeiOsAliens			; se eh zero limpamos todos
		inc a
		jp LoopLimpaAliens
LimpeiOsAliens:
		xor a
		ld (NumAliens),a
	pop af
ret
; ============================================================================

; ============================================================================
; Imprime uma string terminada em ENTER(13) na Tela Grafica
; ============================================================================
; Parametros
; HL => endereco da string a ser escrita
; =============================================================================
; Altera
; Nada
; =============================================================================
PrintStringGRP:
	push af
		ld a,(hl)
		cp 13
		jp z,EndStringGRP
		call GRPPRT
		inc hl
		jp PrintStringGRP
EndStringGRP:
	pop af
ret
; ============================================================================
