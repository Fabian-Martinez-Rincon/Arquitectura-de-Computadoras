.data ;leer desde teclado
    CONTROL:      .word 0x10000
    DATA:         .word 0x10008
    MENSAJE:      .asciiz "INGRESE UN NRO: "
    MENSAJE2:     .asciiz "DEBE INGRESAR UN NRO "
    RES: .word 0
    NRO: .byte 0
    NUMEROS:  .word 0 
    ; 252
.code
    LWU $s0, CONTROL ($0) 	    ; $s0 = CONTROL
    LWU $s1, DATA ($0) 	   	    ; $s1 = DATA
    DADDI $s2, $s2 , 4          ; 4 IMPRIMIR UN STRING
    DADDI $s3, $s3 , 8          ; 8 LEE UN NUMERO
    DADDI $s4, $s4 , MENSAJE
    DADDI $s5, $s5 , MENSAJE2 
    DADDI $s6, $s6 , 2          ; PARA IMPRIMIR UN NUMERO
    DADDI $s7, $s7 , 252 
    ;_______________________________    IMPRIME MENSAJE
    SD $s4, 0($s1)               
    SD $s2, 0($s0)          
    ;_______________________________
    DADDI $sp, $0, 0x400        ; INICIALIZO EL PUNTERO A TOPE DE PILA


    DADDI $t7, $0 , NUMEROS

    DADDI $t5, $0 , 0
    REPETIR: JAL INGRESO   
        DADDI $t8, $0 , 0   inicio
        DADD $t3, $0,$s3
        DADD $t5, $t5,$s3
        SD $t3, 0 ($t7)     ; guardo el resultado en la tabla
        DADDI $t7, $t7, 8


        slt $t8, $t5, $s7
        beqz $t8, FINALIZAR
    J REPETIR

    FINALIZAR: HALT

INGRESO: DADDI $t1, $0, 8   ; LEE UN NRO
    SD $t1,0 ($s0)
    LD $t1,0 ($s1)
    SD $t1, NRO($0)
    ;_______________________________
    DADDI $t9, $t9, 0 
    SLTI $t9, $t1, 0         ; un 1 si es menor
    DADDI $t3, $t3, 9
    SLT $t9, $t3,  $t1         ; un 1 si me paso
    DADDI $t4, $t4 ,1
    BEQ $t9, $t4 , MALO
    ;_______________________________
    ; IMPRIME
    DADD $s3, $0, $t1
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 
    
    J FIN
    ;_______________________________
    
    MALO: SD $s5, 0($s1)              
    SD $s2, 0($s0)  
    DADDI $t6, $0, 0
    SD $t6, NRO($0)
    ;_______________________________  LEE E IMPRIME EL NRO
    FIN: JR $ra



