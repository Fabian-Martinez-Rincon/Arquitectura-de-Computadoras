.data
    VALOR1: .word 2
    VALOR2: .word 4
    RES:    .word 0
    
.text
    ld $a0, VALOR1($zero)   ; a = 16
    ld $a1, VALOR2($zero)   ; a1 = 4
    jal a_la_potencia       ; Salta y guarda la dir en R31
    sd $v0, RES($zero)      ; Muesto el valor de retorno de la subrutina
    halt

    a_la_potencia: daddi $v0, $zero, 1  ; Incremento v0
        lazo: slt $t1, $a1, $zero       ; si a1 < 0 deja un 1 en t1
        bnez $t1, terminar              ; cuando t1 llega a 0 termino
        daddi $a1, $a1, -1              ; decremento a1
        dmul $v0, $v0, $a0              ; v0 = v0 * a0
        j lazo

    terminar: jr $ra

    ; El programa saca la potencia de un nro, el programa hace VALOR2 ^ VALOR1

    ; jal Salta a la dirección rotulada offN y copia en r31 la dirección de retorno

    ; Salta a la dirección contenida en el registro rd