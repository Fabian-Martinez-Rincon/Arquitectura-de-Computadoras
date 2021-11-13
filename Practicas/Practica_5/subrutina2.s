.data
    NUM1: .word 5
    NUM2: .word 8
    RES: .word 0

.code
    LD $a0, NUM1 (R0)
    LD $a1, NUM2 (R0)
    JAL SUMAR ; Llama a la subrutina
    SD $v0, RES (R0)
HALT

SUMAR: DADD $v0, $a0, $a1
    JR $ra ; Retorna al punto donde fue llamado
