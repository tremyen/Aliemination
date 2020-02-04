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
; Inicializar as variaveis
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
		ld (NumVidaJogador),a
		ld (NumVelAlien),a
		ld (NumTorpedos),a
		ld (NumAliensMortos),a
		ld (NumAliens),a
		ld (NumVelNave),a
		ld (NumContColuna1),a
		ld (NumContColuna2),a
		ld (NumContColuna3),a
		ld (NumContColuna4),a
		ld (NumSorteios),a
		ld (vdpCycle1),a
		ld (vdpCycle5),a
		ld (flgColisao),a
		ld (NumCidades),a
		ld (NumVelTorpedo),a
		ld (flgTorpedos),a
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
  ld b,16                     ; preparamos o multiplicando (comp do sprite)
  call Multiply               ; Multiplicams por 16
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
	ld b,16                     ; preparamos o multiplicando (comp do sprite)
	call Multiply               ; Multiplicar o contador de inimigos por 16
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
  ld b,16
  call Multiply               ; Multiplicar o contador de inimigos por 16
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
	ld b,16
	call Multiply               ; Multiplicar o contador de inimigos por 16
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
		ld a,(NumAliensMortos)	; pega contador de aliens mortos
		inc a 									; Incrementa o contador de aliens mortos
		ld (NumAliensMortos),a	; atualiza contador de aliens mortos
		ld a,(NumAliens) 				; pega contador de aliens
		dec a 									; decrementa o contador de aliens
		ld (NumAliens),a 				; atualiza contador de aliens
	pop af
ret

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
; Multiply
; =============================================================================
; Parametros
; A => Multiplicando
; B => Multiplicador
; =============================================================================
; Altera => A (resultado)
; =============================================================================
Multiply:
	push bc
	push de
		ld c,a 							; carrega multiplicando
		ld d,a							; guarda buffer de soma
AddAgain:
		ld a,d							; pega o buffer de soma a cada passada
		add a,c							; adiciona multiplicando
		dec b								; controla multiplicador
		ld d,a							; salva soma ate o momento
		ld a,b 							; prepara comparacao
		cp 1								; se b = 1 multiplicamos tudo
		jr z,EndMultiply		; termina a multiplicacao
		jr AddAgain					; mais uma soma
EndMultiply:
		ld a,d							; pega o buffer de soma
	pop de
	pop bc
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
	ld a,28
	call RemoveSprite
	ld a,(flgTorpedos)
	res 0,a
	ld (flgTorpedos),a
	ld a,(NumTorpedos)
	dec a
	ld (NumTorpedos),a
ret

RemoveTorp29:
	ld a,29
	call RemoveSprite
	ld a,(flgTorpedos)
	res 1,a
	ld (flgTorpedos),a
	ld a,(NumTorpedos)
	dec a
	ld (NumTorpedos),a
ret

RemoveTorp30:
	ld a,30
	call RemoveSprite
	ld a,(flgTorpedos)
	res 2,a
	ld (flgTorpedos),a
	ld a,(NumTorpedos)
	dec a
	ld (NumTorpedos),a
ret

RemoveTorp31:
	ld a,31
	call RemoveSprite
	ld a,(flgTorpedos)
	res 3,a
	ld (flgTorpedos),a
	ld a,(NumTorpedos)
	dec a
	ld (NumTorpedos),a
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
; EliminarAliens
; =============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera
; Sprites dos aliens
; =============================================================================
EliminarAliens:
	push af
	push bc
		xor a										; zera acumulador
  	ld a,(NumAliens)      	; pega o numero de Aliens
		cp 0 										; se nao tem aliens
		jp z,ChecouEliminacao  	; nao tem colisao
  	add a,9                	; os aliens comecam no sprite 10
  	ld b,a                	; carrega controle do loop
  	ld a,10               	; os aliens comecam no sprite 10
