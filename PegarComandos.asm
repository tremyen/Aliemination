; =============================================================================
; PegarComandos.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Pegar as entradas do jogador e gravar no buffer
; =============================================================================

; =============================================================================
; layout do buffer de entrada
; =============================================================================
; Todas as teclas que usamos estao na linha 8 do teclado
; 00000000 => 76543210
; se o bit 0 esta ligado,espaco foi pressionado
; se o bit 4 esta ligado,esquerda foi pressionado
; se o bit 5 esta ligado,cima foi pressionado
; se o bit 6 esta ligado,baixo foi pressionado
; se o bit 7 esta ligado,direita foi pressionado
; =============================================================================
PegarComandos:
  xor a                     ; limpa o buffer
  ld a,8                    ; le a linha 8 para ver se as setas estao ligadas
  call Keyboard             ; carrega linha 8 no acumulador
  bit 0,a                   ; Se 0, adiciona um torpedo na posx da nave
  call z,AdicionarTorpedo
  bit 4,a                   ; Se 4 foi ligado, Esquerda
  call z,Esquerda
  bit 5,a                   ; Se 5 foi ligado, Subir
  call z,Subir
  bit 6,a                   ; Se 6 foi ligado, Descer
  call z,Descer
  bit 7,a                   ; Se 7 foi ligado, Direita
  call z,Direita
ret

Direita:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosXNave         ; pega posicao x da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    cp 240                    ; A nave nao pode sair da tela
    jp nc,PosMaximaDir        ; na posicao maxima, nao se move mais
    add a,d                   ; tira a velocidade da coordenada X
    ld (hl),a                 ; guarda a posicao da nave
PosMaximaDir:
  pop af
ret

Subir:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosYNave         ; pega posicao y da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    cp 70                     ; A nave nao pode sair da tela
    jp c,PosMaximaSub         ; na posicao maxima, nao se move mais
    sub d                     ; tira a velocidade da coordenada y
    ld (hl),a                 ; guarda a posicao da nave
PosMaximaSub:
  pop af
ret

Descer:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosYNave         ; pega posicao y da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    cp 101                    ; A nave nao pode sair da tela
    jp nc,PosMaximaDes        ; na posicao maxima, nao se move mais
    add a,d                   ; tira a velocidade da coordenada y
    ld (hl),a                 ; guarda a posicao da nave
PosMaximaDes:
  pop af
ret

Esquerda:
  push af
    ld hl,NumVelNave          ; pega a velocidade da nave
    ld a,(hl)                 ; guarda para uso posterior
    ld d,a                    ; no registrador d
    ld hl,NumPosXNave         ; pega posicao x da nave
    ld a,(hl)                 ; prepara o acumulador para a conta
    cp 1                      ; A nave nao pode sair da tela
    jp c,PosMaximaEsq         ; na posicao maxima, nao se move mais
    sub d                     ; tira a velocidade da coordenada X
    ld (hl),a                 ; guarda a posicao da nave
PosMaximaEsq:
  pop af
ret
