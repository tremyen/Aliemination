; =============================================================================
; TMS9918.ASM
; =============================================================================
; (C) 2019 Manoel Neto - tremyen@gmail.com
; Biblioteca para uso do VDP do MSX 1
; =============================================================================
; The VDP has 8 control registers (0-7) and one status register.
;
; Control Registers
; -----------------
; Reg/Bit		7			6			5			4			3			2			1			0
; 0					-			-			-			-			-			-			M2		EXTVID
; 1					4/16K	BL		GINT	M1		M3		-			SI		MAG
; 2					-			-			-			-			PN13	PN12	PN11	PN10
; 3					CT13	CT12	CT11	CT10	CT9		CT8		CT7		CT6
; 4					-			-			-			-			-			PG13	PG12	PG11
; 5					-			SA13	SA12	SA11	SA10	SA9		SA8		SA7
; 6					-			-			-			-			-			SG13	SG12	SG11
; 7					TC3		TC2		TC1		TC0		BD3		BD2		BD1		BD0
;
; Status Register
; ---------------
;	7		6		5		4		3		2		1		0
;	INT	5S	C		FS4	FS3	FS2	FS1	FS0
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
; APENAS 32 EXIBIDOS NA TELA
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

; =============================================================================
; PORTAS DO VDP
; =============================================================================
VDPDATA:              equ &98
VDPCONTROL:           equ &99
VDPPALLET:						equ &9A
VDPINDIRECT:					equ &9B
; =============================================================================

; =============================================================================
; ENDERECOS DAS TABELAS DO VDP
; =============================================================================
ADRPATTERNTBL:				equ 0000
ADRNAMESTBL:					equ 6144
ADRATRIBUTETBL:				equ 6912
ADRPALLETTBL:					equ 7040
ADRCOLORTBL:					equ 8192
ADRSPRITETBL:					equ 14336
; =============================================================================

; =============================================================================
; LoadSpritesTable
; =============================================================================
; Carrega a Tabela de sprites
; =============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera
; Nada
; =============================================================================
LoadSpritesTable:
	push bc
	push de
	push hl
		ld bc,192             	; bytes a copiar
  	ld de,ADRSPRITETBL	    ; tabela de sprites na VRAM
  	ld hl,AlieSprites		    ; localização na RAM
  	call LDIRVM             ; copio a tabela de sprites
	pop hl
	pop de
	pop bc
ret
; =============================================================================

; =============================================================================
; PutSprite
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
; Parametros
; A => Numero do Sprite na tabela de atributos
; D => posicao Y
; E => posicao X
; B => Numero do sprite na tabela de sprites
; C => Early / Cor
; =============================================================================
; ALTERA
; Nada
; =============================================================================
PutSprite:
		push hl
		push af
			push de										; salvo o valor de DE pq CALATR o altera
				call CALATR							; pega o endereco do sprite na TBL de atributos
			pop de										; retorno DE
			ld a,d
			call WRTVRM								; gravo a posicao Y
			inc hl										; proximo endereco
			ld a,e
			call WRTVRM								; gravo a posicao X
			inc hl										; proximo endereco
			ld a,b
			call WRTVRM								; Gravo o numero na tabela de padroes
			inc hl										; proximo endereco
			ld a,c
			call WRTVRM								; gravo Early / Color
		pop af
		pop hl
ret
; =============================================================================

; =============================================================================
; ReadSprite
; =============================================================================
; Transfere os dados do sprite da VRAM para os registradores
; =============================================================================
; Parametros
; A => Numero do Sprite na tabela de atributos
; =============================================================================
; Altera
; D => posicao Y
; E => posicao X
; B => Numero do sprite na tabela de sprites
; C => Early / Cor
; =============================================================================
ReadSprite:
	push af
		call CALATR								; pega o endereco do sprite na TBL de atributos
		call RDVRM								; le a posicao Y
		ld d,a										; salva em D
		inc hl										; proximo endereco
		call RDVRM								; le a posicao X
		ld e,a										; salva em E
		inc hl										; proximo endereco
		call RDVRM								; le o numero do sprite na tabela de sprites
		ld b,a 										; salva em B
		inc hl										; proximo endereco
		call RDVRM								; Le Early / Color
		ld c,a										; salva em C
	pop af
ret

; =============================================================================
; RemoveSprite
; =============================================================================
;	Remover um sprite da tabela de atributos. Um sprite eh representado por
; 4 bytes a partir de sua posicao na tabela de atributos.
; =============================================================================
; VVVVVVVV					=> POSICAO VERTICAL
; HHHHHHHH					=> POSICAO HORIZONTAL
;	PPPPPPPP					=> NUMERO DO PADRAO (TABELA DE PADROES)
;	E000CCCC					=> EARLY / 000 / COR DO SPRITE
; =============================================================================
; Parametros
; A => Numero do Sprite na tabela de atributos
; =============================================================================
; ALTERA
; Zera o sprite na tabela de atributos
; =============================================================================
RemoveSprite:
	push hl
	push af
		push de								; salvo o valor de DE pq CALATR o altera
			call CALATR					; pega o endereco do sprite na TBL de atributos
		pop de								; retorno DE
		xor a 								; zero o acumulador
		call WRTVRM						; zero a posicao Y
		inc hl								; proximo endereco
		call WRTVRM						; zero a posicao X
		inc hl								; proximo endereco
		call WRTVRM						; zero o numero na tabela de padroes
		inc hl								; proximo endereco
		call WRTVRM						; zero Early / Color
	pop af
	pop hl
ret

; =============================================================================
; SetScreen2_16x16
; =============================================================================
; Inicializa os registradores #0 e #1 do VDP
; =============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera
; Nada
; =============================================================================
SetScreen2_16x16:
	push af
	push bc
		call INIGRP               ; inicia modo grafico 256x192
		ld a,(RG1SAV)             ; leio o valor do registro 1
		and 0xE6                  ; também desligo o zoom dos sprites
		or 2                      ; e ajusto os sprites para 16x16
		ld b,a										; carrego o novo valor para o registrador
		ld c,1										; indico o registrador que vou alterar
		call WRTVDP               ; altero o valor do registrador 1
	pop bc
	pop af
ret
; =============================================================================

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

; =============================================================================
; ReadVDPStatus
; =============================================================================
; Pegar o contedo do registrador de STATUS do VDP
; =============================================================================
; Status Register #0
; 7				F		Vertical scan interrupt flag
; 6				5S	Flag do quinto sprite (SCREEN 1 and 2)
; 5				C		Flag de colisao
; 4 to 0	5SN	Number of the 5th sprite (SCREEN 1 and 2)
;
; * 5,6 e 7 sao resetados quando o registrador e lido ou o VDP Resetado
; * O registrador deve ser lido apenas quando o VDP interrupt esta pendente
; =============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera
; A => Status do VDP
; =============================================================================
ReadVDPStatus:
	ld a,(STATFL)         ; le os flags de status do VDP
ret
; =============================================================================

; =============================================================================
; PauseVDP
; =============================================================================
; Parametros
; B => Numero de ciclos de pausa
; =============================================================================
; Altera => A
; =============================================================================
PauseVDP:
  ld a,(JIFFY)									; pega o contador de ciclos
  cp b													; compara com o padrao
  ret z                         ; sai da rotina
jr PauseVDP
; =============================================================================