LoopEliminarAliens:
	ld c,a 	; Quarda o numero do alien que estamos testando
	push bc
	push de
	  call ReadSprite       ; le o sprite do alien (D=Y, E=X)
		; todo checar contra todos os torpedos (sprites 28-31
		; se estiver no hitbox eliminar o torpedo e o alien
	pop de
	pop bc
	cp b                  	; verifica se foram todos os aliens
  jp z,ChecouEliminacao  	; checamos todos os aliens
  inc a                 	; proximo alien
	ld c,a 									; proximo alien que vamos testar
jr LoopEliminarAliens
ChecouEliminacao:
ret
; =============================================================================

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
	push bc
		ld a,(NumAliens)      	; pega o numero de Aliens
		cp 0 										; se nao tem aliens
		jp z,ChecouTodos				; nao tem colisao
		ld a,(NumAliens)        ; pego o numero de aliens
		add a,9                	; somo com 9 pois os aliens estao na posicao 10
		ld b,a                	; carrega controle do loop
		ld c,10               	; os aliens comecam no sprite 10
loopAlienPosicao:
		xor a										; zera acumulador
		ld (flgColisao),a				; zera o flag de colisao
		ld a,c 									; Quarda o numero do alien que estamos testando
		push bc									; bkp
		push de									; bkp
			call ReadSprite   	; le o sprite do alien (D=Y, E=X)
			call AlienPosYOK  	; seta o flag de colisao y
			call AlienPosXOK 		; seta o flag de colisao X
		pop de									; volta bkp
		pop bc									; volta bkp
		ld a,(flgColisao)				; pega o resultado das colisoes
		cp 1										; se esta no x-y mata o alien e retorna 1
		call z,Colidiu					;	COLISAO
		ld a,c									; pega o numero do alien atual
		cp b                  	; verifica se foram todos os aliens
  	jp z,ChecouTodos       	; checamos todos os aliens
  	inc a                 	; proximo alien
		ld c,a									; atualiza o alien que estamos testando para o prox.
jr loopAlienPosicao
ChecouTodos:
	pop bc
	ld a,(flgColisao)
ret

Colidiu:
	push af
		ld a,c								 	; pega o numero do alien que estamos testando
		call RemoverAlien				; remove o alien
	pop af
ret

AlienPosYOK:
	push af 										; BKP
	push bc											; BKP
		ld a,h										; pega o parametro y
		add a,6										; soma 6 para o limite da hitbox
		ld b,a										; guarda o limite da hitbox
		ld a,h										; pega o parametro y
		sub 5											; diminui 5 para o inicio da hitbox
loopHitboxY:
		cp d 											; Compara com a pos y do alien
		call z,SetaFlagColisao		; se sim esse alien colidiu
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
		add a,6										; soma 6 para o limite da hitbox
		ld b,a										; guarda o limite da hitbox
		ld a,l										; pega o parametro x
		sub 5											; diminui 5 para o inicio da hitbox
loopHitboxX:
		cp e											; compara com a posicao x do alien
		call z,SetaFlagColisao		; se sim esse alien colidou
		inc a
		cp b
		jp z,FimHitboxX
		jp loopHitboxX
FimHitboxX:
	pop bc
	pop af
ret

SetaFlagColisao:
	push af
		ld a,1
    ld (flgColisao),a
	pop af
ret
; =============================================================================

; =============================================================================
; CheckVdpColision
; =============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera
; A => Se houve uma colisao 1, senao 0
; =============================================================================
CheckVdpColision:
	call ReadVDPStatus
	bit 5,a
	jp z,SemColisao
	ld a,1
	ret
SemColisao:
	ld a,0
ret
; =============================================================================

; ============================================================================
; Recomecar o nivel em caso de colisao com a nave
; ============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera
; Nada
; =============================================================================
RecomecaNivel:
	push af
  	ld a,(NumVidaJogador)
  	dec a
  	ld (NumVidaJogador),a
	pop af
  jp gameLoop
ret
; ============================================================================

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
  	ld a,(NumSemana)
  	inc a
  	ld (NumSemana),a
	pop af
  jp gameLoop
ret
; ============================================================================
