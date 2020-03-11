include "..\Hardware\BIOSMSX.ASM"
include "..\Assets\Constantes.asm"
include "..\Assets\Variaveis.asm"

org romArea
	db "AB"                     ; identifica como ROM
 	dw startCode                ; endereço de execução
 	db "AM01"                   ; string de identificação
 	ds 6,0

startCode:
  call INIGRP
  ld hl,MsgInicioJogo
  call PrintStringGRP
ret

include "..\Assets\Library.asm"
include "..\Assets\Strings.asm"
include "..\Assets\Sprites.asm"
include "..\Hardware\AY38910.ASM"
include "..\Hardware\TMS9918.ASM"
include "..\Hardware\KEYBOARD.ASM"

; =============================================================================
; Padding
; =============================================================================
romPad:
 ds romSize-(romPad-romArea),0
end
