;  -=========================-
;   inicializa o ambiente msx
;  -=========================-

initEnv:
proc
  local palAdjust
  local noPalAdjust

  call turboR             ; e um turbo R? pare de sofrer!
  call BEEP               ; bipo (e zero os registros do PSG)
  call DISSCR             ; desligo a exibição da tela
  ld a,(JIFFY+1)          ; inicializo a semente do meu gerador
  ld (rndSeed),a          ; de números pseudo-aleatórios
  ld a,(0x002b)           ; leio a versão do MSX na ROM
  bit 7,a                 ; se o bit 7 for 1 é 50Hz senão é 60Hz
  jr z, noPalAdjust       ; sendo 0 eu sigo adiante

palAdjust:
  ld a,PAL                ; defino o novo valor para PAL
  ld (vdpCycle1),a        ; o valor para 1/10s em PAL
  ld a,PAL*10             ; 1/10*10=1, certo?
  ld (vdpCycle5),a        ; o valor é o de 1s em PAL

noPalAdjust:
  xor a                   ; A=0
  ld (CLIKSW),a           ; desligo o click das teclas e
  call ERAFNK             ; desligo as teclas de função

  ; Definicao das cores da tela
  ;-=========================-
  ; 0-transparente
  ; 1 - negro
  ; 2 - verde
  ; 3 - verde claro
  ; 4 - azul escuro
  ; 5 - azul claro
  ; 6 - vermelho escuro
  ; 7	- azul celeste
  ; 8  - vermelho
  ; 9  - vermelho claro
  ;10 - amarelo escuro
  ;11 - amarelo claro
  ;12 - verde escuro
  ;13 - magenta
  ;14 - cinza
  ;15	- branco
  ;-=========================-
  ld a,15                 ;
  ld (FORCLR),a           ; cor da frente em branco
  ld a,2                  ;
  ld (BAKCLR),a           ; Cor do fundo
  ld a,0                  ;
  ld (BDRCLR),a           ; Cor da borda
  call CHGCLR             ; agora mudo as cores da tela

  ;Entro no modo screen
  ;-=========================-
  call setScreen2         ; modo grafico
  call ENASCR             ; religo a tela
  ret                     ; sai da rotina

endp
