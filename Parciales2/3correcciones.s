.data ;leer desde teclado
    CONTROL:      .word 0x10000
    DATA:         .word 0x10008
    MENSAJE:      .asciiz "INGRESE UN NRO: "
    MENSAJE2:     .asciiz "EL RESULTADO ES: "
    RES: .word 0
    NRO: .byte 0
.code
    LWU $s0, CONTROL ($0) 	; $s0 = CONTROL
    LWU $s1, DATA ($0) 	   	; $s1 = DATA
    DADDI $s2, $s2 , 4      ; 4 IMPRIMIR UN STRING
    DADDI $s3, $s3 , 8      ; 8 LEE UN NUMERO
    DADDI $s4, $s4 , MENSAJE
    DADDI $s5, $s5 , MENSAJE2 
    DADDI $s6, $s6 , 1      ; PARA IMPRIMIR UN NUMERO
    ;_______________________________    IMPRIME MENSAJE
    SD $s4, 0($s1)               
    SD $s2, 0($s0)          
    ;_______________________________
    DADDI $sp, $0, 0x400        ; INICIALIZO EL PUNTERO A TOPE DE PILA
    JAL INGRESO   
    LD $t6, NRO($0)
    ; IMPRIMO EL MENSAJE PARA INGRESAR OTRO NUMERO
    SD $s4, 0($s1)               
    SD $s2, 0($s0)  
    
    JAL INGRESO   
    LD $t7, NRO($0)
    DADD $t6, $t6, $t7
    DADD $a0, $a0, $t6 
    JAL RESULTADO
    HALT

INGRESO: DADDI $sp, $sp, -8 
    SD $t7, 0 ($sp)
    ;______________________________
    DADDI $t1, $0, 8   ; LEE UN NRO
    SD $t1,0 ($s0)
    LBU $t1,0 ($s1)
    SB $t1, NRO($0)
    ; IMPRIME
    DADDI $s3, $0, NRO
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 
    ;_______________________________  LEE E IMPRIME EL NRO
    LD $t7, 0 ($sp)
    DADDI $sp, $sp, 8  
    JR $ra

RESULTADO: SD $s5, 0($s1) ;IMPRIMO EL MENSAJE NORMAL             
    SD $s2, 0($s0)    
    ; IMPRIMO EL RESULTADO
    SD $a0, 0 ($s1)  
    SD $s6, 0 ($s0) 
    JR $ra
