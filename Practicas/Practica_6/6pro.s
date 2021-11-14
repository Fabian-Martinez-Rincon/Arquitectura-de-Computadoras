.data
    coorX:      .byte 0
    coorY:      .byte 0
    color:      .byte 0, 0, 0, 0; 
    CONTROL:    .word32 0x10000
    DATA:       .word32 0x10008
    MENSAJE1:   .asciiz "INGRESE X: "
    MENSAJE2:   .asciiz "INGRESE Y: "
    MENSAJE3:   .asciiz "INGRESE (R,G,B,TRANSPARENCIA) : "

.code
    LWU $s6, CONTROL($zero)
    LWU $s7, DATA($zero)
    ;__________________________________
    DADDI $t0, $0, MENSAJE1 
    SD $t0, 0 ($s7) 
    DADDI $t1, $0, 4 
    SD $t1, 0 ($s6) 

    DADDI $t1, $0, 8
    SB $t1, 0($s6) 
    LBU $t2, 0($s7) 
    SB $t2, coorX($0)
    ;__________________________________    
    DADDI $t0, $0, MENSAJE2 
    SD $t0, 0 ($s7) 
    DADDI $t1, $0, 4 
    SD $t1, 0 ($s6) 
    
    DADDI $t1, $0, 8
    SB $t1, 0($s6) 
    LBU $t3, 0($s7) 
    SB $t3, coorY($0)
    ;__________________________________
    DADDI $t0, $0, MENSAJE3
    SD $t0, 0 ($s7)
    DADDI $t1, $0, 4 
    SD $t1, 0 ($s6)

    DADDI $a0, $0, 0    ;CONTADORES PARA LEER
    DADDI $a1, $0, 4
    
    LOOP: DADDI $t1, $0, 8
        SB $t1, 0($s6) 
        LBU $t3, 0($s7) 
        SB $t3, color($a0)
        DADDI $a0, $a0, 1   ;AVANZO AL SIGUIENTE BYTE
    bne $a0, $a1 ,LOOP
    ;__________________________________
    DADDI $t0, $zero, 7
    SD $t0, 0($s6)
    
    LBU $s0, coorX($zero)
    SB $s0, 5($s7)

    LBU $s1, coorY($zero)
    SB $s1, 4($s7)

    LWU $s2, color($zero)
    sw $s2, 0($s7)
    
    DADDI $t0, $zero, 5
    SD $t0, 0($s6)         
HALT