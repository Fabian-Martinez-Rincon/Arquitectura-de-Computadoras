                .data
TABLA:          .word 7, 8, 9, 99, 10
LONG:           .word 5
IMPARES:        .word 0

                .text
                daddi $s0, $0, TABLA
                ld $s1, LONG($0)
                daddi $s2, $0, IMPARES
                
                
LOOP:           beqz $s1, FIN           ; Recorro toda la tabla
                ld $t1, 0($s0)          ; copio en t1 el valor de tabla          
                daddi $s0, $s0, 8       ; aumento en la tabla
                daddi $s1, $s1, -1      ; decremento el contador de elementos
                andi $t2, $t1, 1        ; con el and 1 miramos que sea impar
                beqz $t2, LOOP          ; si no es impar, continuo en el loop
                sd $t1, 0($s2)          ; guardo el elemento de la tabla en IMPARES 
                daddi $s2, $s2, 8       ; aumento la posicion
                j LOOP
FIN: halt
