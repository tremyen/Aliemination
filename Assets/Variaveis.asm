; =============================================================================
; Variaveis.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Variaveis utilizadas no jogo
; =============================================================================
romSize            equ 32768        ; O tamanho que a ROM deve ter
romArea            equ &4000        ; Minha ROM começa aqui
ramArea            equ &E000        ; Inicio da área de variáveis
NumCentenas  		   equ ramArea+1    ; Usada em PrintNumber
NumDezenas  		   equ ramArea+2    ; Usada em PrintNumber
NumUnidades  		   equ ramArea+3    ; Usada em PrintNumber
PosXNave           equ ramArea+4    ; Posicao da nave no plano X
PosYNave           equ ramArea+5    ; Posicao da nave no plano y
Semana             equ ramArea+6    ; Pontuacao do jogo
VidaJogador        equ ramArea+7    ; Vidas do jogador
VelAlien           equ ramArea+8    ; Velocidade dos aliens
Torpedos           equ ramArea+9    ; Conta os torpedos na tela
AliensMortos       equ ramArea+10   ; Conta os aliens mortos
NumInimigos        equ ramArea+11   ; Numero de inimigos na tela
KeyPresses         equ ramArea+12   ; Buffer de teclado
NumContColuna1     equ ramArea+13   ; Conta inimigos na coluna 1
NumContColuna2     equ ramArea+14   ; Conta inimigos na coluna 2
NumContColuna3     equ ramArea+15   ; Conta inimigos na coluna 3
NumContColuna4     equ ramArea+16   ; Conta inimigos na coluna 4
; =============================================================================
