;    Escribir un programa Winmips que genere un arreglo (tabla1) de N números en punto flotante 
;    ingresados por el usuario desde el teclado, y otro arreglo (tabla2) con los elementos de tabla1 
;    elevados al cuadrado. Ambos arreglos deben almacenarse en memoria uno a continuación de otro. 
;    El ingreso de datos por el teclado se debe implementar en una subrutina. Una vez ingresados los
;    N valores y almacenados en memoria se debe generar el segundo arreglo. Esto debe implementarse
;    a través de otra  subrutina, que reciba como parámetros las direcciones de comienzo de tabla1 y
;    tabla2. Considerar N=12.

.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008

    NUMERO1: .word -50
    NUMERO2: .word -2
    RES: .word 0
    MASC: .word 0xffffffffffffffff
.code
    LD $s0, CONTROL ($0)
    LD $s1, DATA ($0)
    DADDI $s2, $0, 2

    LD $t1, NUMERO1 ($0)     
    LD $t2, NUMERO2 ($0)

    ;-----------------------------
    slti $t0, $t1, 0
    beqz $t0, JUMP
    daddi $t4, $0, 1
    dadd $a0, $t1, $0
    jal CA2
    dadd $t1, $v0, $0
    ;-----------------------------

    JUMP: DADD $t3, $t3, $t2 
        DADDI $t1, $t1 , -1
    BNEZ $t1, JUMP

    ;-----------------------------
    beqz $t4, FIN
    dadd $a0, $t3, $0
    jal CA2
    dadd $t3, $v0, $0
    ;-----------------------------

    FIN: SD $t3, RES($0)
    SD $t3, 0 ($s1)
    SD $s2, 0 ($s0)
HALT

CA2:        ld $t0, MASC($0)  ;  MASC: .word 0xffffffffffffffff
            xor $v0, $a0, $t0
            daddi $v0, $v0, 1
            jr $ra


