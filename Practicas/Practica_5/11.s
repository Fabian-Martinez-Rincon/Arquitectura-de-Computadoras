.data
    TABLA: .word 1,2,3,4,5,0
    IMPARES: .word 0
    MASCARA: .byte 00000001
.code
    DADDI $sp, $0, 0x400
    DADDI $a0, $0, TABLA
    DADD $v0, $0, $0 
    
    JAL CONT_IMPAR
    sd $v0,IMPARES($0)
HALT

CONT_IMPAR: DADDI $sp, $sp, -16     
    SD $ra, 0 ($sp)                  
    SD $s0, 8 ($sp)
    DADD $s0, $a0, $0  
    
    LOOP: LD $a0, 0 ($s0)	        ; Toma nro. actual
        BEQ $a0, $0, FIN            ; Si es el fin, termina
        JAL ESIMPAR
        dadd $v0,$v0,$v1
        DADDI $s0, $s0, 8           ; Avanza al siguiente nro
    J LOOP

    FIN: LD $ra, 0 ($sp)
        LD $s0, 8 ($sp)
        DADDI $sp, $sp, 16
        JR $ra

ESIMPAR: LD $s1,MASCARA($0)      ;inicializo la mascara(como constante)
    AND $t1, $a0, $s1            ;valor actual and mascara
    BEQZ $t1 ,PAR 
    DADDI $v1,$0, 1
    J TERMINO
    PAR: DADDI $v1, $0, 0     
    TERMINO: JR $ra                  