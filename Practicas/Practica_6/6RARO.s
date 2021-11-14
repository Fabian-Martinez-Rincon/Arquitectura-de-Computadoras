.data

    msj_ingreso1: .asciiz "Ingrese una coordenada X: "
    msj_ingreso2: .asciiz "Ingrese una coordenada Y: "
    msj_ingreso3: .asciiz "Ingrese el valor de los colores RGB: "
    coorX: .byte 0; coordenada X de un punto
    coorY: .byte 0; coordenada Y de un punto
    color: .byte 0, 0, 0, 0; 
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008


.code
    lwu $s6, CONTROL($zero)
    lwu $s7, DATA($zero)

    daddi $t0, $0, msj_ingreso1 
    sd $t0, 0 ($s7) 
    daddi $t1, $0, 4 
    sd $t1, 0 ($s6) 


    daddi $t1, $0, 8
    sb $t1, 0($s6) 
    lbu $t2, 0($s7) 
    sb $t2, coorX($0)
    
    
    daddi $t0, $0, msj_ingreso2 
    sd $t0, 0 ($s7) 
    daddi $t1, $0, 4 
    sd $t1, 0 ($s6) 
    

    daddi $t1, $0, 8
    sb $t1, 0($s6) 
    lbu $t3, 0($s7) 
    sb $t3, coorY($0)
    
    daddi $t0, $0, msj_ingreso3
    sd $t0, 0 ($s7)
    daddi $t1, $0, 4 
    sd $t1, 0 ($s6)


    ;__________________________________
    daddi $a0, $0, 0
    
    daddi $a1, $0, 3
    
    loop: daddi $t1, $0, 8
        sb $t1, 0($s6) 
        lbu $t3, 0($s7) 
        sb $t3, color($a0)
        daddi $a0, $a0, 1
    bne $a0, $a1 ,loop
    ;__________________________________
    daddi $t0, $zero, 7
    sd $t0, 0($s6)
    
    lbu $s0, coorX($zero)
    sb $s0, 5($s7)
    lbu $s1, coorY($zero)
    sb $s1, 4($s7)

    lwu $s2, color($zero)
    sw $s2, 0($s7)
    
    daddi $t0, $zero, 5
    sd $t0, 0($s6); CONTROL recibe 5 y produce el dibujo del punto
    
halt