.data
    NROA: .word 1
    NROB: .word 2
    NROC: .word 1
    NROD: .word 0

.code
    ld R1, NROA(R0) 
    ld R2, NROB(R0) 
    ld R3, NROC(R0)
    ld R4, NROD(R0)

    
    bne R1, R2, continuar
    DADDI R4, R4, 2
    bne R1, R3, continuar2
    DADDI R4, R4, 1
    j TERMINAR

    continuar: bne R1, R3, TERMINAR
    DADDI R4, R4, 2
    bne R3, R2, TERMINAR
    DADDI R4, R4, 1
    j TERMINAR

    continuar2: bne R2, R3, TERMINAR
    DADDI R4, R4, 2

    TERMINAR: sd R4, NROD(R0)


    FIN: HALT
