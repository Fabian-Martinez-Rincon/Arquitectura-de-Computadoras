.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    PIXEL:   .byte 0, 185, 135, 0, 23, 10, 0, 0
.code 
    LD $s0, CONTROL ($0)     ; $s0 = CONTROL
    LD $s1, DATA ($0)        ; $s1 = DATA

    LD $t0, PIXEL ($0)
    SD $t0, 0 ($s1)             ; Mando el dato a DATA

    DADDI $t0, $0, 5
    SD $t0, 0 ($s0)             ; CONTROL = 5

HALT
