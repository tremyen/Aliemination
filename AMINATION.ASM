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
	ld a,(NumVidaJogador)				; Pega as vidas do jogador
	cp 0 												; se nao tem mais vidas
	jp z,FimDoJogo							; finaliza o jogo
	ld a,(NumCidades)						; Pega o numero de cidades
	cp 0 												; se nao tem mais cidades
	jp z,FimDoJogo							; finaliza o jogo
	call GerarAliens						; sorteia os aliens de acordo com a semana
DesenharQuadro:
	call PegarComandos					; pega a entrada de teclado do jogador
	call MoverTorpedos					; Atualiza coordenadas dos torpedos
	call MoverAliens						; Atualiza coordenadas dos Aliens
	call MoverNave							; Atualiza coordenadas da nave
	;call ChecarColisao					; checa as colisoes
	xor a 											; zero A
	ld (JIFFY),a								; zero o incremento do VDP
	ld a,(vdpCycle1)						; carrego 1/10s
  ld b,a											; carrego 1/10s em b
  call PauseVDP               ; aguardo 1/10s
jr DesenharQuadro						  ; loop de desenho do frame
FimDoJogo:
	jr startCode								; recomeca o jogo
; =============================================================================
; FIM PROGRAMA
; =============================================================================
include "Inicializar.asm"
include "TelaInicial.asm"
include "GerarAliens.asm"
include "PegarComandos.asm"
include "MoverTorpedos.asm"
include "MoverAliens.asm"
include "MoverNave.asm"
include "ChecarColisao.asm"
include "Hardware\AY38910.ASM"
include "Hardware\TMS9918.ASM"
include "Hardware\KEYBOARD.ASM"
include "Library\Library.asm"
include "Assets\Sprites.asm"
Cenario:
	incbin "Assets\CENARIO.SC2"
; =============================================================================
; Padding
; =============================================================================
romPad:
 ds romSize-(romPad-romArea),0
end
