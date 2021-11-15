
; Implementar  una subrutina llamada TIRAR_DADO. La misma deberá solicitar el ingreso por teclado de un numero del 1 al 6. Si el número ingresado es 1, 2 3, 4, 5 o  6
; La subrutina deberá imprimir por pantalla el número ingresado y retornar dicho valor. En caso contrario,  la subrutina deberá  imprimir por pantalla  “EL TIRO NO ES VALIDO” y devolver el valor 0.

; Usando la subrutina TIRAR_DADO implementar una subrutina que invoque a TIRAR_DADO y genere una tabla llamada RESULTADOS con los resultados obtenidos.
; La subrutina finaliza cuando la SUMA de los resultados obtenidos  sea mayor o igual a los últimos 3 números de su documento. 

.data
       DIRCONTROL: .word 0x10000
       DIRDATA: .word 0x10008
       MSGLEER: .asciiz "Ingrese un número del 1 al 6:\n"
       MSGERROR: .asciiz "TE DIJE DEL 1 AL 6 CARAJO:\n"
       MSGFIN: .asciiz "Fin de lectura\n"

TABLA: .word 0
       .code
       daddi $sp,$0,0x400
       ld $s0, DIRCONTROL($0)
       ld $s1, DIRDATA($0)

       daddi $a0,$0,TABLA
       jal LEER_TABLA
       daddi $a0,$0,MSGFIN
       jal imprimir

halt

# recibe en a0 la dirección de un texto y lo imprime
imprimir: sd $a0, 0($s1)
          daddi $t0,$0,4
          sd $t0, 0($s0)
          jr $ra

TIRAR_DADO: # usar la pila para preservar a $ra
            daddi $sp,$sp,-8
            sd $ra, 0($sp)

            daddi $a0,$0, MSGLEER
            jal imprimir

        loop: daddi $t0,$0, 8
              sd $t0, 0($s0)
              # cargar de data
              ld $v0, 0($s1)
              # Me fijo que sea menor que 6
              slti $t2,$v0,7
              beqz $t2, error
              # Me fijo que sea mayor que 1
              slti $t2,$v0,1
              bnez $t2, error
              j fin
       error: daddi $a0, $0, MSGERROR
              jal imprimir
              j loop
         fin: ld $ra, 0($sp)   
              daddi $sp,$sp,8
            jr $ra 

# Recibe en $a0 la dirección de comienzo de la tabla
# Lee números del 1 al 6 y los mete en la tabla
# Devuelve en $v0 la cantidad de elementos de la misma
LEER_TABLA: # usar la pila para preservar a $ra
            daddi $sp,$sp,-32
            sd $ra, 0($sp)
            sd $s2, 8($sp)
            sd $s3, 16($sp)
            sd $s4, 24($sp)

            # uso registros s para que TIRAR_DADO no sobreescriba
            daddi $s2,$0,0 #cantidad de elementos
            dadd  $s3,$0,$a0 # puntero al vector
            daddi  $s4,$0,0 # acumulador de la suma de valores leidos
      loop2: jal TIRAR_DADO
             sd $v0,0($s3) #guardo en tabla
             daddi $s2,$s2,1 #cuento 1
             daddi $s3,$s3,8 # avanzo al sigueinte
             dadd $s4,$s4,$v0 # sumo el valor
             slti $t0,$s4,023 # me fijo si es menor que los ultimos 3 digitos dni
             bnez $t0, loop2
            # restauro $ra
            
            ld $ra, 0($sp)
            ld $s2, 8($sp)
            ld $s3, 16($sp)
            ld $s4, 24($sp)    
            daddi $sp,$sp,32
             jr $ra

FINAL:
         jr $ra
