.data ;leer desde teclado
    CONTROL:      .word 0x10000
    DATA:         .word 0x10008
    MENSAJE:      .asciiz " INGRESE UN NUMERO ENTRE EL 0 Y 9: "
    MENSAJEMAL:  .asciiz "  Debe ingresar un numero "
    NUMEROX: .byte 0
;________________________________________________________
.code
    LWU $s0, CONTROL ($0) 	; $s0 = CONTROL
    LWU $s1, DATA ($0) 	   	; $s1 = DATA
    DADDI $s4, $0, 4
    DADDI $s5, $0, MENSAJE
    DADDI $s6, $0, MENSAJEMAL
    DADDI $s6, $0, 8
    ;_______________________________    IMPRIME MENSAJE
    SD $s5, 0($s1)        
    SD $s4, 0($s0)          
    ;_______________________________
    JAL INGRESO
    
    LD $t0, NUMEROX($0) 
    SLTI $t1, $t0, 0         ; un 1 si es menor
    DADDI $t3, $t3, 9
    SLT $t1, $t3,  $t0         ; un 1 si me paso
    DADDI $t4, $t4 ,1
    BEQ $t1, $t4 , MALO
    
    LD $t0, NUMEROX ($0)
    SD $t0, 0 ($s1)         
     ; CONTROL = 2
    DADDI $t0, $0, 2
    SD $t0, 0 ($s0)
    J TERMINO
    
    MALO: SD $s6, 0($s1)              
    SD $s4, 0($s0)   
    TERMINO: HALT

;________________________________________________________
INGRESO: DADDI $t1, $0, 8   ; LEE UN NUMERO
    SD $t1,0 ($s0)
    LBU $t1,0 ($s1)
    SB $t1, NUMEROX($0)
    ; IMPRIME
    DADDI $s3, $0, NUMEROX
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 
    ;_______________________________  LEE E IMPRIME EL NUMEROX
    JR $ra
;________________________________________________________


