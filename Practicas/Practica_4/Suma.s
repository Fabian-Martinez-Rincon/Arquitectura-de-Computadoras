.data
    NUM1: .word 5
    NUM2: .word 8
    RES:  .word 0

.code
    LD R1, NUM1 (R0)
    LD R2, NUM2 (R0)

    ;MULTIPLICAMOS 
    DMUL R3, R1, R2

    ;ALMACENAMOS EL RESULTADO EN RES
    SD R3, RES (R0)

HALT

