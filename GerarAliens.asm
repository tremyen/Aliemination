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
  call RandomNumber       ; sorteia em A um aleatorio entre 0 e 3
  call AdicionarAlien     ; adiciona um alien na coluna sorteada
  ld a,(NumSorteios)      ; le quantos sorteios devem ser efetuados
  dec a                   ; controla o numero de sorteios
  ld (NumSorteios),a      ; atualiza o numero de sorteios
  cp 0                    ; sorteou todos
  jr z,FimSorteiaAliens   ; volta para loop do jogo
jr SorteiaAliens          ; volta para o sorteio de aliens
FimSorteiaAliens:
ret
