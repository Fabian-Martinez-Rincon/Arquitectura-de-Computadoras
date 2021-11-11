.data
    TABLA: .word 1,2,3,4,5,6,7,8,9,10
    X: .word 6
    CANT: .word 0
    RES: .word 0

.code
    DADDI R10, R0, -8
    DADDI R11, R0, 80
    LD R1, X(R0)
    DADDI R4, R0, 1
    LD R5, CANT(R0)

    LOOP: DADDI R10, R10, 8
        BEQ R10, R11, FIN
        LD R2, TABLA(R10)
        SLT R3, R1, R2
        BNE R3, R4, LOOP
        DADDI R5, R5, 1
        SD R4, RES(R10)
        j LOOP
    FIN: SD R5, CANT(R0)
    HALT