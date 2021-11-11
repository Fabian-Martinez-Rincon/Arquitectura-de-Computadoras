.data
    cant: .word 8
    datos: .word 1, 2, 3, 4, 5, 6, 7, 8
    res: .word 0
.code
    dadd R1, R0, R0         ;INICIALIZO R1
    ld R2, cant(R0)         ; R2 = 8
    loop: ld R3, datos(R1)  ; R3 = ELEMENTO DE TABLA EN X POSICION
        daddi R2, R2, -1    ; DECREMENTO EL CONTADOR DE TABLA
        dsll R3, R3, 1      ; MUEVO LOS BITS UNA POSICION A LA IZQUIERDA QUE SERIA EL EQUIVALENTE A MULTIPLICARLOS X2
        sd R3, res(R1)      ; R3 = REMPLAZO EL VALOR NUEVO EN LA TABLA
        daddi R1, R1, 8     ; ME MUEVO AL SIGUIENTE ELEMENTO DE LA TABLA
        bnez R2, loop       ; MIENTRAS NO TERMINE DE RECORRER LA TABLA, CONTINUO
    nop
halt