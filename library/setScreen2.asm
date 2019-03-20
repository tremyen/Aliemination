;-=======================-
; Entrar em modo screen 2
; Manoel Neto 20/3/2019
;-=======================-
setScreen2:
            proc
            LD HL,0x0101
          	LD (BAKCLR),HL
          	LD A,2
            call CHGMOD
          	LD A,(RG1SAV)
          	OR 2
          	LD B,A
          	LD C,1
            call WRTVDP
            ret
            endp
