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
    ;_______________________________    IMPRIME MENSAJE
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)          
    ;_______________________________
    DADDI $sp, $0, 0x400        ; INICIALIZO EL PUNTERO A TOPE DE PILA

    JAL INGRESO   

    LD $t6, NRO($0)
    

    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0) 
    
    JAL INGRESO   
    LD $t7, NRO($0)
    
    DADD $t6, $t6, $t7
    

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

RESULTADO: DADDI $t0, $0, MENSAJE2  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)    

    DADDI $t6, $t6 , 0x30   ; PARA IMPRIMIR EL ASCII DEL NRO
    SD $t6, RES ($0)  

    DADDI $s3, $0, RES
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 

    JR $ra
