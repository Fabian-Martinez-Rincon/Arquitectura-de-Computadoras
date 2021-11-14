.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    NUM:     .double 19.5

.code
    LD $s0, CONTROL ($0)    ;s0 = CONTROL
    LD $s1, DATA ($0)       ;s1 = DATA

    L.D f1, NUM ($0)
    S.D f1, 0 ($s1)         ; Mando el dato a DATA

    DADDI $t0, $0, 3
    SD $t0, 0 ($s0)         ; CONTROL = 3

    ;DADDI $t0, $0, 6       ; LIMPIA LA PANTALLA
    ;SD $t0, 0 ($s0)        ; CONTROL = 6
HALT