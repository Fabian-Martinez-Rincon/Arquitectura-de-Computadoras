.data 
    CONTROL:       .word 0x10000
    DATA:          .word 0x10008
    CLAVE:        .asciiz 'VAMO'
    ERROR:         .asciiz ' ERROR!'
    CORRECTO:      .asciiz ' BIENVENIDO'
    MENSAJE:       .asciiz ' \n INGRESE UNA CLAVE: '
    INGRESADO:      .byte 0,0,0,0
.code
    LWU $s0, CONTROL($0)
    LWU $s1, DATA($0)
    DADDI $s2, $0, 4
    DADDI $s4, $0, 9
    ;______________________________ IMPRIME MENSAJE
    REPETIR: SD $0, INGRESADO($0) 
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 
    ;______________________________
    DADDI $sp, $0, 0x400

    DADDI $a0, $a0, 4       ; CANTIDAD DE DIGITOS A LEER

    DADDI $t9, $0 , 0
    LOOP: beqz $a0, FIN     ; LECTURA DE A UN DIGITO :d
        JAL CHAR
        DADDI $a0, $a0 , -1           ; DECREMENTO MI CONTADOR
    J LOOP

    ;______________________________
    FIN: DADDI $t0, $t0, 4       ; contador para el bucle :D

    DADDI $t3, $0, 0       ;inicializo para recorrer ambos caracteres
    DADDI $t7, $0, 0

    LD $t1, CLAVE($t3)    ; ME MUEVO POR AMBAS CADENAS
    LD $t2, INGRESADO($t3)
    BNE $t1, $t2 , ERRONEO
    DADDI $t0, $t0 , -1
    
    DADDI $t7, $0, 1           ; PARA PASAR LOS PARAMETROS EN CORRECTO
    J CONTINUAR
    
    ERRONEO: DADDI $t7, $0, 0

    CONTINUAR: JAL RESPUESTA
    J REPETIR
    
TERMINO: HALT

CHAR: SD $s4,0 ($s0)                ; CONTROL = 9
        LBU $t1,0 ($s1)               ; *PRESIONA UNA TECLA*
        SB $t1, INGRESADO($t9)        ; GUARDO LA VARIABLE
        DADDI $s3, $t9, INGRESADO     ; TOMO LA DIR DE INGRESADO
        SD $s3, 0 ($s1)               ; MANDO DIR DE INGRESADO
        SD $s2, 0 ($s0)               ; IMPRIMIR INGRESADO , CONTROL 4
        
        DADDI $t9, $t9 , 1            ;AVANZO LA CLAVE
    JR $ra

RESPUESTA: beqz $t7, INCORRECTO

    DADDI $t0, $0, CORRECTO  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 
    J FIN2

    INCORRECTO: DADDI $t0, $0, ERROR  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 

    FIN2: JR $ra