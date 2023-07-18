;   Escribir un programa que recorra una TABLA de cantidad de elementos indicada
;   en la posición de memoria LONG y genere otra a partir de las posiciones de memoria
;   IMPARES que contenga todos los elementos impares de TABLA

                .data
TABLA:          .word 7, 8, 9, 99, 10
LONG:           .word 5
IMPARES:        .word 0

                .text
                daddi $s0, $0, TABLA
                ld $s1, LONG($0)
                daddi $s2, $0, IMPARES
                
                
LOOP:           beqz $s1, FIN
                ld $t1, 0($s0)
                daddi $s0, $s0, 8
                daddi $s1, $s1, -1
                andi $t2, $t1, 1
                beqz $t2, LOOP
                sd $t1, 0($s2)
                daddi $s2, $s2, 8
                j LOOP
FIN: halt