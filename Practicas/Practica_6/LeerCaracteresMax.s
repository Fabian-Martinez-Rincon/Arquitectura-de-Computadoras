.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    CARACTER: .byte 0
.code
    LWU $s0, CONTROL($0)
    LWU $s1, DATA($0)
    
    DADDI $s4, $0, 13       ; 13 el ascii del enter pá

    LOOP: DADDI $t1, $0, 9
        SD $t1,0 ($s0)      ; CONTROL = 9

        ; *PRESIONA UNA TECLA*
        ; LA CPU GUARDA EL CARACTER EN DATA

        LBU $t1,0 ($s1)

        ; COMPARO CON EL ENTER
        BEQ $t1, $s4, FIN

        ; GUARDO LA VARIABLE
        SB $t1, CARACTER($0)

        ;TOMO LA DIR DE CARACTER
        DADDI $s3, $0, CARACTER

        ; MANDO DIR DE CARACTER
        SD $s3, 0 ($s1)

        ; IMPRIMIR CARACTER
        DADDI $t1, $0, 4
        SD $t1, 0 ($s0) ; CONTROL 4

        J LOOP
FIN: HALT