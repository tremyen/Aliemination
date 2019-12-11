; =============================================================================
; Mover os torpedos na tela
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
; Sobe os torpedos de acordo com sua velocidade.
; Os torpedos são todos os sprites 28,29,30 e 31.
; =============================================================================
MoverTorpedos:
	push af
		push bc
      ld hl,NumTorpedos             ; pega o endereco do numero dos torpedos
			ld a,(hl)							        ; pega o conteudo do endereco
      cp 0                          ; se nao existem torpedos
      jp z,FimMoveTorpedos          ; nao preciso mover nada
			ld b,a												; guarda para loop
      add a,27											; comeco pelo ultimo torpedo
LoopMoveTorpedos:
			call CALATR  									; pega o endereco do sprite atual
			call RDVRM										; pega o conteudo do endereco byte 1(y)
      cp 0                          ; se a coordenada e zero
      call z,ReorganizarTorpedos    ; matamos o sprite
			dec a                         ; sobe uma posicao
      call WRTVRM                   ; atualiza
      dec b                         ; controla o loop
      ld a,b                        ; pega o sprite anterior
      cp 0                          ; verifica se movemos todos os torpedos
      jr z,FimMoveTorpedos          ; acabou o loop
      add a,27                      ; pega o proximo
      jr LoopMoveTorpedos           ; move o proximo
FimMoveTorpedos:
		pop bc
	pop af
ret

ReorganizarTorpedos:
  push af
  push bc
  push de
    inc a                           ; incrementa o numero do sprite
    call ReadSprite                 ; pega o proximo sprite
    dec a                           ; volta para o sprite inicial
    call PutSprite                  ; poe o sprite de cima na posicao atual
    ld hl,NumTorpedos               ; pega o endereco do numero de torpedos
    ld a,(hl)                       ; pega o conteudo
    dec a                           ; decrementa o numero de torpedos
    ld (hl),a                       ; atualiza o numero de torpedos
  pop de
  pop bc
  pop af
ret
  
; =============================================================================
