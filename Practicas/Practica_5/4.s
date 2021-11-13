.data
    PESO:       .double 9000.0
    ALTURA:     .double 2.0
    IMG:        .double 0
    INFRAPESO:  .double 18.5
    NORMAL:     .double 25.0
    SOBREPESO:  .double 30.0
    ESTADO:     .word 0
.code
    L.D F1, PESO(R0)
    L.D F2, ALTURA(R0)
    L.D F5, ESTADO(R0)

    L.D F20, INFRAPESO(R0)
    L.D F21, NORMAL(R0)
    L.D F22, SOBREPESO(R0)


    MUL.D F4, F2, F2    ; ALTURA ^ 2 

    DIV.D F3, F1, F4    ; PESO / ALTURA ^ 2 
    
    S.D F3, IMG(R0)

    C.LT.D F3, F20      ; IMG < 18,5
    BC1F CONTINUAR
    DADDI R5, R0, 1
    SD R5, ESTADO(R0)
    J FIN

    CONTINUAR: C.LT.D F3, F21 ;   18,5 <= IMG  < 25
    BC1F CONTINUAR2
    DADDI R5, R0, 2
    SD R5, ESTADO(R0)
    J FIN

    CONTINUAR2: C.LT.D F3, F22 ; 25 <= IMG  < 30
    BC1F CONTINUAR3
    DADDI R5, R0, 3
    SD R5, ESTADO(R0)
    J FIN

    CONTINUAR3: DADDI R5, R0, 4         ; OBESO
    SD R5, ESTADO(R0)

    FIN: HALT