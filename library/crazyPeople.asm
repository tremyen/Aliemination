;  -==============================-
;   Mostrar a tela da Crazy People
;  -==============================-

crazyPeople:
            proc
            local drawScreen
            local waitPressFire
            local screenData

            ld bc,32768                 ; a imagem com o logotipo do jogo
            ld de,6144+4*32             ; na 4ª linha da tela
            ld hl,screenData
            call LDIRVM                 ; copio para a VRAM

drawScreen:
            call WRTVRM
            call KILBUF                 ; limpo o buffer do teclado

waitPressFire:
            ld hl,JIFFY
            ld (hl),0                   ; zero o temporizador
            ld hl,vdpCycle1
            ld b,(hl)
            call waitASec               ; aguardo 1/10s
            xor a
            call GTTRIG                 ; lê a barra de espaços
            ld h,a                      ; salva o valor em H
            ld a,1
            call GTTRIG                 ; lê o botão 1 do joystick 0
            or h                        ; junta as duas leituras
            cp 255                      ; ainda é 255?
            ret z                       ; sai da laço
            jr waitPressFire

screenData:
            ; --- Slot 0
            ; color 1
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000100b
            DB 00001110b
            DB 00000100b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000100b
            DB 00001011b
            DB 00000001b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00000000b
            DB 00100000b
            DB 01110000b
            DB 00100000b
            DB 00000000b
            DB 10000000b
            DB 00000000b
            DB 00000000b
            DB 10010000b
            DB 01100000b
            DB 00100000b
            DB 00000000b
            DB 00000000b
            ; color 11
            DB 00000000b
            DB 00001111b
            DB 00011111b
            DB 00011111b
            DB 00111011b
            DB 00110001b
            DB 01111011b
            DB 01111111b
            DB 11111111b
            DB 01111111b
            DB 01111111b
            DB 00111011b
            DB 00110100b
            DB 00011110b
            DB 00011111b
            DB 00001111b
            DB 00000000b
            DB 11110000b
            DB 11111000b
            DB 11111000b
            DB 11011100b
            DB 10001100b
            DB 11011110b
            DB 11111110b
            DB 01111111b
            DB 11111110b
            DB 11111110b
            DB 01101100b
            DB 10011100b
            DB 11011000b
            DB 11111000b
            DB 11110000b

            endp
