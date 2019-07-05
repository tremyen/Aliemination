;-===============================================-
; Desenha a nave cuida da alternância de quadros
;-===============================================-

drawShip:
            proc
            local drawShipNext

            ld a,(shipY)                ; pego a posição da nave             
            ld b,a
            ld a,(shipFrame)            ; pego o quadro correspondente a posição
            sla a
            sla a
            sla a
            sla a                       ; multiplico por 16 (4x SHIFT LEFT)
            ld c,a                      ; armazeno em C
            ld hl,shipBuffer            ; aponto para o frame buffer
            ld a,0                      ; zero A

drawShipNext:
            ld (hl),b                   ; atualizo a posição Y
            inc hl
            inc hl                      ; avanço para a próxima posição
            ld (hl),c                   ; atualizo o sprite
            inc c
            inc c
            inc c                       ; não existe "add c,4"
            inc c                       ; é feio mas assim faço C=C+4
            inc hl
            inc hl                      ; avanço para a próxima posição
            inc a
            cp 4
            jr nz,drawShipNext          ; se A!=4, ir para drawBird
            ld a,(shipFrame)
            inc a
            and 3
            ld (shipFrame),a            ; atualizo o frame, a animação tem 4

            ld bc,16
            ld de,6912
            ld hl,shipBuffer
            call LDIRVM                 ; jogo estes 16 bytes na VRAM

            ret                         ; sai da rotina

            endp
