; =============================================================================
; ChecarColisao.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Testa as colisoes dos sprites na tela
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
  call c,ArrumaTorpedos ; se for menor que 1 preciso reorganizar TORPEDOS
  dec b                 ; decremento o loop
  ld a,b                ; preparo a comparacao
  cp 0                  ; comparo com zero
  jp z,FimTorpedos      ; se decrementamos tudo, checamos os TORPEDOS
jp LoopTorpedos
FimTorpedos:
  call ReadStatus       ; verifica se houve alguma colisao de sprites
  bit 5,a               ; posicao no status do vdp para colisao
  jp nz,FimColisoes     ; nao houve colisao, terminar
ChecarNave:
  ; todo - checar nos sprites da nave o flag de colisao
ChecarCidades:
  ; todo - checar nos sprite que tem cidades o flag de colisao
ChecarAliens:
  ; todo - checar nos sprites que tem aliens o flag de colisao

FimColisoes:
ret

ArrumaTorpedos:
  ld a,(NumTorpedos)  ; pego o numero de torpedos
  dec a               ; removo um torpedo da fila
  ld (NumTorpedos),a  ; guardo o novo num de torpedos na variavel
  ld a,c              ; pego o numero do sprite
  call RemoverTorpedo ; removo o torpedo da tabela de atributos e reorganizo
ret
