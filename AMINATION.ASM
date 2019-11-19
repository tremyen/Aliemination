; =============================================================================
;  Aliemination 1.0
; =============================================================================
;  (C) 2019 Manoel Neto - tremyen@gmail.com
;  Mude, compartilhe e estude. Conhecimento é de graça.
; =============================================================================
__VERSION:  equ 1
__RELEASE:  equ 0
include "Hardware\BiosMSX.asm"
include "Assets\Constantes.asm"
include "Assets\Variaveis.asm"

org romArea
	db "AB"                     ; identifica como ROM
 	dw startCode                ; endereço de execução
 	db "AM01"                   ; string de identificação
 	ds 6,0

; =============================================================================
; INICIO PROGRAMA
; =============================================================================
startCode:
  call Inicializar            ; Inicializar o ambiente do jogo
  call TelaInicial            ; tela de inicio do jogo

gameLoop:
	call AtualizarVariaveis
	call DesenharQuadro
	ld a,(VidaJogador)
	cp 0
	jr z,FimDoJogo
	jr gameLoop
FimDoJogo:
	jr startCode

include "Inicializar.asm"
include "TelaInicial.asm"

; =============================================================================
; FIM PROGRAMA
; =============================================================================
include "Hardware\AY38910.ASM"
include "Hardware\TMS9918.ASM"
include "Library\Library.asm"
include "Assets\Strings.asm"
include "Assets\Fonts.asm"
include "Assets\Sprites.asm"

Cenario:
	incbin "Assets\CENARIO.SC2"

; =============================================================================
; Padding
; =============================================================================
romPad:
 ds romSize-(romPad-romArea),0
end
