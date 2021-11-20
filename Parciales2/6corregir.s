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
    DADDI $s0, $s0, 4           ; PARA IMPRIMIR UN STRING
    DADDI $s1, $s1, 8           ; LEER UN ENTERO DESDE TECLADO
    DADDI $s2, $s2, 7           ; LIMPIAR LA PANTALLA
    DADDI $s3, $s3, 5           ; PINTAR UN PIXEL

    ;__________________________________
    DADDI $t0, $0, MENSAJE1 
    SD $t0, 0 ($s7) 
    SD $s0, 0 ($s6) 

    SB $s1, 0($s6) 
    LBU $t2, 0($s7) 
    SB $t2, coorX($0)
    ;__________________________________    
    DADDI $t0, $0, MENSAJE2 
    SD $t0, 0 ($s7) 
    SD $s0, 0 ($s6) 

    SB $s1, 0($s6) 
    LBU $t3, 0($s7) 
    SB $t3, coorY($0)
    ;__________________________________
    
    DADDI $a0, $0, 4    ;CONTADORES PARA LEER
    DADDI $t0, $0, 0
    LOOP: DADDI $t1, $0, MENSAJE3
        SD $t1, 0 ($s7)
        SD $s0, 0 ($s6)

        SB $s1, 0($s6) 
        LBU $t3, 0($s7) 
        SB $t3, color($t0)
        DADDI $t0, $t0, 1
        DADDI $a0, $a0, -1   ;AVANZO AL SIGUIENTE BYTE
    bnez $a0,LOOP
    ;__________________________________

    SD $s2, 0($s6)      ; LIMPIO LA PANTALLA
    
    LBU $s0, coorX($zero)
    SB $s0, 5($s7)

    LBU $s1, coorY($zero)
    SB $s1, 4($s7)

    LWU $s2, color($zero)
    sw $s2, 0($s7)
    
    SD $s3, 0($s6)       ; IMPRIMIR EL CARACTER
HALT
