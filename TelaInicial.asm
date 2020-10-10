; =============================================================================
; Desenhar a tela de entrada do jogo
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
TelaInicial:
  call ClearScreen
  call DISSCR
    call SetScreen2_16x16       ; Seta a tela para screen 2 com sprites 16 x 16
    ; =========================================================================
    ; DESENHAR O CENARIO
    ; =========================================================================
    ;ld de,0                     ; Base da memoria da VRAM
    ;ld hl,Cenario+7             ; os primeiros 7 bytes sao cabecalho
    ;ld bc,15360                 ; tamanho da BMP
    ;call LDIRVM                 ; copio para a VRAM
    ; =========================================================================
    ; CARREGA AS TABELAS DO VDP
    ; =========================================================================
    call LoadSpritesTable       ; Carrega os sprites
    ; =========================================================================
    ; Desenhar Nave usa 2 sprites (0,1)
    ; =========================================================================
    ld a,(NumPosYNave)
    ld d,a
    ld a,(NumPosXNave)
    ld e,a
    call DesenharNave
    ; =========================================================================
    ; Desenhar Cidade usa 2 sprites (2,3)
    ; =========================================================================
    ld a,PosYCidade1
    ld d,a
    ld a,PosXCidade1
    ld e,a
    ld a,2                      ; posicao do sprite na tabela de atributos
    call DesenharCidade
    ; =========================================================================
    ; Desenhar Cidade 2 usa 2 sprites (4,5)
    ; =========================================================================
    ld a,PosYCidade2
    ld d,a
    ld a,PosXCidade2
    ld e,a
    ld a,4                      ; posicao do sprite na tabela de atributos
    call DesenharCidade
    ; =========================================================================
    ; Desenhar Cidade 3 usa 2 sprites (6,7)
    ; =========================================================================
    ld a,PosYCidade3
    ld d,a
    ld a,PosXCidade3
    ld e,a
    ld a,6                     ; posicao do sprite na tabela de atributos
    call DesenharCidade
    ; =========================================================================
    ; Desenhar Cidade 4 usa 2 sprites (8,9)
    ; =========================================================================
    ld a,PosYCidade4
    ld d,a
    ld a,PosXCidade4
    ld e,a
    ld a,8                     ; posicao do sprite na tabela de atributos
    call DesenharCidade
    ; =========================================================================
    ; Escrever a mensagem de inicio de jogo
    ; =========================================================================
    ld hl,MsgInicioJogo
    call PrintStringGRP
  call ENASCR
  xor a
  call WaitEnter
ret