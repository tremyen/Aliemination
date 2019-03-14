;===================================
; Divide
;===================================
;
;Inputs:
;    A=divisor
;    C=dividend
;
;Outputs:
;    B=A/C
;    A=A%C    (the remainder)
;

Divide:
 Ld B,0
DivLoop:
 sub A,C
 jr c,DivEnd
 inc B
 jr DivLoop

DivEnd:
 add a,c
 ret
