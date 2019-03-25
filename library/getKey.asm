;===============================================================
getKey:
;===============================================================
;Outputs:
;     A is a value from 0 to 56 that is the keypress
;    HL is not modified
;    BC is not modified
;Destroys:
;    D
;    E is destroyed if no keys are pressed, else it is also the keypress
;===============================================================
     ld de,$7FFF
KeyLoop:
     rlc d
     ld a,d
     out (1),a
     sub 7Fh
     ret z
     ld a,e
     add a,8
     ld e,a
     in a,(1)
     inc a
     jr z,KeyLoop
     dec a
       inc e
       rra
       jr c,$-2
     ld a,e
     ret
