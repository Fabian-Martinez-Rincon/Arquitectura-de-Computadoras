.data 
    CONTROL:       .word 0x10000
    DATA:          .word 0x10008
    CLAVE:        .asciiz 'VAMO'
    ERROR:         .asciiz ' ERROR!'
    CORRECTO:      .asciiz ' BIENVENIDO'
    MENSAJE:       .asciiz 'INGRESE UNA CLAVE: '
    INGRESADO:      .byte 0,0,0,0
.code
    LWU $s0, CONTROL($0)
    LWU $s1, DATA($0)
    DADDI $s2, $s2, 4
    DADDI $s4, $s4, 9
    ;______________________________ IMPRIME MENSAJE
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 
    ;______________________________
    DADDI $sp, $0, 0x400

    DADDI $a0, $a0, 4       ; CANTIDAD DE DIGITOS A LEER

    LOOP: beqz $a0, FIN 
        JAL CHAR
        DADDI $a0, $a0 , -1           ; DECREMENTO MI CONTADOR
    J LOOP

    FIN: DADDI $t0, $t0, 4       ; contador para el bucle :D

    DADDI $t3, $t3, 0       ;inicializo para recorrer ambos caracteres

    loopComparar: LD $t1, CLAVE($t3)    ; ME MUEVO POR AMBAS CADENAS
        LD $t2, INGRESADO($t3)
        BNE $t1, $t2 , INCORRECTO
        DADDI $t0, $t0 , -1
        DADDI $t3, $t3 , 1
    beqz $t0, loopComparar

    DADDI $t0, $0, CORRECTO  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 
    J TERMINO

    INCORRECTO: DADDI $t0, $0, ERROR  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 
TERMINO: HALT

CHAR:  SD $s4,0 ($s0)                ; CONTROL = 9
        LBU $t1,0 ($s1)               ; *PRESIONA UNA TECLA*
        SB $t1, INGRESADO($t9)        ; GUARDO LA VARIABLE
        DADDI $s3, $t9, INGRESADO     ; TOMO LA DIR DE INGRESADO
        SD $s3, 0 ($s1)               ; MANDO DIR DE INGRESADO
        SD $s2, 0 ($s0)               ; IMPRIMIR INGRESADO , CONTROL 4
        DADDI $t9, $t9 , 1            ;AVANZO LA CLAVE
        JR $ra
