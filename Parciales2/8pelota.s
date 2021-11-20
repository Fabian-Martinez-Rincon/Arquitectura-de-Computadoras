.data
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
    fondo: .word32 0x00FFFFFF   ; Blanco

    pelota1: .word32 0x00FF0000 ; Azul
             .byte 23           ; Pos X
             .byte 1            ; Pos Y
             .word 1            ; Direccion X
             .word 1            ; Direccion Y
    pelota2: .word32 0x0000FF00
             .byte 27           ; Pos X
             .byte 21           ; Pos Y
             .word -1           ; Direccion X
             .word -1           ; Direccion Y
    pelota3: .word32 0x000000FF
             .byte 1            ; Pos X
             .byte 5            ; Pos Y
             .word 1            ; Direccion X
             .word 1            ; Direccion Y
    pelota4: .word32 0x00FF00FF
             .byte 35           ; Pos X
             .byte 35           ; Pos Y
             .word -1           ; Direccion X
             .word 1            ; Direccion Y
    pelota5: .word32 0x00FFFF00
             .byte 1            ; Pos X
             .byte 35           ; Pos Y
             .word 1            ; Direccion X
             .word 1            ; Direccion Y
    pelota6: .word32 0x0000FFFF
             .byte 35           ; Pos X
             .byte 1            ; Pos Y
             .word -1           ; Direccion X
             .word 1            ; Direccion Y
 .code
    daddi $sp, $0, 0x400
    loop: daddi $a0, $zero, pelota1
        jal mostrar
        daddi $a0, $zero, pelota2
        jal mostrar
        daddi $a0, $zero, pelota3
        jal mostrar
        daddi $a0, $zero, pelota4
        jal mostrar
        daddi $a0, $zero, pelota5
        jal mostrar
        daddi $a0, $zero, pelota6
        jal mostrar
        daddi $t0, $0, 500              ; Hace una demora para que el rebote no sea tan rápido.
        demora: daddi $t0, $t0, -1      ; Esto genera una infinidad de RAW y BTS pero...
        bnez $t0, demora                ; hay que hacer tiempo igualmente!
 j loop

;__________________________________
mostrar: daddi $sp, $sp, -16
    sd $s0, 0($sp)
    sd $s1, 8($sp)
    lwu $s0, CONTROL($0)
    lwu $s1, DATA($0)
    lwu $t0, fondo($zero)       ; Recupero fondo
    lwu $t1, 0($a0)             ; Recupero color
    lbu $t2, 8($a0)             ; Recupero Coordenada X de la pelota
    lbu $t3, 16($a0)            ; Recupero Coordenada Y de la pelota
    ld $t4, 24($a0)             ; Recupero Dirección X de la pelota
    ld $t5, 32($a0)             ; Recupero Dirección Y de la pelota
    daddi $t6, $0, 5            ; Comando para dibujar un punto
    
    ; Borra la pelota
    sw $t0, 0($s1)          ; Color de Fondo
    sb $t2, 4($s1)          ; Pos X
    sb $t3, 5($s1)          ; Pos Y
    sd $t6, 0($s0)          ; Dibujar
    dadd $t2, $t2, $t4      ; Mueve la pelota en la dirección actual
    dadd $t3, $t3, $t5
    daddi $t7, $0, 48       ; Comprueba que la pelota no está en la columna de más
    slt $t8, $t7, $t2       ; a la derecha. Si es así, cambia la dirección en X.
    dsll $t8, $t8, 1
    dsub $t4, $t4, $t8
    slt $t8, $t7, $t3       ; Comprueba que la pelota no está en la fila
    ; de más arriba.
    dsll $t8, $t8, 1        ; Si es así, cambia la dirección en Y.
    dsub $t5, $t5, $t8
    slti $t8, $t2, 1        ; Comprueba que la pelota no está en la columna de más
    dsll $t8, $t8, 1        ; a la izquierda. Si es así, cambia la dirección en X.
    dadd $t4, $t4, $t8
    slti $t8, $t3, 1        ; Comprueba que la pelota no está en la fila de más
    dsll $t8, $t8, 1        ; abajo. Si es así, cambia la dirección en Y.
    dadd $t5, $t5, $t8

    sw $t1, 0($s1)          ; Dibuja la pelota.
    sb $t2, 4($s1)
    sb $t3, 5($s1)
    sd $t6, 0($s0)

    sb $t2, 8($a0)          ; Guardo Coordenada X de la pelota
    sb $t3, 16($a0)         ; Guardo Coordenada Y de la pelota
    sd $t4, 24($a0)         ; Guardo Dirección X de la pelota
    sd $t5, 32($a0)         ; Guardo Dirección Y de la pelota
    ld $s0, 0($sp)
    ld $s1, 8($sp)
    daddi $sp, $sp, 16
    jr $ra