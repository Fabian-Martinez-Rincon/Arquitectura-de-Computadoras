.data
    num1: .word 3
    num2: .word 5
    res: .word 0
.code
    LD r1, num1(r0)
    LD r2, num2(r0)
    DADD r10, r0, r0
    LOOP: DADDI r2, r2, -1
        BNEZ r2, LOOP
        DADD r10, r10, r1
        SD r10, res(r0)
    HALT