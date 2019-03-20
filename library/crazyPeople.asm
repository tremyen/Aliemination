;  -==============================-
;   Mostrar a tela da Crazy People
;  -==============================-

crazyPeople:
            proc
            local drawScreen
            local waitPressFire
            local screenData

drawScreen:
            ; Preencher a VRAM
            ; Block transfer to VRAM from memory
            ;-================================
            ; BC - blocklength
            ; DE - Start address of VRAM (6144)
            ; HL - start address
            ;-================================
            ld bc,4096
            ld de,backgrn
            ld hl,screenData
            call LDIRVM

            ; Escrever a imagem na tela
            ;-================================
            call WRTVRM

            ; Limpa o buffer do teclado
            ;-================================
            call KILBUF

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
            incbin "gfx/cplogo.scr"

            endp
