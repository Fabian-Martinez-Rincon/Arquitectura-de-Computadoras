.data
    A: .word 1
    B: .word 3
.code
    ld r1, A(r0)
    ld r2, B(r0)
    loop: dsll r1, r1, 1
        daddi r2, r2, -1
    bnez r2, loop
halt
