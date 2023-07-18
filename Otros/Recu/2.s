; SI SU NUMERO MÁGICO TERMINA CON 0, 1 o 2: la subrutina PROCESAR_NUMEROS debe recibir como parámetro la dirección 
; de la tabla NUMEROS y la cantidad de elementos y contar la cantidad de números impares ingresados.
; Se debe mostrar por pantalla el valor calculado, con el texto 'Cantidad de Valores Impares: ' y el valor.

.data 
      CONTROL: .word32 0x10000
      DATA: .word32 0x10008
      preg: .asciiz ' \n Ingrese un numero '
      msjerr: .asciiz 'Debe Ingresar un numero \n'
      msj3: .asciiz ' \n Cantidad de Valores Impares: '
      aux: .word 0
      NUMEROS: .word 0
      ;SUMA DE LOS ULTIMOS 3  DIGITOS 9
.code
      lwu $s1, CONTROL($zero)
      lwu $s0, DATA($zero)

      daddi $s7,$0,0          ;Acumulador

      daddi $t6,$0,0          ;Desplazador

      daddi $t5,$0,0          ; Cantidad de elementos

      pedir:  jal INGRESAR_NUMERO
            beqz $v0,pedir
            sd $v0, NUMEROS($t6)
            dadd $s7,$s7,$v0 
            daddi $t6,$t6,8   ;Desplazador
            daddi $t5,$t5,1   ; CAntidad
            slti $s3,$s7,9    ; si el acumulador es menor a 9  $s3 = 1 else $s3= 0
            beqz $s3,seguir
      j pedir 

      seguir: daddi $a0,$0,NUMEROS
      daddi $a1,$t5,0 
      jal PROCESAR_NUMEROS

      daddi $t0, $0, msj3        ; $t0 = dirección del mensaje a mostrar  
      sd $t0, 0($s0) 			            ; DATA recibe el puntero al comienzo del mensaje 

      daddi $t0, $0, 4 			        ; $t0 = 4 -> función 4: salida de una cadena ASCII 
      sd $t0, 0($s1) 			            ; CONTROL recibe 4 y produce la salida del mensaje 


      sd $v0, 0($s0) 				; DATA recibe el entero
      
      daddi $t0, $0, 1 			; $t0 = 1 -> función 1: salida de un entero sin signo
      sd $t0, 0($s1) 			; CONTROL recibe 1 y produce la salida del numero

halt 


PROCESAR_NUMEROS: daddi $v0,$0,0    ; Contador de 3 
 
loop: beqz $a1,finalizarRut
      ld $s4, 0($a0)
      daddi $a0,$a0,8
      daddi $a1,$a1,-1
      andi $t7, $s4, 1        ; con el and 1 miramos que sea impar
      beqz $t7, loop
      
      daddi $v0,$v0,1       ;aumenta 1 en el contador
      j loop 
finalizarRut: jr $ra 


INGRESAR_NUMERO: daddi $t0, $0, preg      ; $t0 = dirección del mensaje a mostrar  
sd $t0, 0($s0) 			            ; DATA recibe el puntero al comienzo del mensaje 

daddi $t0, $0, 4 			            ; $t0 = 4 -> función 4: salida de una cadena ASCII 
sd $t0, 0($s1) 			            ; CONTROL recibe 4 y produce la salida del mensaje 

daddi	$t0, $0, 9                          ; $t0 = 9 -> función 9: entrada de un caracter
sd	$t0, 0($s1)     		            ; CONTROL recibe 9

lbu	$s2, 0($s0)                         ; Leo de DATA el caracter           
sb $s2,aux($0)                            ; Lo guardo

;IF ($t0 > 48 ) and ($t0  < 58 )
slti $t3,$s2,49                           ;  ($t0 < 48) ? $t3 = 1 : $t3 = 0
bnez $t3,error 
slti $t3,$s2,58                           ; ($t0 < 58) ? $t3 = 1 : $t3 = 0
beqz $t3,error
 
daddi $t0, $0, aux 	                  ; $t0 = dirección del mensaje a mostrar  
sd $t0, 0($s0) 			            ; DATA recibe el puntero al comienzo del mensaje 

daddi $t0,$0,4
sd $t0, 0($s1) 			            ; CONTROL recibe 4 y produce la salida del mensaje 


devolver_num: daddi $v0,$s2,-48
j finalrut 
error: daddi $t0, $0, msjerr              ; $t0 = dirección del mensaje a mostrar  
sd $t0, 0($s0) 			            ; DATA recibe el puntero al comienzo del mensaje 

daddi $t0, $0, 4 			            ; $t0 = 4 -> función 4: salida de una cadena ASCII 
sd $t0, 0($s1) 			            ; CONTROL recibe 4 y produce la salida del mensaje

finalrut: jr $ra