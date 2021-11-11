.data
    NUM1: .word 3
    NUM2: .word 5
    RES: .word 0
.code
    ld R1, NUM1(r0) ; 3
    ld R2, NUM2(r0) ; 8
    dadd R3, R0, R0
    loop: dadd R3, R3, R1
        daddi R2,R2, -1
        bnez R2, loop
    sd R3, RES(r0)
halt