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

org &810A
; =============================================================================
; INICIO PROGRAMA
; =============================================================================
startCode:
  call Inicializar          	; Inicializar o ambiente do jogo
  call TelaInicial          	; tela de inicio do jogo
GameLoop:
	call PassarSemana			; passa para a proxima semana
	call GerarAliens			; sorteia os aliens de acordo com a semana
DesenharQuadro:
	ld a,(NumCidades)			; pega o numero de cidades
	cp 0 						; se nao tem mais cidades
	jp z,FimDoJogo				; finaliza o jogo
	ld a,(NumAliens)			; pega o numero de aliens
	cp 0 						; se nao tem mais aliens
	jp z,GameLoop				; iniciamos um novo nivel
	call PegarComandos			; pega a entrada de teclado do jogador
	call MoverTorpedos			; Atualiza coordenadas dos torpedos
	call MoverAliens			; Atualiza coordenadas dos Aliens
	call MoverNave				; Atualiza coordenadas da nave
	call ChecarColisao			; checa as colisoes
	xor a 						; zero A
	ld (JIFFY),a				; zero o incremento do VDP
	ld a,(vdpCycle1)			; carrego 1/10s
	ld b,a						; carrego 1/10s em b
	call PauseVDP               ; aguardo 1/10s
jr DesenharQuadro				; loop de desenho do frame
FimDoJogo:
	call LimpaMem				; limpa as variaveis
jp startCode					; recomeca o jogo

; =============================================================================
; FIM PROGRAMA
; =============================================================================
Cenario:
incbin "Assets\CENARIO.SC2"
include "Assets\Variaveis.asm"
include "Assets\Sprites.asm"
include "Assets\Strings.asm"
include "Assets\Library.asm"
include "Hardware\AY38910.ASM"
include "Hardware\TMS9918.ASM"
include "Hardware\KEYBOARD.ASM"
include "Inicializar.asm"
include "TelaInicial.asm"
include "GerarAliens.asm"
include "PegarComandos.asm"
include "MoverTorpedos.asm"
include "MoverAliens.asm"
include "MoverNave.asm"
include "ChecarColisao.asm"