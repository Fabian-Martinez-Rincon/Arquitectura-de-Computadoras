.data
    NUM1: .word 5
    NUM2: .word 8
    RES: .word 0

.code
    LD R1, NUM1 (R0)
    LD R2, NUM2 (R0)
    JAL SUMAR ; Llama a la subrutina
    SD R3, RES (R0)
HALT

SUMAR: DADD R3, R1, R2 
    JR R31 ; Retorna al punto donde fue llamado
