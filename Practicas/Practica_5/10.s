.data
    CADENA: .asciiz "CazaAAA"
    VOCALES: .asciiz 'AEIOUaeiou'
    CANT: .word 0
.code
    ; La pila comienza en el tope de la memoria de datos
    DADDI $sp, $0, 0x400            ; bus 10 bits 🡪 2^10 = 1024 = 0x400

    ; Guarda como primer argumento para CONT_VOCALES
    ; la dirección de CADENA

    DADDI $a0, $0, CADENA
    dadd $v0, $0, $0  
    JAL CONT_VOCALES
    sd $v0, CANT($0)                  ; Cantidad de caracteres
HALT

CONT_VOCALES: DADDI $sp, $sp, -16     ; Reserva lugar en pila -> 2 x 8
    SD $ra, 0 ($sp)                   ; Guarda en pila $ra
    SD $s0, 8 ($sp)                   ; Guarda en pila $s0

    DADD $s0, $a0, $0                 ; Copia la dirección de inicio de la CADENA
    LOOP: LBU $a0, 0 ($s0)	        ; Toma car. actual
        BEQ $a0, $zero, FIN         ; Si es el fin, termina
        JAL ES_VOCAL
        DADDI $s0, $s0, 1           ; Avanza al siguiente caracter
    J LOOP

    ; Recupera los datos salvados en la pila
    FIN: LD $ra, 0 ($sp)
        LD $s0, 8 ($sp)
        DADDI $sp, $sp, 16
    JR $ra




ES_VOCAL: daddi $t0, $0, 0                    ; inicializo t0
    LOOP2: lbu $t1, VOCALES($t0)     ; copia el  caracter en t1
        beqz $t1, FINVOCAL         ; si t1 = 0, no se encontro VOCALES
        beq $a0, $t1, ENCONTRO      ; si LETRA = caracterActual, salto
        daddi $t0, $t0, 1           ; continuo con el siguiente caracter
    j LOOP2

    ENCONTRO: daddi $v0, $v0, 1      ; si es vocal, aumento 1 el contador
    FINVOCAL: jr $ra               ;vuelvo al programa principal             
