.data 
    CONTROL:       .word 0x10000
    DATA:          .word 0x10008
    CONTRA:        .asciiz 'VAMOO'
    ERROR:         .asciiz ' ERROR!'
    CORRECTO:      .asciiz ' BIENVENIDO'
    MENSAJE:       .asciiz 'INGRESE UNA CONTRA: '
    CARACTER:      .byte 0
.code
    LWU $s0, CONTROL($0)
    LWU $s1, DATA($0)
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0) 
    
    DADDI $sp, $0, 0x400
    JAL CHAR
HALT


CHAR: daddi $t6, $0, 0           ;CONTADOR PARA CARACTERES
    LOOP: DADDI $t1, $0, 9
        SD $t1,0 ($s0)      ; CONTROL = 9

        
        ; *PRESIONA UNA TECLA*
        ; LA CPU GUARDA EL CARACTER EN DATA

        LBU $t1,0 ($s1)

        DADD $t7, $0, $t1       ;MANDO MI CARACTER A UN REGISTRO PARA COMPARAR
        ; GUARDO LA VARIABLE
        SB $t1, CARACTER($0)

        ;TOMO LA DIR DE CARACTER
        DADDI $s3, $0, CARACTER

        ; MANDO DIR DE CARACTER
        SD $s3, 0 ($s1)

        lbu $t5, CONTRA($t6)    ;GUARDO EN T5 EL CARACTER ACTUAL DE CONTRA
        beqz $t5, FIN_BIEN           ; INDICA QUE TERMINO LA CONTRA (QUE TERMINO BIEN)
        BNE $t1, $t5, FIN_MAL

        ; IMPRIMIR CARACTER
        DADDI $t1, $0, 4
        SD $t1, 0 ($s0) ; CONTROL 4
        daddi $t6, $t6, 1           ;AVANZO AL SIGUIENTE CARACTER DE MI CONTRA
        J LOOP

        FIN_BIEN: DADDI $t0, $0, CORRECTO  ;IMPRIMO CORRECTO
            SD $t0, 0($s1)        
            DADDI $t0, $0, 4        
            SD $t0, 0($s0)   
            J FIN
        FIN_MAL: DADDI $t0, $0, ERROR  ;IMPRIMO CORRECTO
            SD $t0, 0($s1)        
            DADDI $t0, $0, 4        
            SD $t0, 0($s0)   
            J FIN

    FIN: JR $ra