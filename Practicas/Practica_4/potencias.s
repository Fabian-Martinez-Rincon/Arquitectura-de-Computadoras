.data
B: .word 5

.code
    DADDI R1, R0, 1
    LD R2, B (R0)
    LOOP: DSLL R1, R1, 1    ; Desplazo a la izquierda
        DADDI R2, R2, -1    ; Cant. de desplazamientos que faltan
        BNEZ R2, LOOP       ; Si no es 0 salto a LOOP
HALT
