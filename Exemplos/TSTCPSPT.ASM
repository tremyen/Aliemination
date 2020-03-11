include "..\Hardware\BIOSMSX.ASM"
include "..\Assets\Constantes.asm"
include "..\Assets\Variaveis.asm"

org romArea
	db "AB"                     ; identifica como ROM
 	dw startCode                ; endereço de execução
 	db "AM01"                   ; string de identificação
 	ds 6,0

startCode:
  ; ====================================================================
  ; PREPARAR O AMBIENTE
  ; ====================================================================
  call SetScreen2_16x16
  call ClearScreen
  call LoadSpritesTable
  ; ====================================================================
  ; INCLUIR UM SPRITE
  ; ====================================================================
  ld a,0              ; A => Numero do Sprite na tabela de atributos
  ld d,100            ; D => posicao Y
  ld e,100            ; E => posicao X
  ld b,16             ; B => Numero do sprite na tabela de sprites
  ld c,13             ; C => Early / Cor
  call PutSprite

  ld b,1
  ld c,100
LoopCopiaSprite:
  ; ====================================================================
  ; COPIAR ESSE SPRITE
  ; ====================================================================
  ld a,0
  ld l,b
  call CopySprite
  ; ====================================================================
  ; MOVER O SPRITE COPIADO
  ; ====================================================================
  ld a,b
  ld b,100
  ld c,120
  call MoveSprite
  ; ====================================================================

  ; ====================================================================
  ; AGUARDA ENTER
  ; ====================================================================
  call WaitEnter
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
