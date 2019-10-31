; =============================================================================
; Variaveis.asm
; =============================================================================
; Manoel Neto 2019-09-25
; Variaveis utilizadas no jogo
; =============================================================================
romSize            equ 32768       ; O tamanho que a ROM deve ter
romArea            equ &4000       ; Minha ROM começa aqui
ramArea            equ &E000       ; Inicio da área de variáveis
NumCentenas  		   equ ramArea+1   ; Variavel => Usada em PrintNumber
NumDezenas  		   equ ramArea+2   ; Variavel => Usada em PrintNumber
NumUnidades  		   equ ramArea+3   ; Variavel => Usada em PrintNumber
PosicaoXNave       equ ramArea+4
PosicaoYNave       equ ramArea+5
PosicaoXAlienigena equ ramArea+6
PosicaoYAlienigena equ ramArea+7
PosicaoXCidade     equ ramArea+8
PosicaoYCidade     equ ramArea+9
