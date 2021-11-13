.data
    n1:    .double 	9.13 
    n2:    .double 	6.58 
    res1:  .double 	0.0 
    res2:  .double 	0.0 

.code 
    L.D F1, n1 (R0)     ; F1 = n1
    L.D F2, n2 (R0)     ; F2 = n2
    ADD.D F3, F2, F1    ; F3 = F2 + F1
    MUL.D F4, F2, F1    ; F4 = F2 * F1
    S.D F3, res1 (R0)   ; Guarda la suma en res1
    S.D F4, res2 (R0)   ; Guarda la multiplicacion en res2
HALT
