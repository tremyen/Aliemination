; =============================================================================
; Adicionar novos aliens no jogo
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
GerarAliens:
  ld a,(VelAlien)         ; pega a velocidade atual dos aliens
  inc a                   ; aumenta em 1
  ld b,a                  ; prepara o contador do numero de sorteios
SorteiaAliens:            ; sorteia um numero de aliens igual a velocidade+1
  ld a,4                  ; os aliens podem estar em 4 posicoes X
                          ; (10,40,184 ou 240)
  call RandomNumber       ; A tem um aleatorio entre 1 e 4
  cp 0
  jp z,Posicao10          ; se sorteou 1 bota alien na posicao 10
  cp 1
  jp z,Posicao40          ; se sorteou 2 bota alien na posicao 40
  cp 2
  jp z,Posicao184         ; se sorteou 3 bota alien na posicao 184
  cp 3
  jp z,Posicao240         ; se sorteou 4 bota alien na posicao 240
ret

Posicao10:
  ;==========================
  ; Desenhar Alien
  ; O Alien usa 2 sprites
  ;==========================
  ld a,(NumInimigos)
  add a,4                     ; os sprites estao em blocos de 4 bytes
  ld (NumInimigos),a          ; guarda o ponteiro de inimigos
  ld d,0                      ; posicao y
  ld e,10                     ; posicao x
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
  dec b                       ; reduz o loop do sorteio de aliens
  ld a,b                      ; prepara a comparcao
  cp 0
  jp nz,SorteiaAliens         ; se não zerou precisamos sortear mais aliens
ret

Posicao40:
  ;==========================
  ; Desenhar Alien
  ; O Alien usa 2 sprites
  ;==========================
  ld a,(NumInimigos)
  add a,4                     ; os sprites estao em blocos de 4 bytes
  ld (NumInimigos),a          ; guarda o ponteiro de inimigos
  ld d,16                     ; posicao y
  ld e,40                     ; posicao x
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
  dec b                       ; reduz o loop do sorteio de aliens
  ld a,b                      ; prepara a comparcao
  cp 0
  jp nz,SorteiaAliens         ; se não zerou precisamos sortear mais aliens
ret

Posicao184:
  ;==========================
  ; Desenhar Alien
  ; O Alien usa 2 sprites
  ;==========================
  ld a,(NumInimigos)
  add a,4                     ; os sprites estao em blocos de 4 bytes
  ld (NumInimigos),a          ; guarda o ponteiro de inimigos
  ld d,16                     ; posicao y
  ld e,184                    ; posicao x
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
  dec b                       ; reduz o loop do sorteio de aliens
  ld a,b                      ; prepara a comparcao
  cp 0
  jp nz,SorteiaAliens         ; se não zerou precisamos sortear mais aliens
ret

Posicao240:
  ;==========================
  ; Desenhar Alien
  ; O Alien usa 2 sprites
  ;==========================
  ld a,(NumInimigos)
  add a,4                     ; os sprites estao em blocos de 4 bytes
  ld (NumInimigos),a          ; guarda o ponteiro de inimigos
  ld d,0                     ; posicao y
  ld e,240                    ; posicao x
  call DesenharAlienigena     ; Adicionar o Alienigena na tabela de atributos
  dec b                       ; reduz o loop do sorteio de aliens
  ld a,b                      ; prepara a comparcao
  cp 0
  jp nz,SorteiaAliens         ; se não zerou precisamos sortear mais aliens
ret
