__VERSION:  equ 1
__RELEASE:  equ 0
include "Hardware\BIOSMSX.ASM"
include "Assets\Constantes.asm"
include "Assets\Variaveis.asm"

org romArea
  db "AB"                     ; ID
  dw startProgram             ; INIT
  dw 0x0000                   ; STATEMENT
  dw 0x0000                   ; DEVICE
  dw 0x0000                   ; TEXT
  ds 6,0                      ; RESERVED

startProgram:
  ld a,(NumTorpedos)      	; pegar numero de torpedos
  cp 4                    	; fila cheia
  jp z,FimAdicionarTorpedo 	; se tiver 4, nao adiciona
  ld a,(NumTorpedos)      	; atualizamos a variavel NumTorpedos
  inc a                   	; adicionamos um torpedo
  ld (NumTorpedos),a      	; atualizamos a variavel NumTorpedos
  ld a,(flgTorpedos)				; pega o flag de torpedos
  bit 0,a
  jp z,AdicionaPosicao28
  bit 1,a
  jp z,AdicionaPosicao29
  bit 2,a
  jp z,AdicionaPosicao30
  bit 3,a
  jp z,AdicionaPosicao31
AdicionaPosicao28:
  ld a,(NumPosYNave)      		; pegar posicao y da nave
  sub 16                 			; coordenada y = NumPosYNave-16
  ld d,a                  		; Guarda a posicao y
  ld a,(NumPosXNave)      		; pegar posicao x da nave
  ld e,a                  		; Guarda a posicao X
  ld a,28											; desenhar o torpedo na posicao 28
  call DesenharTorpedo				; da tabela de atributos
  ld a,(flgTorpedos)					; pega o flag de torpedos
  set 0,a 										; liga o flag
  ld (flgTorpedos),a 					; salva o flag
  jp FimAdicionarTorpedo
AdicionaPosicao29:
  ld a,(NumPosYNave)      		; pegar posicao y da nave
  sub 16                 			; coordenada y = NumPosYNave-16
  ld d,a                  		; Guarda a posicao y
  ld a,(NumPosXNave)      		; pegar posicao x da nave
  ld e,a                  		; Guarda a posicao X
  ld a,29
  call DesenharTorpedo
  ld a,(flgTorpedos)					; pega o flag de torpedos
  set 1,a 										; liga o flag
  ld (flgTorpedos),a 					; salva o flag
  jp FimAdicionarTorpedo
AdicionaPosicao30:
  ld a,(NumPosYNave)      		; pegar posicao y da nave
  sub 16                 			; coordenada y = NumPosYNave-16
  ld d,a                  		; Guarda a posicao y
  ld a,(NumPosXNave)      		; pegar posicao x da nave
  ld e,a                  		; Guarda a posicao X
  ld a,30
  call DesenharTorpedo
  ld a,(flgTorpedos)					; pega o flag de torpedos
  set 2,a 										; liga o flag
  ld (flgTorpedos),a 					; salva o flag
  jp FimAdicionarTorpedo
AdicionaPosicao31:
  ld a,(NumPosYNave)      		; pegar posicao y da nave
  sub 16                 			; coordenada y = NumPosYNave-16
  ld d,a                  		; Guarda a posicao y
  ld a,(NumPosXNave)      		; pegar posicao x da nave
  ld e,a                  		; Guarda a posicao X
  ld a,31
  call DesenharTorpedo
  ld a,(flgTorpedos)					; pega o flag de torpedos
  set 3,a 										; liga o flag
  ld (flgTorpedos),a 					; salva o flag
FimAdicionarTorpedo:
ret

ret
include "..\Hardware\TMS9918.ASM"
include "..\Library\Library.ASM"
include "..\Assets\Sprites.asm"

romPad:
  ds romSize-(romPad-romArea),0
  end
