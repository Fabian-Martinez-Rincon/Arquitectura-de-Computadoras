.data
    NRO: .word 10
    RESULTADO: .word 0
.code
    daddi $sp, $0, 0x400    ; Inicializa el puntero al tope de la pila
    ld $a0, NRO($0)         ; a0 = NRO
    jal FACTORIAL           ; Llamo a la subrutina
    sd $v0, RESULTADO($0)   ; Guardo el dato
halt

 
FACTORIAL: daddi $sp, $sp, -16      ; PUSH
    sd $ra, 0($sp)
    sd $s0, 8($sp)

    beqz $a0, FIN_RECURSIVO         ; Si nro - 1 = 0, termino
    dadd $s0, $0, $a0               ; Tomo el valor actual    
    daddi $a0, $a0, -1              ; nro = nro - 1

    jal FACTORIAL                   ; RECURSIVO
    dmul $v0, $v0, $s0              ; v0 * nro actual
    j FIN                           ; termino

    FIN_RECURSIVO: daddi $v0, $0, 1

    FIN: ld $s0, 8($sp)             ; POP
        ld $ra, 0($sp)
        daddi $sp, $sp, 16
    jr $ra 