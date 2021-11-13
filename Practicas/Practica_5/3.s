.data
    BASE:    .double 13.47 
    ALTURA:  .double 5.85
    RES:     .double 0.0 
.code 
    L.D F1, BASE (R0)     ; F1 = BASE
    L.D F2, ALTURA (R0)   ; F2 = ALTURA
    MUL.D F5, F2, F1      ; F5 = F2 * F1 
    DADDI R2, R0, 2
    MTC1 R2, F4
    CVT.D.L F4, F4  
    DIV.D F3, F5, F4      ; BASE * ALTURA / 2
    S.D F3, RES (R0)      ; Guarda RES
HALT


