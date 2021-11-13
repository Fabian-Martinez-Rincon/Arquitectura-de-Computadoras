.data
    CADENA1: .asciiz "hola"
    CADENA2: .asciiz "holaa"
    result:  .word 0
.code
    daddi $a0, $0, CADENA1      ; a0 = CADENA1
    daddi $a1, $0, CADENA2      ; a1 = CADENA2
    jal compara                 ; Llamo a la subrutina
    sd $v0, result($zero)       ; guardo el valor
halt

compara: dadd $v0, $0, $0   ; inicializo V0
    LOOP: lbu $t0, 0($a0)   ; COPIA LA DIRECCION DE CADENA1
        lbu $t1, 0($a1)     ; COPIA LA DIRECCION DE CADENA2
        beqz $t0, FIN_CAD1  ; SI LLEGO AL FINAL DE CADENA1, SALTO
        beqz $t1, FIN       ; SI LLEGO AL FINAL DE CADENA2, SALTO
        bne $t0, $t1, FIN   ; SI EL CARACTER ACTUAL DE CADENA1 <> CARACTER ACTUAL CADENA2, TERMINO
        
        daddi $v0, $v0, 1       ; INCREMENTO
        daddi $a0, $a0, 1       ; INCREMENTO
        daddi $a1, $a1, 1       ; INCREMENTO
    j LOOP

    FIN_CAD1: bnez $t1, FIN     ; SI T1 <> 0, TERMINO
        daddi $v0, $0, -1
    FIN: jr $ra