; =============================================================================
; TMS9918.ASM
; =============================================================================
; Manoel Neto 2019-10-04
; Biblioteca para uso do VDP do MSX 1
; =============================================================================

; =============================================================================
; MODOS DE OPERACAO DO VDP
; =============================================================================
;	M1	M2	M3	M4	M5	Mode	 			MSX Version	BASIC Screen
;	1		0		0		0		0		40x24 Text	1 2 2+ tR		0
;	0		0		0		0		0	 	32x24	Text	1 2 2+ tR	 	1
;	0		0		1		0		0		Graphics 1	1 2 2+ tR		2
;	0		1		0		0		0		Multicolour	1 2 2+ tR		3
;	0		0		0		1		0		Graphics 2	  2 2+ tR		4
;	0		0		1		1		0		Graphics 4	  2 2+ tR		5
;	0		0		0		0		1		Graphics 5	  2 2+ tR		6
;	0		0		1		0		1		Graphics 6	  2 2+ tR		7
;	0		0		1		1		1		Graphics 7	  2 2+ tR		8
;	1		0		0		1		0		80x24 Text	  2 2+ tR		0
; =============================================================================

; =============================================================================
; VDP MODO GRAFICO I (SCREEN 1)
; =============================================================================
;	Padrões de azulejos	=> 00000 ate 06143 (&H0000..&17FFH) => 6143 Bytes
; Mapa dos ajulejos		=> 06144 ate 06911 (&H1800..&H1AFF)	=> 0767 Bytes
; Tabela de atributos => 06912 ate 07039 (&H1B00..&H1B7F)	=> 0127 Bytes
; Paleta							=> 07040 ate 07087 (&H1B80..&H1BAF)	=> 0047 Bytes
; Tabela de Cores 		=> 08192 ate 14335 (&H2000..&H37FF)	=> 6143 Bytes
; Tabela de Sprites 	=> 14336 ate 16384 (&H3800..&H3FFF) => 2048 Bytes
; =============================================================================

; =============================================================================
; VDP MODO GRAFICO II (SCREEN 2)
; =============================================================================
;	Padrões de azulejos	=> 00000 ate 06143 (&H0000..&17FFH) => 6143 Bytes
; Mapa dos ajulejos		=> 06144 ate 06911 (&H1800..&H1AFF)	=> 0767 Bytes
; Tabela de atributos => 06912 ate 07039 (&H1B00..&H1B7F)	=> 0127 Bytes
; Paleta							=> 07040 ate 07087 (&H1B80..&H1BAF)	=> 0047 Bytes
; Tabela de Cores 		=> 08192 ate 14335 (&H2000..&H37FF)	=> 6143 Bytes
; Tabela de Sprites 	=> 14336 ate 16384 (&H3800..&H3FFF) => 2048 Bytes
; =============================================================================

; =============================================================================
; CORES
; =============================================================================
; 00	0000 transparent		06	0110 dark red						12	1100 dark green
; 01	0001 black					07	0111 cyan								13	1101 magenta
; 02	0010 medium green		08	1000 medium red					14	1110 gray
; 03	0011 light green 		09	1001 light red					15	1111 white
; 04	0100 dark blue			10	1010 dark yellow
; 05	0101 light blue			11	1011 light yellow
; =============================================================================

; =============================================================================
; SPRITE PATTERNS => 256(8X8) OU 64(16X16) PADROES DE PIXELS
; =============================================================================
; SE O BIT DE TAMANHO DE SPRITE = 1 NO REGISTRADOR DO VDP #1, ENTAO OS SPRITES
; SERAO 16X16 SEGUINDO O ESQUEMA ABAIXO,OU SEJA,VOCE PODE TER 256 OU 64 SPRITES
; =============================================================================
; BLOCO A => PRIMEIROS 8 BYTES
; BLOCO B => PROXIMOS 8 BYTES
; BLOCO C => PROXIMOS 8 BYTES
; BLOCO D => PROXIMOS 8 BYTES
; SPRITE FINAL => A,C,B,D
; =============================================================================
VDPDATA:              equ &98
VDPCONTROL:           equ &99
VDPPALLET:						equ &9A
VDPINDIRECT:					equ &9B
ADRPATTERNTBL:				equ 0000
ADRNAMESTBL:					equ 6144
ADRATRIBUTETBL:				equ 6912
ADRPALLETTBL:					equ 7040
ADRCOLORTBL:					equ 8192
ADRSPRITETBL:					equ 14336

; =============================================================================
; Carrega a Tabela de padroes
; =============================================================================
LoadPatternTable:
	ld bc,216            		; bytes a copiar
  ld de,ADRPATTERNTBL     ; tabela de padrões na VRAM
  ld hl,AlieFont	 				; localização na RAM
  call LDIRVM             ; copio a tabela de padrões
ret
; =============================================================================

; =============================================================================
; Carrega a Tabela de sprites
; =============================================================================
LoadSpritesTable:
	ld bc,64              	; bytes a copiar
  ld de,ADRSPRITETBL	    ; tabela de sprites na VRAM
  ld hl,AlieSprites		    ; localização na RAM
  call LDIRVM             ; copio a tabela de sprites
