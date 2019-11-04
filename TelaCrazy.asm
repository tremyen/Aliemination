; =============================================================================
;  Desenhar a tela da Crazy People
; =============================================================================
;  (C) 2019 Manoel Neto - tremyen@gmail.com
; =============================================================================
TelaCrazy:
  call DISSCR                 ; desligo a tela
    ld de,0                   ; Base da memoria da VRAM
    ld hl,Cenario+7           ; os primeiros 7 bytes sao cabecalho
    ld bc,15360               ; tamanho da BMP
    call LDIRVM               ; copio para a VRAM
  call ENASCR                 ; ligo a tela
TelaCrazyLoop:
  call CHGET                  ; recebo um caracter
  cp 13                       ; espero enter
  jr z,SairTelaCrazy          ; se foi enter, va para proxima tela
  jr TelaCrazyLoop            ; espere por enter
SairTelaCrazy:
ret
; =============================================================================
