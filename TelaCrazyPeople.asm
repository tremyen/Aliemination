;  -==============================-
;   Mostrar a tela da Crazy People
;  -==============================-

telaCrazyPeople:
            proc
            local drawScreen
            local waitPressFire
            local changeToNextLine
            local screenData

            ld bc,160                   ; a imagem com o logotipo do jogo
            ld de,6144+4*32             ; na 4a linha da tela
            ld hl,screenData
            call LDIRVM                 ; copio para a VRAM
            ld a,166                    ; insiro o "for MSX"
            ld hl,6144+9*32+18          ; posicao na VRAM

drawScreen:
            call WRTVRM
            inc a                       ; incremento A
            inc hl                      ; incremento a posicao
            cp 173                      ; eh 173?
            call z,changeToNextLine     ; mudo de linha
            cp 177                      ; eh 177?
            jr nz,drawScreen            ; se nao for volto ao lasso
            ld bc,64                    ; o texto "APERTE ESPACO PARA INICIAR"
            ld de,6144+11*32            ; na 11A linha da tela
            ld hl,screenData+160
            call LDIRVM                 ; copio para a VRAM
            ld bc,128                   ; o texto "ORIGINAL ... WORKS"
            ld de,6144+15*32            ; na 15a linha da tela
            ld hl,screenData+160+64
            call LDIRVM                 ; copio para a VRAM
            call KILBUF                 ; limpo o buffer do teclado
waitPressFire:
            ld hl,JIFFY
            ld (hl),0                   ; zero o temporizador
            ld hl,vdpCycle1
            ld b,(hl)
            call waitASec               ; aguardo 1/10s
            xor a
            call GTTRIG                 ; le a barra de espacos
            ld h,a                      ; salva o valor em H
            ld a,1
            call GTTRIG                 ; le o botao 1 do joystick 0
            or h                        ; junta as duas leituras
            cp 255                      ; ainda e 255?
            ret z                       ; sai da lasso
            jr waitPressFire

changeToNextLine:
            ld hl,6144+10*32+21
            ret

screenData:
            incbin "screen.inc"
            endp
