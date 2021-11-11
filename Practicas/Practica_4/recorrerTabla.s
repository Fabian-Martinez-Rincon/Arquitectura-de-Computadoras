.data
    cant: .word 8
    datos: .word 1, 2, 3, 4, 5, 6, 7, 8
    res: .word 0

.code
    DADD R1, R0, R0          ; Inicializa R1 = 0
    LD R2, cant (R0)         ; R2 = cant
    LOOP: LD R3, datos (R1)  ; R3 = elemento de datos en la posición R1
        DADDI R2, R2, -1     ; Resta 1 a la cantidad de elementos a procesar
        DSLL R3, R3, 1       ; Multiplica por dos el elemento actual
        SD R3, res (R1)      ; Almacena el resultado en la tabla de resultados
        DADDI R1, R1, 8      ; Avanza a la siguiente posición
        BNEZ R2, LOOP        ; Si quedan elementos sigo iterando
    NOP
HALT
