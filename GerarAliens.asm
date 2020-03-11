; =============================================================================
; Adicionar novos aliens no jogo
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
GerarAliens:
  ld a,(NumSemana)        ; pega a semana atual
  sla a
  sla a                   ; multiplico por 4 
  ld (NumAliensMortos),a  ; aliens que precisam ser eliminados
  ld (NumSorteios),a      ; prepara o contador do numero de sorteios
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
; =============================================================================
