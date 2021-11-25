<h1 align="center"> 💻Parciales</h1>


 Implementar  una subrutina INGRESAR_NUMERO. 
 La misma deberá solicitar el ingreso por teclado de un número entero del 1 al 9. Si el número ingresado es  un número 
 válido entre 1 y 9 la subrutina deberá imprimir por pantalla el número ingresado y retornar dicho valor. En caso contrario, 
 la subrutina deberá  imprimir por pantalla  “Debe ingresar un número” y devolver el valor 0. 
 
 
 Usando la subrutina INGRESAR_NUMERO implementar un programa que invoque a dicha subrutina 
 y genere una tabla llamada NUMEROS con los valores ingresados. La generación de la tabla finaliza 
 cuando la suma de los resultados obtenidos  sea mayor o igual a los últimos 3 dígitos de su número mágico.  
 
 
 Al finalizar la generación de la tabla, deberá invocar a la subrutina PROCESAR_NUMEROS.  
 
 
 Se debe usar la convención para nombrar a los registros. 
 
 
 Para todos los casos, la subrutina PROCESAR_NUMEROS debe devolver el valor calculado y desde 
 el programa principal el mismo se debe almacenar en la dirección RESULTADO.
 
 
 SI SU NUMERO MAGICO TERMINA CON  7, 8 o 9: la subrutina PROCESAR_NUMEROS debe recibir como parámetro la dirección de la tabla NUMEROS 
 y la cantidad de elementos y contar la cantidad de veces que se ingresó el valor 3.
  Se debe mostrar por pantalla el valor calculado, con el texto 'Cantidad de Veces que  se ingreso el valor 3:'  y el valor. 

```s
; NUM MAGICO 3252
.data 
      CONTROL: .word32 0x10000
      DATA: .word32 0x10008
      preg: .asciiz ' \n Ingrese un numero '
      msjerr: .asciiz 'Debe Ingresar un numero \n'
      msj3: .asciiz ' \n Cantidad de Veces que  se ingreso el valor 3: '
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
daddi $t7,$0,3 ; Constante 3 
loop: beqz $a1,finalizarRut
      ld $s4, 0($a0)
      daddi $a0,$a0,8
      daddi $a1,$a1,-1
      beq $s4,$t7,sumar 
      j loop 
sumar: daddi $v0,$v0,1
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
```

 SI SU NUMERO MÁGICO TERMINA CON 0, 1 o 2: la subrutina PROCESAR_NUMEROS debe recibir como parámetro la dirección 
 de la tabla NUMEROS y la cantidad de elementos y contar la cantidad de números impares ingresados.
 Se debe mostrar por pantalla el valor calculado, con el texto 'Cantidad de Valores Impares: ' y el valor.

```s
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
```

```s
; SI SU NUMERO MÁGICO TERMINA CON  3 o 4: la subrutina PROCESAR_NUMEROS debe recibir como parámetro 
; la dirección de la tabla NUMEROS y la cantidad de elementos y  contar la cantidad de números pares ingresados.
; Se debe mostrar por pantalla el valor calculado, con el texto 'Cantidad de Valores pares: ' y el valor.

.data 
      CONTROL: .word32 0x10000
      DATA: .word32 0x10008
      preg: .asciiz ' \n Ingrese un numero '
      msjerr: .asciiz 'Debe Ingresar un numero \n'
      msj3: .asciiz ' \n Cantidad de Valores pares: '
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
      andi $t7, $s4, 1        ; con el and 1 miramos que sea par
      beqz $t7, par
      J loop
      par: daddi $v0,$v0,1       ;aumenta 1 en el contador
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
```

```s
;SI SU NUMERO MÁGICO TERMINA CON  5 o 6: la subrutina PROCESAR _NUMEROS debe recibir 
;como parámetro la dirección de la tabla NUMEROS y la cantidad de elementos y contar la cantidad
; de números mayores a 5. Se debe mostrar por pantalla el valor calculado, con el
;  texto 'Cantidad de Valores mayores que 5: ' y el valor. (5 puntos)

.data 
      CONTROL: .word32 0x10000
      DATA: .word32 0x10008
      preg: .asciiz ' \n Ingrese un numero '
      msjerr: .asciiz 'Debe Ingresar un numero \n'
      msj3: .asciiz ' \n Cantidad de Valores mayores que 5: '
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
daddi $t9, $0, 5        ;constante
loop: beqz $a1,finalizarRut
      ld $s4, 0($a0)
      daddi $a0,$a0,8
      daddi $a1,$a1,-1
      daddi $t7, $0,0

      slt $t7, $s4, $t9       ; si es menor que 5
      bnez $t7, loop
      
      beq $s4, $t9, loop

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
```
