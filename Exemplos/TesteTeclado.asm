; ============================================================================
; TESTE DE CHAMADA DE TECLADO
; ============================================================================
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
GameLoop:
  call KeyboardCleanBuffer
  call KeyboardRead
  ld a,(KeyPresses)
  cp 0
  jp nz,Digitou
VoltaParaLoop:
jp GameLoop

Digitou:
  ld hl,Mensagem
  call PrintString
jr VoltaParaLoop

Mensagem:
  db "Usuario digitou uma tecla!",0

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
; =============================================================================
; Padding
; =============================================================================
romPad:
 ds romSize-(romPad-romArea),0
end
