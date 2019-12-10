; =============================================================================
; Adicionar novos aliens no jogo
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
GerarAliens:
  ld a,(NumSemana)        ; pega a semana atual
  inc a                   ; aumenta em 1
  ld (NumSemana),a        ; atualiza a semana atual
  cp 5                    ; se for a 5 semana ja sorteamos o maximo
  jp z,NaoAdicionaAliens  ; nao podemos adicionar mais aliens
  ld b,4                  ; prepara multipilicador
  call Multiply           ; Multiplica a semana por 4
  ld (NumSorteios),a      ; prepara o contador do numero de sorteios
NaoAdicionaAliens:
SorteiaAliens:            ; sorteia um numero de aliens igual a semana*4
  ld a,3                  ; aliens podem estar em 4 posicoes X (0-3)
  call RandomNumber       ; A tem um aleatorio entre 0 e 3
  cp 0
  jp z,Posicao10          ; se sorteou 0 bota alien na posicao 10
  cp 1
  jp z,Posicao40          ; se sorteou 1 bota alien na posicao 40
  cp 2
  jp z,Posicao184         ; se sorteou 2 bota alien na posicao 184
  cp 3
  jp z,Posicao240         ; se sorteou 3 bota alien na posicao 240
FimDesenhoAlien:
  ld a,(NumSorteios)      ; le quantos sorteios devem ser efetuados
  dec a                   ; controla o numero de sorteios
  ld (NumSorteios),a      ; atualiza o numero de sorteios
  cp 0                    ; sorteou todos
  jr z,FimSorteiaAliens   ; volta para loop do jogo
  jr SorteiaAliens        ; volta para o sorteio de aliens
FimSorteiaAliens:
ret

Posicao10:
  ;===================================
  ; Atualiza num de inimigos na coluna
  ;===================================
  ld a,(NumContColuna1)       ; pegamos o numero de inimigos na coluna
  inc a                       ; adicionamos mais um
  ld (NumContColuna1),a       ; atualizamos
  ;===================================
  ; Atualiza num de inimigos
  ;===================================
  ld a,(NumSprites)           ; pegamos o numero de sprites na tela
  inc a                       ; adicinamos mais um
  ld (NumSprites),a           ; atualizamos
  ;============================
  ; Desenhar Alien na coluna 1
  ; O Alien usa 2 sprites
  ;============================
  ld a,(NumContColuna1)       ; pegamos o numero de inimigos na coluna
  ld b,16                     ; preparamos o multiplicando (comp do sprite)
  call Multiply               ; Multiplicams por 16
  ld d,a                      ; posicao y = num na coluna x comp do sprite
  ld e,10                     ; posicao x = fixa
  ld a,(NumSprites)           ; posicao na tabela de atributos
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
jp FimDesenhoAlien            ; Final de adicao de alien

Posicao40:
  ;===================================
  ; Atualiza num de inimigos na coluna
  ;===================================
  ld a,(NumContColuna2)       ; pegamos o numero de inimigos na coluna
  inc a                       ; adicionamos mais um
  ld (NumContColuna2),a       ; atualizamos
  ;===================================
  ; Atualiza num de inimigos
  ;===================================
  ld a,(NumSprites)           ; pegamos o numero de sprites na tela
  inc a                       ; adicinamos mais um
  ld (NumSprites),a           ; atualizamos
  ;===================================
  ; Desenhar Alien na coluna 2
  ; O Alien usa 2 sprites
  ;===================================
  ld a,(NumContColuna2)       ; pegamos o numero de inimigos na coluna
  ld b,16                     ; preparamos o multiplicando (comp do sprite)
  call Multiply               ; Multiplicar o contador de inimigos por 16
  add a,16                    ; As cidades mais baixas os aliens saem na frente
  ld d,a                      ; posicao y = num na coluna x comp do sprite
  ld e,40                     ; posicao x
  ld a,(NumSprites)           ; posicao na tabela de atributos
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
jp FimDesenhoAlien            ; Final de adicao de alien

Posicao184:
  ;===================================
  ; Atualiza num de inimigos na coluna
  ;===================================
  ld a,(NumContColuna3)
  inc a
  ld (NumContColuna3),a
  ;===================================
  ; Atualiza num de inimigos
  ;===================================
  ld a,(NumSprites)
  inc a                       ; adicinamos mais um
  ld (NumSprites),a
  ;==========================
  ; Desenhar Alien coluna 3
  ; O Alien usa 2 sprites
  ;==========================
  ld a,(NumContColuna3)
  ld b,16
  call Multiply               ; Multiplicar o contador de inimigos por 16
  add a,16
  ld d,a                      ; posicao y
  ld e,184                    ; posicao x
  ld a,(NumSprites)           ; posicao na tabela de atributos
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
jp FimDesenhoAlien            ; Final de adicao de alien

Posicao240:
  ;===================================
  ; Atualiza num de inimigos na coluna
  ;===================================
  ld a,(NumContColuna4)       ; pega o numero de inimigos na coluna 4
  inc a                       ; adicionamos mais um
  ld (NumContColuna4),a       ; atualizamos o valor
  ;===================================
  ; Atualiza num de sprites
  ;===================================
  ld a,(NumSprites)           ; pegamos o numero de sprites na tela
  inc a                       ; adicinamos mais um
  ld (NumSprites),a           ; atualizamos
  ;===================================
  ; Desenhar Alien coluna 4
  ; O Alien usa 2 sprites
  ;===================================
  ld a,(NumContColuna4)
  ld b,16
  call Multiply               ; Multiplicar o contador de inimigos por 16
  ld d,a                      ; posicao y
  ld e,240                    ; posicao x
  ld a,(NumSprites)           ; posicao na tabela de atributos
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
jp FimDesenhoAlien            ; Final de adicao de alien
