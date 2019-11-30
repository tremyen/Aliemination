; =============================================================================
; Adicionar novos aliens no jogo
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
GerarAliens:
  ld a,(Semana)           ; pega a semana atual
  inc a                   ; aumenta em 1
  ld b,4
  call Multiply           ; Multiplica a semana por 4
  ld b,a                  ; prepara o contador do numero de sorteios
SorteiaAliens:            ; sorteia um numero de aliens igual a semana*4
  ld a,4                  ; aliens podem estar em 4 posicoes X
  call RandomNumber       ; A tem um aleatorio entre 0 e 3
  cp 1
  jp z,Posicao10          ; se sorteou 1 bota alien na posicao 10
  cp 2
  jp z,Posicao40          ; se sorteou 2 bota alien na posicao 40
  cp 3
  jp z,Posicao184         ; se sorteou 3 bota alien na posicao 184
  cp 4
  jp z,Posicao240         ; se sorteou 4 bota alien na posicao 240
FimDesenhoAlien:
  dec b                   ; controla o numero de sorteios
  ld a,b                  ; prepara para comparar
  cp 0                    ; sorteou todos
  jr z,FimSorteiaAliens   ; volta para loop do jogo
  jr SorteiaAliens        ; volta para o sorteio de aliens
FimSorteiaAliens:
ret

Posicao10:
  ;===================================
  ; Atualiza num de inimigos na coluna
  ;===================================
  ld a,(NumContColuna1)
  inc a
  ld (NumContColuna1),a
  ;===================================
  ; Atualiza num de inimigos
  ;===================================
  ld a,(NumInimigos)
  inc a
  ld (NumInimigos),a
  ;============================
  ; Desenhar Alien na coluna 1
  ; O Alien usa 2 sprites
  ;============================
  ld a,(NumContColuna1)
  ld b,16
  call Multiply               ; Multiplicar o cont inimigos da coluna por 16
  ld d,a                      ; posicao y
  ld e,10                     ; posicao x
  ld a,(NumInimigos)          ; posicao na tabela de atributos
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
jp FimDesenhoAlien            ; Final de adicao de alien

Posicao40:
  ;===================================
  ; Atualiza num de inimigos na coluna
  ;===================================
  ld a,(NumContColuna2)
  inc a
  ld (NumContColuna2),a
  ;===================================
  ; Atualiza num de inimigos
  ;===================================
  ld a,(NumInimigos)
  inc a
  ld (NumInimigos),a
  ;==========================
  ; Desenhar Alien
  ; O Alien usa 2 sprites
  ;==========================
  ld a,(NumContColuna2)
  ld b,16
  call Multiply               ; Multiplicar o contador de inimigos por 16
  ld d,a                      ; posicao y
  ld e,40                     ; posicao x
  ld a,(NumInimigos)          ; posicao na tabela de atributos
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
  ld a,(NumInimigos)
  inc a
  ld (NumInimigos),a
  ;==========================
  ; Desenhar Alien
  ; O Alien usa 2 sprites
  ;==========================
  ld a,(NumContColuna3)
  ld b,16
  call Multiply               ; Multiplicar o contador de inimigos por 16
  ld d,a                      ; posicao y
  ld e,184                    ; posicao x
  ld a,(NumInimigos)          ; posicao na tabela de atributos
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
jp FimDesenhoAlien            ; Final de adicao de alien

Posicao240:
  ;===================================
  ; Atualiza num de inimigos na coluna
  ;===================================
  ld a,(NumContColuna4)
  inc a
  ld (NumContColuna4),a
  ;===================================
  ; Atualiza num de inimigos
  ;===================================
  ld a,(NumInimigos)
  inc a
  ld (NumInimigos),a
  ;==========================
  ; Desenhar Alien
  ; O Alien usa 2 sprites
  ;==========================
  ld a,(NumContColuna4)
  ld b,16
  call Multiply               ; Multiplicar o contador de inimigos por 16
  ld d,a                      ; posicao y
  ld e,240                    ; posicao x
  ld a,(NumInimigos)          ; posicao na tabela de atributos
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
jp FimDesenhoAlien            ; Final de adicao de alien
