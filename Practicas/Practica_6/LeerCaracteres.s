.data
    CONTROL:    .word 0x10000
    DATA:       .word 0x10008
    NUM:        .double 0.0
    CARACTER:   .byte 0

.code
    LWU $s0, CONTROL ($zero) 	; $s0 = CONTROL
    LWU $s1, DATA ($zero) 	   	; $s1 = DATA

    DADDI $t0, $zero, 8
    SD $t0, 0 ($s0)             ; CONTROL = 8
    L.D f1, 0 ($s1)             ; Tomo número en f1
    S.D f1, NUM ($zero)         ; Guardo en variable

    DADDI $t1, $zero, 9
    SD $t1, 0 ($s0)             ; CONTROL = 9
    LBU $t1, 0 ($s1)            ; Tomo caracter en $t1
    SB $t1, CARACTER ($zero)    ; Guardo en variable
HALT
