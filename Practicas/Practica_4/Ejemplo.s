.data
    NUM1: .word 15

.code
    DADDI R1, R0, 8
    LD R7, NUM1 (R0)
    DADDI R2, R1, 10
HALT
