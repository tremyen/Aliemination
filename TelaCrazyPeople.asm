;  -==============================-
;   Mostrar a tela da Crazy People
;  -==============================-

crazyPeople:
            proc
            local logoWait
            local logoData
            local logoLoop
            local logoPrt1
            local logoPrt2

            logoLoop: equ videoData
            logoPrt1: equ videoData+1
            logoPrt2: equ videoData+3

            ld hl,0
            ld (logoPrt1),hl          ; a primeira linha na tela
            ld (logoPrt2),hl          ; a primeira linha na tela

            xor a                     ; zero A
            ld (logoLoop),a           ; zero a posição do laço

            ld bc,768                 ; 768 bytes
            ld hl,6144                ; começando em 6144
            call FILVRM               ; limpo a tela

            ld hl,6144+2*32+9         ; início da parte de cima
            ld (logoPrt1),hl

            ld hl,6144+21*32+9        ; início da parte de baixo
            ld (logoPrt2),hl

            xor a                     ; zero A

logoWait:
            ld hl,JIFFY
            ld (hl),0                 ; zera o timer do VDP

            ld (logoLoop),a           ; salva o valor do contador

            ld bc,14                  ; número de bytes a copiar
            ld de,(logoPrt1)          ; posição na VRAM
            ld hl,logoData            ; posição na RAM

            call LDIRVM               ; copia a parte superior

            ld bc,14                  ; número de bytes a copiar
            ld de,(logoPrt2)          ; posição na VRAM
            ld hl,logoData+14         ; posição na RAM

            call LDIRVM               ; copia a parte inferior

            ld de,32                  ; meu incremento/decremento

            ld hl,(logoPrt1)          ; recupera a posição atual
            add hl,de                 ; uma linha abaixo + um caracter
            ld (logoPrt1),hl          ; armazena a nova posição

            ld hl,(logoPrt2)          ; recupera a posição atual
            sbc hl,de                 ; uma linha acima - um caracter
            ld (logoPrt2),hl          ; armazena a nova posição

            ld hl,vdpCycle1
            ld b,(hl)                   ; pega intervalo de temporização
            sra b                       ; divido por dois
            call waitASec               ; espero um pouquinho

            ld a,(logoLoop)           ; recupera o contador
            inc a                       ; incrementa o contador

            cp 10
            jr nz,logoWait            ; se A<10, volta o laço

            xor a                       ; apaga o rastro do logotipo
            ld bc,288                   ; comprimento de 288 bytes
            ld hl,6144+2*32             ; posição inicial
            call FILVRM

            xor a                       ; zera A
            ld bc,288                   ; comprimeiro de 288 bytes
            ld hl,6144+13*32            ; posição inicial
            call FILVRM

            jp gplMensaWait            ; economizo meu código :)

logoData:
            db 01,02,00,00,00,00,03     ; primeira linha do logo
            db 00,00,00,00,03,00,00

            db 04,05,06,07,08,09,10     ; segunda linha do logo
            db 11,12,13,14,15,16,17

            endp
