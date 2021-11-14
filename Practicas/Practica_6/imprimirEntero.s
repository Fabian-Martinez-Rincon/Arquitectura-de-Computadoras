.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    NUM:     .word 2

.code
    LD $s0, CONTROL ($0)    ;s0 = CONTROL
    LD $s1, DATA ($0)       ;s1 = DATA

    LD $t0, NUM ($0)
    SD $t0, 0 ($s1)         ; Mando el dato a DATA

    DADDI $t0, $0, 2
    SD $t0, 0 ($s0)         ; CONTROL = 2

    ;DADDI $t0, $0, 6       ; LIMPIA LA PANTALLA
    ;SD $t0, 0 ($s0)        ; CONTROL = 6
HALT