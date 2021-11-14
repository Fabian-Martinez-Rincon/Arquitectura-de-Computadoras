.data ;leer desde teclado
    CONTROL:      .word 0x10000
    DATA:         .word 0x10008
    MENSAJE:      .asciiz " INGRESE UN CARACTER: "
    MENSAJEMAL:  .asciiz "  EL CARACTER NO ES UN DIGITO. "
    CERO:         .asciiz " CERO  "
    UNO:          .asciiz " UNO   "
    DOS:          .asciiz " DOS   "
    TRES:         .asciiz " TRES  "
    CUATRO:       .asciiz " CUATRO"
    CINCO:        .asciiz " CINCO "
    SEIS:         .asciiz " SEIS  "
    SIETE:        .asciiz " SIETE "
    OCHO:         .asciiz " OCHO  "
    NUEVE:        .asciiz " NUEVE "
    CARACTER: .byte 0
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
    LD $t0, CARACTER($0) 
    SLTI $t1, $t0, 0x30         ; un 1 si es menor
    DADDI $t3, $t3, 0x39
    SLT $t1, $t3,  $t0         ; un 1 si me paso
    DADDI $t4, $t4 ,1
    BEQ $t1, $t4 , MALO
    
    DADDI $a1, $0, CERO
    JAL MUESTRA
    J TERMINO
    
    
    
    MALO: DADDI $t0, $0, MENSAJEMAL  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)   

    TERMINO: HALT


INGRESO: DADDI $sp, $sp, -8 
    SD $t7, 0 ($sp)
    ;______________________________
    DADDI $t1, $0, 9   ; LEE UN CARACTER
    SD $t1,0 ($s0)
    LBU $t1,0 ($s1)
    SB $t1, CARACTER($0)
    ; IMPRIME
    DADDI $s3, $0, CARACTER
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 
    ;_______________________________  LEE E IMPRIME EL CARACTER
    LD $t7, 0 ($sp)
    DADDI $sp, $sp, 8  
    JR $ra

MUESTRA:  daddi $t7,$0,0x30
    LOOP: BEQ $t0, $t7, IMPRIMIR
        DADDI $t0, $t0, -1
        DADDI $a1, $a1, 8
        J LOOP

    IMPRIMIR:  SD $a1, 0($s1)        
    DADDI $t1, $0, 4        
    SD $t1, 0($s0)    
JR $ra