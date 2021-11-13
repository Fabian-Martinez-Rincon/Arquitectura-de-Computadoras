#11) Escribir una subrutina que reciba como argumento una tabla de números terminada en 0.
#La subrutina debe contar la cantidad de números que son impares en la tabla, esta condición se debe verificar usando una subrutina es_impar.
#La subrutina es_impar debe devolver 1 si el número es impar y 0 si no lo es.
.data 
    tabla: .word 1,2,3,4,5,6,7,8,9,10,0
    resultado: .word 0
    mascara: .byte 00000001

.code
    daddi $sp, $0, 0x400
    ld $a0, tabla($zero) 
    jal cant_imp
    sd $v1, resultado($zero)
halt 

cant_imp: daddi $sp,$sp,-8 
    sd $ra , 0($sp)

    daddi $t3,$t3,0 # seteado en 0 Desplazador 
    lazo: beqz $a0,finalizar 
        jal es_impar
        dadd $v1,$v1,$v0
        daddi $t3,$t3,8 
        ld $a0,tabla($t3) 
    j lazo 
    finalizar: ld $ra,0($sp)
jr $ra 

es_impar: ld $s0,mascara($zero)
    and $t2,$a0,$s0
    beqz $t2 ,par 
    daddi $v0,$zero, 1
    j fin 
    par: daddi $v0,$zero, 0
fin: jr $ra 







.data 
    TABLA: .word 1,2,3,4,5,6,7,8,9,10,0
    IMPARES: .word 0
    MASCARA: .byte 00000001

.code
    daddi $sp, $0, 0x400
    ld $a0, TABLA($zero) 
    jal CANT_IMPARES
    sd $v1, IMPARES($zero)
halt 

CANT_IMPARES: daddi $sp,$sp,-8 
    sd $ra , 0($sp)

    daddi $t3,$t3,0                  # seteado en 0 Desplazador 
    lazo: beqz $a0,TERMINO 
        jal ES_IMPAR
        dadd $v1,$v1,$v0
        daddi $t3,$t3,8 
        ld $a0,TABLA($t3) 
    j lazo 
    TERMINO: ld $ra,0($sp)
jr $ra 

ES_IMPAR: ld $s0,MASCARA($zero)
    and $t2,$a0,$s0
    beqz $t2 ,par 
    daddi $v0,$zero, 1
    j fin 
    par: daddi $v0,$zero, 0
fin: jr $ra     