; =============================================================================
;  ChecarColisao.asm
; =============================================================================
;  (C) 2019 Manoel Neto - tremyen@gmail.com
;  Testa as colisoes dos sprites na tela
; =============================================================================
ChecarColisao:
  ; ================================================
  ; CHECAR TORPEDOS
  ; UM TORPEDO DEVE SER REMOVIDO CASO SUA POSICAO Y
  ; SEJA IGUAL A 1
  ; ================================================
  ld a,(NumTorpedos)    ; pego o numero de torpedos na tela
  cp 0                  ; se for zero nao existem torpedos
  jp z,FimTorpedos      ; termina a checagem de torpedos
  ld b,a                ; guardo para o loop de torpedos
LoopTorpedos:
  ld a,27               ; os sprites de torpedos comecam em 28
  add a,b               ; somo o contador de torpedos
  ld c,a                ; guardo o numero do sprite para uso posterior
  push bc               ; BC e alterado por ReadSprite entao guardo
  push de               ; DE e alterado por ReadSprite entao guardo
    call ReadSprite     ; leio esse sprite
    ld a,d              ; pego a posicao y
  pop de                ; retorno DE
  pop bc                ; retorno BC
  cp 1                  ; verifico se a posicao e 1
  call z,ArrumaTorpedos ; se for 1 preciso reorganizar a fila de TORPEDOS
  dec b                 ; decremento o loop
  ld a,b                ; preparo a comparacao
  cp 0                  ; comparo com zero
  jp z,FimTorpedos      ; se decrementamos tudo, checamos os TORPEDOS
jp LoopTorpedos

FimTorpedos:
ret

ArrumaTorpedos:
  ld a,(NumTorpedos)  ; pego o numero de torpedos
  dec a               ; removo um torpedo da fila
  ld (NumTorpedos),a  ; guardo o novo num de torpedos na variavel
  ld a,c              ; pego o numero do sprite
  call RemoverTorpedo ; removo o torpedo da tabela de atributos e reorganizo
ret
