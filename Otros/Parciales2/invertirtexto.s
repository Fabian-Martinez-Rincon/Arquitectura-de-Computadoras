                .data
CONTROL:        .word32 0x10000
DATA:           .word32 0x10008
MSJ:            .asciiz "Ingrese un mensaje terminado en 0: \n"
CAR:            .asciiz ""
TXT:            .asciiz ""

                .text
                lwu $s6, CONTROL($0)
                lwu $s7, DATA($0)

                jal cargarMSJ
                DADDI $a0, $v0, 0
                jal imprimirDerecho
                jal imprimirAlrevez
halt

cargarMSJ:      DADDI $t0, $0, MSJ
                sd $t0, 0($s7)
                DADDI $t1, $0, 4
                sd $t1, 0($s6)
                DADDI $t4, $0, 48
                DADDI $t0, $0, TXT
                DADDI $t2, $0, 9

loop:           sd $t2, 0($s6)
                lbu $t3, 0($s7)
                beq $t3, $t4, fin
                sb $t3, 0($t0)
                sd $t0, 0($s7)
                sd $t1, 0($s6)
                DADDI $t0, $t0, 1
                j loop
fin:            DADDI $t1, $0, TXT
                dsub $v0, $t0, $t1
                jr $ra

imprimirDerecho: DADDI $t0, $0, TXT
                sd $t0, 0($s7)
                DADDI $t0, $0, 4
                sd $t0, 0($s6)
                jr $ra

imprimirAlrevez: DADDI $t0, $0, TXT
                dadd $t0, $t0, $a0
                DADDI $t0, $t0, -1
                DADDI $t1, $0, 4
                DADDI $t3, $0, CAR
                sd $t3, 0($s7)
loop2:          lbu $t2, 0($t0)
                sb $t2, 0($t3)
                sd $t1, 0($s6)
                DADDI $t0, $t0, -1
                DADDI $a0, $a0, -1
                bnez $a0, loop2
                jr $ra