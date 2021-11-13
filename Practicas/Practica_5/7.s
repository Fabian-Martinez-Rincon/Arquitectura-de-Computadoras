.data
    m: .word 14
    tabla: .word 50,12,15,11,2
    resultado: .word 0
.code
    ld $a0, m(r0)
    daddi $a1, $0, 5
    daddi $a2, $0, tabla
    jal valores
    nop
    sd $v0, resultado($0)
    halt

valores: dadd $t0, $a1, $0
         dadd $v0, $0, $0
loop:     ld $t4, 0($a2)
         slt $t2, $t4, $a0
         bnez $t2 ,inc
         j noinc 
inc:        daddi $v0, $v0, 1
noinc:     daddi $a2, $a2, 8
         daddi $t0, $t0, -1
         bnez $t0, loop
         jr $ra