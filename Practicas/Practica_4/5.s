.data
    cant: .word 8
    datos: .word 1, 2, 3, 4, 5, 6, 7, 8
    res: .word 0
.code
    dadd r1, r0, r0
    ld r2, cant(r0)
    loop: ld r3, datos(r1)
        daddi r2, r2, -1
        dsll r3, r3, 1
        sd r3, res(r1)
        daddi r1, r1, 8
        bnez r2, loop
    nop
halt