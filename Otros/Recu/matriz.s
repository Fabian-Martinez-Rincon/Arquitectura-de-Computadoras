; Escribir un programa que lea una tabla de 3x3 con números en punto flotante. La tabla se almacena como un vector de 9 elementos, donde primero se almacena la fila 1 de izquierda a derecha, luego la fila 2 y finalmente la fila 3. Utilizar una subrutina para la lectura.
; 
; Luego de la lectura, realizar dos subrutinas que calculen:
; subrutina 1) La suma de la diagonal de la matriz (también llamada traza de A o Traza(A))
; subrutina 2) La suma de los valores absolutos de los elementos de la matriz (también llamada la Norma de la matriz o Norma(A)).
; 
; Las subrutinas deben recibir dirección base de la tabla según la convención vista, y devolver en $f1 y $f2, respectivamente, los valores pedidos. 
; 
; Finalmente, en el programa principal deberá llamar a estar subrutinas y con su resultado calcular e informar el valor de Traza(A)/Norma(A). 
; 
; Nota: Para calcular el valor absoluto de un número, sugerimos multiplicar el número por -1 si es que es negativo.
; 
; Ejemplo: Si la matriz A tiene valores:
;  1  2 -3
;  3  4  5
; -2 -3 -4
; Entonces Traza(A) = 1 + 4 - 4 = 1  y Norma(A) = 1 + 2 +3 +3 + 4 + 5 + 2 + 3 + 4 = 27


.data
    CONTROL: .word32 0x10000
    DATA:    .word32 0x10008
    TABLA:   .word 0
    preg:    .asciiz ' \n Ingrese un numero '

.code
    lwu $s1, CONTROL($zero)
    lwu $s0, DATA($zero)
    daddi $s7,$0,0          ;Acumulador

    daddi $t6,$0,0          ;Desplazador

    daddi $t5,$0,0          ; Cantidad de elementos



HALT