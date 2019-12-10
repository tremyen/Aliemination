; =============================================================================
; MoverNave.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Mover a nave de acordo com as variaveis
; =============================================================================
MoverNave:
    ;==========================
    ; Desenhar Nave
    ; A Nave usa 2 sprites
    ; (0,1)
    ;==========================
    ld a,(NumPosYNave)
    ld d,a
    ld a,(NumPosXNave)
    ld e,a
    ld a,0                      ; posicao do sprite na tabela de atributos
    call DesenharNave
ret
