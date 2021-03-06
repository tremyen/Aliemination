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

org romArea
	db "AB"                     ; identifica como ROM
 	dw startCode                ; endereço de execução
 	db "AM01"                   ; string de identificação
 	ds 6,0
; =============================================================================
; INICIO PROGRAMA
; =============================================================================
startCode:  
  	call Inicializar          	; Inicializar o ambiente do jogo
  	call TelaInicial          	; tela de inicio do jogo
GameLoop:
	call PassarDeNivel			; passa para a proxima fase
	call GerarAliens			; sorteia os aliens de acordo com a fase
DesenharQuadro:
	ld a,(NumCidades)			; pega o numero de cidades
	cp 0 						; se nao tem mais cidades
	jp z,FimDoJogo				; finaliza o jogo
	ld a,(NumAliens)			; pega o numero de aliens
	cp 0 						; se nao tem mais aliens
	jp z,FimDoJogo				; iniciamos um novo nivel
	call PegarComandos			; pega a entrada de teclado do jogador
	call MoverTorpedos			; Atualiza coordenadas dos torpedos
	call MoverAliens			; Atualiza coordenadas dos Aliens
	call MoverNave				; Atualiza coordenadas da nave
	call ChecarColisao			; checa as colisoes
	ld a,(flgColisaoAlien)		; pega o resultado das colisoes
	cp 3						; se é igual a 3 a nave colidiu 
	jp z,FimDoJogo				; termina o jogo
	call AtualizarHud			; Atualiza o HUD do jogo
	xor a 						; zero A
	ld (JIFFY),a				; zero o incremento do VDP
	ld a,(vdpCycle1)			; carrego 1/10s
	ld b,a						; carrego 1/10s em b
	call PauseVDP               ; aguardo 1/10s
	jp DesenharQuadro			; loop de desenho do frame
FimDoJogo:
	jp startCode				; recomeca o jogo

include "Inicializar.asm"
include "TelaInicial.asm"
include "PassarDeNivel.asm"
include "GerarAliens.asm"
include "PegarComandos.asm"
include "MoverTorpedos.asm"
include "MoverAliens.asm"
include "MoverNave.asm"
include "ChecarColisao.asm"
include "AtualizarHud.asm"
; =============================================================================
; FIM PROGRAMA
; =============================================================================
include "Assets\Variaveis.asm"
include "Assets\Sprites.asm"
include "Assets\Strings.asm"
include "Assets\Library.asm"
include "Hardware\AY38910.ASM"
include "Hardware\TMS9918.ASM"
include "Hardware\KEYBOARD.ASM"
; =============================================================================
; Padding
; =============================================================================
romPad:
 ds romSize-(romPad-romArea),0