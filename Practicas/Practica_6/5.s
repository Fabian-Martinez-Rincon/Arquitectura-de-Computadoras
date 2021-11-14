.data ;leer desde teclado
    CONTROL:    .word 0x10000
    DATA:       .word 0x10008
    BASE:       .double 0.0
    EXPONENTE:       .word 0
    MENSAJE:    .asciiz "BASE (FLOTANTE): "
    MENSAJE2:    .asciiz "EXPONENTE (ENTERO): "
    RES: .double 0
    UNO: .double 1.0

.code
    LWU $s0, CONTROL ($zero) 	; $s0 = CONTROL
    LWU $s1, DATA ($zero) 	   	; $s1 = DATA

    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)   

    DADDI $t0, $zero, 8
    SD $t0, 0 ($s0)             ; CONTROL = 8
    L.D f1, 0 ($s1)             ; Tomo número en f1
    S.D f1, BASE ($zero)        ; Guardo en variable

    DADDI $t0, $0, MENSAJE2  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)   

    DADDI $t0, $zero, 8
    SD $t0, 0 ($s0)                 ; CONTROL = 8
    LD $t1, 0 ($s1)                 ; Tomo número en t0
    SD $t1, EXPONENTE ($zero)       ; Guardo en variable

    JAL POTENCIA
    S.D f2, RES($0)
  
    S.D f2, 0 ($s1)
    ; Control 3
    DADDI $t0, $0, 3
    SD $t0, 0 ($s0)               
HALT

POTENCIA: L.D f2, UNO($0)
    LOOP: BEQZ $t1, FIN
        mul.d f2, f2, f1
        DADDI $t1, $t1, -1    
    J LOOP

    FIN: jr $ra