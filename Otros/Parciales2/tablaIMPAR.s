.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    A: .word 0
    B: .word 0
    C: .word 0
    RESUL: .word 0
    MENSAJE:      .asciiz " INGRESE UN NUMERO: "

.code
    LD $s0, CONTROL ($0)    
    LD $s1, DATA ($0)
    DADDI $s2, $s2, 2           ; MOSTRAR ENTERO
    DADDI $s3, $s3, 4           ; IMPRIMIR
    DADDI $s4, $s4, MENSAJE
    DADDI $s5, $s5, 8           ; LEER

            daddi $t0, $0, 0
            daddi $t2, $0, 24
LECTURA:    SD $s4, 0($s1)              
            SD $s3, 0($s0)

            SD $s5, 0 ($s0)             
            LD $t1, 0 ($s1)             
            SD $t1, A($t0)
            daddi $t0, $t0, 8
            bne $t0, $t2, LECTURA


    DADDI $t0, $0, 0
    ld $t1, A($0) 
    ld $t2, B($0) 
    DADD $t4, $t1, $t2      ; A + B
    
 
    ld $t3, C($0)
    DADDI $t0, $t0 ,1
    LOOP: BEQZ $t3, TERMINO
        dmul $t0, $t0, $t4  
        DADDI $t3, $t3, -1        
    J LOOP

    TERMINO: SD $t0, RESUL ($0) 
    SD $t0, 0 ($s1)         
    SD $s2, 0 ($s0)

HALT
