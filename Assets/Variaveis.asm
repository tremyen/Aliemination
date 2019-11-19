; =============================================================================
; Variaveis.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Variaveis utilizadas no jogo
; =============================================================================
romSize            equ 32768        ; O tamanho que a ROM deve ter
romArea            equ &4000        ; Minha ROM começa aqui
ramArea            equ &E000        ; Inicio da área de variáveis
NumCentenas  		   equ ramArea+1    ; Variavel => Usada em PrintNumber
NumDezenas  		   equ ramArea+2    ; Variavel => Usada em PrintNumber
NumUnidades  		   equ ramArea+3    ; Variavel => Usada em PrintNumber
PosXNave           equ ramArea+4    ; Variavel => Posicao da nave no plano X
PosYNave           equ ramArea+5    ; Variavel => Posicao da nave no plano y
Semana             equ ramArea+6    ; Variavel => Pontuacao do jogo
VidaJogador        equ ramArea+7    ; Variavel => Vidas do jogador
VelAlien           equ ramArea+8    ; Variavel => Velocidade dos aliens
Torpedos           equ ramArea+9    ; Variavel => Conta os torpedos na tela
AliensMortos       equ ramArea+10   ; Variavel => Conta os aliens mortos
PosXAlien          equ ramArea+11   ; Variavel => Posicao Inicial Alien X
PosYAlien          equ ramArea+12   ; Variavel => Posicao Inicial Alien Y
; =============================================================================
