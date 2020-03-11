; =============================================================================
; Variaveis.asm
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Variaveis utilizadas no jogo
; =============================================================================
ramArea:           equ &E000      ; Inicio da área de variáveis
NumCentenas: 		   equ ramArea+1  ; Usada em PrintNumber
NumDezenas:  		   equ ramArea+2  ; Usada em PrintNumber
NumUnidades: 		   equ ramArea+3  ; Usada em PrintNumber
NumPosXNave:       equ ramArea+4  ; Posicao da nave no plano X
NumPosYNave:       equ ramArea+5  ; Posicao da nave no plano y
NumSemana:         equ ramArea+6  ; Pontuacao do jogo
NumVelAlien:       equ ramArea+7  ; Velocidade dos aliens
NumTorpedos:       equ ramArea+8  ; Conta os torpedos na tela
NumAliens:         equ ramArea+9  ; Numero de inimigos na tela
NumVelNave:        equ ramArea+10 ; Velocidade da nave
NumContColuna1:    equ ramArea+11 ; Conta inimigos na coluna 1
NumContColuna2:    equ ramArea+12 ; Conta inimigos na coluna 2
NumContColuna3:    equ ramArea+13 ; Conta inimigos na coluna 3
NumContColuna4:    equ ramArea+14 ; Conta inimigos na coluna 4
NumSorteios:       equ ramArea+15 ; Conta quantos aliens foram sorteados
NumCidades:        equ ramArea+16 ; Conta o numero de cidades
vdpCycle1:         equ ramArea+17 ; Calculo de um ciclo de VPD
vdpCycle5:         equ ramArea+18 ; Calculo de cinco ciclos de VPD
flgColisaoAlien:   equ ramArea+19 ; flag de colisao de alien (000000XY)
flgTorpedos:       equ ramArea+20 ; flag de torpedos (0000 T4 T3 T2 T1)
flgHouveColisao:   equ ramArea+21 ; flag que indica que houve uma colisao
flgNovoNivel:      equ ramArea+22 ; flag que indica que temos de passar o nivel
SpriteY            equ ramArea+23 ; Armazenamento para copia de sprites
SpriteX            equ ramArea+24 ; Armazenamento para copia de sprites
SpriteP            equ ramArea+24 ; Armazenamento para copia de sprites
SpriteC            equ ramArea+24 ; Armazenamento para copia de sprites 
; =============================================================================
