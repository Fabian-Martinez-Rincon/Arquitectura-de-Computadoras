.data
    CONTROL: .word32 0x10000
    DATA:    .word32 0x10008
    TABLA:   .word 0,0,0,0,0,0,0,0,0
    preg:    .asciiz ' \n Ingrese un numero '
    resultado:    .asciiz ' \n valor de Traza(A)/Norma(A) es: '
    absoluto: .double  -1.0
    cero: .double 0.0
    
.code
    lwu $s1, CONTROL($zero)
    lwu $s0, DATA($zero)
    l.d f12, cero($zero)

    jal leerDatos

    daddi $a0, $0, TABLA            # Mando la direccion de la tabla 
    jal trazaA    
    
    daddi $a0, $0, TABLA            # Mando la direccion de la tabla 
    jal trazaB
    

    daddi $t0, $0, resultado                      # $t0 = dirección del mensaje a mostrar  
    sd $t0, 0($s0) 			                 # DATA recibe el puntero al comienzo del mensaje 
    daddi $t0, $0, 4 			            # $t0 = 4 -> función 4: salida de una cadena ASCII 
    sd $t0, 0($s1) 	

    div.d f3, f1, f2
       
    S.D f3, 0 ($s0)     

    ; Control 3
    DADDI $t0, $0, 3
    SD $t0, 0 ($s1)    
HALT
#__________________________________________________________________________
trazaB: daddi $t7, $0, 0          # desplazador
daddi $t5, $0, 9                  # contador

l.d f4, absoluto($0)
add.d f3, f3, f4                  # constante -1    

loop3: add.d f2, f2 , f0     
    L.D f0, 0 ($a0)            

    daddi $t1, $0, 0
    slti $t1, $t0, 0

    beqz $t1, continuar

    mul.d f0, f0, f3              # Multiplico con -1.0

    continuar: daddi $a0,$a0,8    # para tomar los datos de en diagonal
    daddi $t5,$t5,-1              # disminuyo el contador
    bnez $t5, loop3

    jr $ra
#__________________________________________________________________________
trazaA: daddi $t7, $0, 0          # desplazador
daddi $t5, $0, 3                  # contador

loop2: add.d f1, f1 , f0     
    L.D f0, 0 ($a0)            
    daddi $a0,$a0,32              # para tomar los datos de en diagonal
    daddi $t5,$t5,-1              # disminuyo el contador
    bnez $t5, loop2
jr $ra
#__________________________________________________________________________
leerDatos: daddi $t5,$0,9          # Cantidad de elementos

loop: daddi $t0, $0, preg          # $t0 = dirección del mensaje a mostrar  
sd $t0, 0($s0) 			           # DATA recibe el puntero al comienzo del mensaje 

daddi $t0, $0, 4 			       # $t0 = 4 -> función 4: salida de una cadena ASCII 
sd $t0, 0($s1) 			           # CONTROL recibe 4 y produce la salida del mensaje 

DADDI $t0, $zero, 8
SD $t0, 0 ($s1)             # CONTROL = 8

L.D f1, 0 ($s0)             # Tomo número en t0

S.D f1, TABLA ($t6)         # Guardo el valor en la tabla
daddi $t6,$t6,8             # Continuo con el siguiente numero
daddi $t5,$t5,-1            # disminuyo el contador

bnez $t5, loop

jr $ra