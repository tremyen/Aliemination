;  -==============================-
;   Mostrar a tela da Crazy People
;  -==============================-

crazyPeople:
            proc
            local logoData
            local areaDeSprites

            areaDeSprites: equ videoData+1

            ; Carrego o sprite na memoria de video
            ld bc,64                    ; número de bytes a copiar
            ld de,(areaDeSprites)       ; posição na VRAM
            ld hl,logoData              ; posição na RAM

            ;Defino os paremetros do putSprite
            ld b,3                      ; B — a camada do sprite;
            ld hl,120                   ; HL — a coordenada X do sprite;
            ld a,72                     ; A — a coordenada Y do sprite;
            ld d,1                      ; D — a cor do sprite e
            ld e,0                      ; E — o padrão do sprite.

            ;Chamo o putSprite
            call putSprite

            include "library/putSprite.asm"

loop:
            jr loop

logoData:
            ; --- Slot 0
            ; color 1
            DB $00,$00,$00,$00,$04,$0E,$04,$00
            DB $00,$00,$00,$04,$0B,$01,$00,$00
            DB $00,$00,$00,$00,$20,$70,$20,$00
            DB $80,$00,$00,$90,$60,$20,$00,$00
            ; color 11
            DB $00,$0F,$1F,$1F,$3B,$31,$7B,$7F
            DB $FF,$7F,$7F,$3B,$34,$1E,$1F,$0F
            DB $00,$F0,$F8,$F8,$DC,$8C,$DE,$FE
            DB $7F,$FE,$FE,$6C,$9C,$D8,$F8,$F0

            endp