ret
; =============================================================================

; =============================================================================
; SPRITE ATTRIBUTES (4 BYTES)
; =============================================================================
;	Você pode colar até trinta e dois sprites
;	só quatro podem estar presentes na mesma linha horizontal
;	o processador sempre irá desenhá-los uma linha abaixo de onde
;	você realmente mandou
; =============================================================================
; VVVVVVVV					=> POSICAO VERTICAL
; HHHHHHHH					=> POSICAO HORIZONTAL
;	PPPPPPPP					=> NUMERO DO PADRAO (TABELA DE PADROES)
;	E000CCCC					=> EARLY / 000 / COR DO SPRITE
; =============================================================================
; D => posicao Y
; E => posicao X
; B => Numero do sprite
; C => Early / Cor
; =============================================================================
PutSprite:
	; ld a,b
	; sla											; multiplico o numero do sprite por 4
	; sla
	; ld de,ADRATRIBUTETBL+a 	; endereco e igual a base da tabela + resultado
  ; ld bc,4									; a tabela de atributos tem sempre 4 bytes
	; ld hl,CidadePattern
	; call LDIRVM
ret
; =============================================================================

; =============================================================================
; SetScreen2_16x16 - Inicializa os registradores #0 e #1 do VDP
; =============================================================================
SetScreen2_16x16:
	call INIGRP               ; inicia modo grafico 256x192
	ld a,(RG1SAV)             ; leio o valor do registro 1
	and 0xE6                  ; também desligo o zoom dos sprites
	or 2                      ; e ajusto os sprites para 16x16
	ld b,a										; carrego o novo valor para o registrador
	ld c,1										; indico o registrador que vou alterar
	call WRTVDP               ; altero o valor do registro 1
ret
; =============================================================================
; SetColorRegister - Inicializa o registrador #7 do VDP
; =============================================================================
; D => Byte para o Registrador VDP #0 ([T][T][T][T][B][B][B][B])
; =============================================================================
SetColorRegister:
	ld a,d;          					; [T][T][T][T][B][B][B][B]
	out (VDPCONTROL),a				; Cor dos bits no modo texto / Cor do Backdrop
	ld a,128+7								; Registrador 7
	out (VDPCONTROL),a
ret
; =============================================================================

; =============================================================================
; Pegar a posicao na tela para um grafico BMP
; =============================================================================
; B	=> posicao X
; C => posicao Y
; =============================================================================
; Altera => HL (endereco de memoria da coordenada xy),A
; =============================================================================
GetBMPScreenPos:
	push bc
		xor a
		ld h,c
		rr h
		rr a
		or b
		ld l,a
		ld (ScreenLinePos_Plus2-2),hl
		call VDP_SetWriteAddress
	pop bc
ret

GetNextLine:
	push hl
	push bc
	push af
		ld hl,&0000
ScreenLinePos_Plus2:
		ld bc,&0080
		add hl,bc
		ld (ScreenLinePos_Plus2-2),hl
		xor a
		call VDP_SetWriteAddress
	pop af
	pop bc
	pop hl
	ret

VDP_SetReadAddress:
	ld C,0
	jr VDP_SetAddress
VDP_SetWriteAddress:
	ld C,64
VDP_SetAddress:
	rlc     h
  rla
  rlc     h
  rla
  srl     h
  srl     h
  di
  	out (VDPCONTROL),a
  	ld  a,128+14
  	out (VDPCONTROL),a
  	ld  a,l
  	nop
  	out (VDPCONTROL),a
  	ld a,h
  	or C
  ei
  out (VDPCONTROL),a
  ld c,VDPDATA
ret

; =============================================================================
; Pegar a posicao de memoria de uma coordenada XY
; =============================================================================
; B	=> posicao X
; C => posicao Y
; =============================================================================
; Altera => HL (endereco de memoria da coordenada xy),A
; =============================================================================
GetVDPScreenPos:
	push bc
		ld h,0
		ld l,c
		or a
		rl l
		rl h
		rl l
		rl h
		rl l
		rl h
		rl l
		rl h
		rl l
		rl h
		ld a,l
		or b			; or na coordenada x
		ld l,a
		ld a,h
		or &18		; mapa de azulejos começa em &1800
		ld h,a
	pop bc
ret
; =============================================================================

; =============================================================================
; Pegar a posicao da tabela de cores da coordenada xy
; =============================================================================
; As coores pode ser setadas para uma area 8x1
; um byte define cor da frente e cor do background (%FFFFBBBB)
; B	=> posicao x (0-32)
; C => posicao y (0-191)
; =============================================================================
; Altera => HL (endereco de memoria da cor da coordenada xy)
; =============================================================================
GetColorMemPos:
	push af
	push bc
		ld a,c
		and %11111000
		rrca
		rrca
		rrca
		or &20					; a tabela de cores comeca em &2000
		ld h,a
		ld a,b
		and %00011111
		rlca
		rlca
		rlca
		ld b,a
		ld a,c
		and %00000111
		or b
		ld l,a
	pop bc
	pop af
ret
; =============================================================================
