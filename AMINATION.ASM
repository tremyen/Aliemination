; =============================================================================
;  Aliemination 1.0
; =============================================================================
;  (C) 2019 Manoel Neto - tremyen@gmail.com
;  Mude, compartilhe e estude. Conhecimento é de graça.
; =============================================================================
__VERSION:  equ 1
__RELEASE:  equ 0
include "Hardware\BIOSMSX.ASM"
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
	call GerarAliens						; sorteia os aliens de acordo com a semana
DesenharQuadro:
	call PegarComandos					; pega a entrada de teclado do jogador
	call MoverTorpedos					; Atualiza coordenadas dos torpedos
	call MoverNave							; Atualiza coordenadas da nave
	;call MoverAliens						; Atualiza coordenadas dos Aliens
	;call ChecarColisao					; checa as colisoes
	ld a,(NumVidaJogador)	  		; pega as vidas do jogador
	cp 0
	jr z,FimDoJogo							; se for zero o jogo acabou
	ld a,(NumAliensMortos)			; pega os aliens mortos
	cp 4												; se for 4 vai para a proxima semana
	jr z,ProximoNivel						; proxima semana
	jr DesenharQuadro						; loop de movimento dos inimigos
ProximoNivel:
	ld a,(NumVelAlien)					; pega a velocidade dos aliens
	inc a												; aumenta em um
	ld (NumVelAlien),a					; atualiza
	jr gameLoop									; recomeca no novo nivel
FimDoJogo:
	jr startCode								; recomeca o jogo

include "Inicializar.asm"
include "TelaInicial.asm"
include "GerarAliens.asm"
include "PegarComandos.asm"
include "MoverNave.asm"
include "MoverTorpedos.asm"

; =============================================================================
; FIM PROGRAMA
; =============================================================================
include "Hardware\AY38910.ASM"
include "Hardware\TMS9918.ASM"
include "Hardware\KEYBOARD.ASM"
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
