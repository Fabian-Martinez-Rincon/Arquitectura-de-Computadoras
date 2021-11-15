.data
    CONTROL:        .word32 0x10000
    DATA:           .word32 0x10008
    COLORES:        .word32 0x00FF0000, 0x000000FF, 0x0000FF00, 0x0000FFFF, 0x00FFFF00         ; Azul 0000FF
    color_fondo:    .word32 0x00FFFFFF         ; Blanco
    POSICIONES:      .byte 0,0 , 0,0 , 0,0, 0,0, 0,0
    DIRECCIONES:     .byte 1,2, 1,4, 2,1, 4,1, 2,4
.text
    LWU $s6, CONTROL($0)
    LWU $s7, DATA($0)
    LWU $v1, color_fondo($0)
    
    DADD $a0, $0, $0   ; INICIALIZO LOS PARAMETROS :c
    DADD $a1, $0, $0
    
    DADDI $t7, $0, 5                     ; Comando para dibujar un punto
    DADDI $s4, $0, 5                


LIMPIAR: DADDI $t0, $0, 7
         SD $t0, 0($s6)

LOOP: JAL CARGARPELOTA
    DADD $s0, $s0, $s2                      ;Mueve la pelota en la dirección actual
    DADD $s1, $s1, $s3
    DADDI $t1, $0, 48                    ; Comprueba que la pelota no esté en la columna de más

    slt $t0, $t1, $s0                       ; a la derecha. Si es así, cambia la dirección en X.
    dsll $t0, $t0, 1
    dsub $s2, $s2, $t0
    
    slt $t0, $t1, $s1                       ; Comprueba que la pelota no esté en la fila de más arriba.
    dsll $t0, $t0, 1                        ; Si es así, cambia la dirección en Y.
    dsub $s3, $s3, $t0
    
    slti $t0, $s0, 1                        ; Comprueba que la pelota no esté en la columna de más
    dsll $t0, $t0, 1                        ; a la izquierda. Si es así, cambia la dirección en X.
    DADD $s2, $s2, $t0
    
    slti $t0, $s1, 1                        ; Comprueba que la pelota no esté en la fila de más abajo.
    dsll $t0, $t0, 1                        ; Si es así, cambia la dirección en Y.
    DADD $s3, $s3, $t0


    sw $v0, 0($s7)                          ; Dibuja la pelota.
    SB $s0, 4($s7)
    SB $s1, 5($s7)
    SD $s4, 0($s6)
    
    JAL GUARDARPELOTA

    DADDI $a0, $a0, 1
    DADDI $a1, $a1, 4
    DADDI $t7, $t7, -1
    BNEZ $t7, LOOP
    DADDI $t7, $0, 5
    DADDI $a0, $a0, 0
    DADDI $a1, $a1, 0



    DADDI $t0, $0, 2000                   ; Hace una demora para que el rebote no sea tan rápido.
demora: DADDI $t0, $t0, -1                  ; Esto genera una infinidad de RAW y BTS pero...
        bnez $t0, demora                        ; ¡hay que hacer tiempo igualmente!
        j LIMPIAR

CARGARPELOTA: LWU $v0, COLORES($a1)
              LB $s0, POSICIONES($a0)
              LB $s2, DIRECCIONES($a0)
              DADDI $a0, $a0, 1

              LB $s1, POSICIONES($a0)
              LB $s3, DIRECCIONES($a0)
              JR $ra

GUARDARPELOTA: DADDI $a0, $a0, -1
               SB $s0, POSICIONES($a0)
               SB $s2, DIRECCIONES($a0)
               DADDI $a0, $a0, 1
               SB $s1, POSICIONES($a0)
               SB $s3, DIRECCIONES($a0)
               JR $ra