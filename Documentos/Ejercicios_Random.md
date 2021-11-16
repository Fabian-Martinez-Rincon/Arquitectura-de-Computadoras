<h1 align="center"> 💻Ejercicios Random</h1>

```1)``` Escribir un programa para Winmips que lea un arreglo (tabla) de N datos en punto flotante almacenados en la memoria, y genere un segundo arreglo  (tabla2) cuyos N-1 elementos sean el promedio de cada par de datos consecutivos del arreglo original. Es decir, el primer elemento de tabla2 debera ser el promedio entre los elementos 1 y 2 de tabla1, el segundo elemento de tabla2 deberpa ser el promedio entre los elementos 2 y 3 de tabla1, etc. El calculo del promedio se debe realizar en una subrutina. El arreglo tabla2 debe quedar almacenado en memoria a continuación de tabla1. Una vez generado el arreglo tabla2, todos sus elementos deben visualizarse en la pantalla terminal del simulador. Esto debe implementarse a través de otra subrutina que reciba como parámetro la dirección inicial del arreglo. Considerar N = 12 (10 puntos) [Resolución](#Ejercicio_1)

```2)``` Escriba un programa que utilice sucesivamente dos subrutinas: La primera, denominada ingreso, debe solicitar el ingreso por teclado de un número entero (de un dígito), verificando que el valor ingresado realmente sea un dígito. La segunda, denominada muestra, deberá mostrar en la salida estándar del simulador (ventana Terminal) el valor del número ingresado expresado en letras (es decir, si se ingresa un ‘4’, deberá mostrar ‘CUATRO’).  [Resolución](#Ejercicio_2)

```3)``` Escriba un programa que realice la suma de dos números enteros (de un dígito cada uno) utilizando dos subrutinas: La denominada ***ingreso*** del ejercicio anterior (ingreso por teclado de un dígito numérico) y otra denominada ***resultado***, que muestre en la salida estándar del simulador (ventana Terminal) el resultado numérico de la suma de los dos números ingresados. [Resolución](#Ejercicio_3)

```4)``` Escriba un programa que solicite el ingreso por teclado de una clave (sucesión de cuatro caracteres) utilizando la subrutina ***char*** de ingreso de un carácter. Luego, debe comparar la secuencia ingresada con una cadena almacenada en la variable ***clave***. Si las dos cadenas son iguales entre si, la subrutina llamada ***respuesta*** mostrará el texto ***“Bienvenido”*** en la salida estándar del simulador (ventana Terminal). En cambio, si las cadenas no son iguales, la subrutina deberá mostrar ***“ERROR”*** y solicitar nuevamente el ingreso de la clave. [Resolución](#Ejercicio_4)

Ejercicio_1
===========
```s
.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    tabla1:  .double 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0
    tabla2:  .double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
;___________________________________________________________________
.code
    LD $s0, CONTROL($0)
    LD $s1, DATA($0)
    DADDI $s2, $0, 12       ; CANTIDAD DE ELEMENTOS
    DADDI $s3, $0, tabla1
    DADDI $s4, $0, tabla2
    DADDI $s5, $0, 3        ; IMPRIMIR UN FLOTANTE

    ;ME MUEVO EN LA TABLA
    
    LOOP: L.D F1, 0($s3)    ; ME MUEVO POR TABLA1
          L.D F2, 8($s3) 

          ; MANDO AMBOS NROS A PROMEDIAR
          JAL PROMEDIAR

          ; GUARDO EL RESULTADO DEL PROMEDIO EN TABLA2
          S.D F3, 0 ($s4)       

          ; AVANZO EN LAS TABLAS Y DISMINUYO EL CONTADOR
          DADDI $s2, $s2, -1
          DADDI $s3, $s3, 8
          DADDI $s4, $s4, 8

    BNEZ $s2, LOOP

    DADDI $a0, $0, tabla2  ; MANDO COMO PARAMETRO LA DIRECCION DE TABLA2
    JAL IMPRIMIR

HALT
;___________________________________________________________________
PROMEDIAR: ADD.D F3, F1, F2
    DADDI $t0, $0, 2
    mtc1 $t0, F4
    cvt.d.l F4, F4
    DIV.D F3,F3,F4
JR $ra
;___________________________________________________________________
IMPRIMIR: DADDI $t0, $0, 11  ; CANTIDAD DE ELEMENTOS DE tabla2

    loopImprimir: L.D F1, 0 ($a0)       ; TOMO EL ELEMENTO ACTUAL
        ; MANDO EL DATO A DATA Y EL 3 A CONTROL
        S.D F1, 0 ($s1)
        SD $s5, 0 ($s0)

        ; AVANZO A LA SIGUIENTE POSICION A IMPRIMIR
        DADDI $a0, $a0, 8
        DADDI $t0, $t0, -1
    BNEZ $t0, loopImprimir

JR $ra
;___________________________________________________________________
```

Ejercicio_2
===========
```s
.data ;leer desde teclado
    CONTROL:      .word 0x10000
    DATA:         .word 0x10008
    MENSAJE:      .asciiz " INGRESE UN CARACTER: "
    MENSAJEMAL:  .asciiz "  EL CARACTER NO ES UN DIGITO. "
    CERO:         .asciiz " CERO  "
    UNO:          .asciiz " UNO   "
    DOS:          .asciiz " DOS   "
    TRES:         .asciiz " TRES  "
    CUATRO:       .asciiz " CUATRO"
    CINCO:        .asciiz " CINCO "
    SEIS:         .asciiz " SEIS  "
    SIETE:        .asciiz " SIETE "
    OCHO:         .asciiz " OCHO  "
    NUEVE:        .asciiz " NUEVE "
    CARACTER: .byte 0
;________________________________________________________
.code
    LWU $s0, CONTROL ($0) 	; $s0 = CONTROL
    LWU $s1, DATA ($0) 	   	; $s1 = DATA
    DADDI $s4, $0, 4
    DADDI $s5, $0, MENSAJE
    DADDI $s6, $0, MENSAJEMAL
    ;_______________________________    IMPRIME MENSAJE
    SD $s5, 0($s1)        
    SD $s4, 0($s0)          
    ;_______________________________
    DADDI $sp, $0, 0x400        ; INICIALIZO EL PUNTERO A TOPE DE PILA
    JAL INGRESO
    LD $t0, CARACTER($0) 
    SLTI $t1, $t0, 0x30         ; un 1 si es menor
    DADDI $t3, $t3, 0x39
    SLT $t1, $t3,  $t0         ; un 1 si me paso
    DADDI $t4, $t4 ,1
    BEQ $t1, $t4 , MALO
    
    DADDI $a1, $0, CERO
    JAL MUESTRA
    J TERMINO
    
    MALO: SD $s6, 0($s1)              
    SD $s4, 0($s0)   
    TERMINO: HALT

;________________________________________________________
INGRESO: DADDI $sp, $sp, -8 
    SD $t7, 0 ($sp)
    ;______________________________
    DADDI $t1, $0, 9   ; LEE UN CARACTER
    SD $t1,0 ($s0)
    LBU $t1,0 ($s1)
    SB $t1, CARACTER($0)
    ; IMPRIME
    DADDI $s3, $0, CARACTER
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 
    ;_______________________________  LEE E IMPRIME EL CARACTER
    LD $t7, 0 ($sp)
    DADDI $sp, $sp, 8  
    JR $ra
;________________________________________________________
MUESTRA:  daddi $t7,$0,0x30
    LOOP: BEQ $t0, $t7, IMPRIMIR
        DADDI $t0, $t0, -1
        DADDI $a1, $a1, 8
        J LOOP

    IMPRIMIR:  SD $a1, 0($s1)              
    SD $s4, 0($s0)    
JR $ra
```
Ejercicio_3
===========
```s
.data ;leer desde teclado
    CONTROL:      .word 0x10000
    DATA:         .word 0x10008
    MENSAJE:      .asciiz "INGRESE UN NRO: "
    MENSAJE2:     .asciiz "EL RESULTADO ES: "
    RES: .word 0
    NRO: .byte 0
.code
    LWU $s0, CONTROL ($0) 	; $s0 = CONTROL
    LWU $s1, DATA ($0) 	   	; $s1 = DATA
    DADDI $s2, $s2 , 4      ; 4 IMPRIMIR UN STRING
    DADDI $s3, $s3 , 8      ; 8 LEE UN NUMERO
    DADDI $s4, $s4 , MENSAJE
    DADDI $s5, $s5 , MENSAJE2 
    DADDI $s6, $s6 , 1      ; PARA IMPRIMIR UN NUMERO
    ;_______________________________    IMPRIME MENSAJE
    SD $s4, 0($s1)               
    SD $s2, 0($s0)          
    ;_______________________________
    DADDI $sp, $0, 0x400        ; INICIALIZO EL PUNTERO A TOPE DE PILA
    JAL INGRESO   
    LD $t6, NRO($0)
    ; IMPRIMO EL MENSAJE PARA INGRESAR OTRO NUMERO
    SD $s4, 0($s1)               
    SD $s2, 0($s0)  
    
    JAL INGRESO   
    LD $t7, NRO($0)
    DADD $t6, $t6, $t7
    DADD $a0, $a0, $t6 
    JAL RESULTADO
    HALT

INGRESO: DADDI $sp, $sp, -8 
    SD $t7, 0 ($sp)
    ;______________________________
    DADDI $t1, $0, 8   ; LEE UN NRO
    SD $t1,0 ($s0)
    LBU $t1,0 ($s1)
    SB $t1, NRO($0)
    ; IMPRIME
    DADDI $s3, $0, NRO
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 
    ;_______________________________  LEE E IMPRIME EL NRO
    LD $t7, 0 ($sp)
    DADDI $sp, $sp, 8  
    JR $ra

RESULTADO: SD $s5, 0($s1) ;IMPRIMO EL MENSAJE NORMAL             
    SD $s2, 0($s0)    
    ; IMPRIMO EL RESULTADO
    SD $a0, 0 ($s1)  
    SD $s6, 0 ($s0) 
    JR $ra
```
Ejercicio_4
===========
```s
.data 
    CONTROL:       .word 0x10000
    DATA:          .word 0x10008
    CLAVE:        .asciiz 'VAMO'
    ERROR:         .asciiz ' ERROR!'
    CORRECTO:      .asciiz ' BIENVENIDO'
    MENSAJE:       .asciiz 'INGRESE UNA CLAVE: '
    INGRESADO:      .byte 0,0,0,0
.code
    LWU $s0, CONTROL($0)
    LWU $s1, DATA($0)
    DADDI $s2, $s2, 4
    DADDI $s4, $s4, 9
    ;______________________________ IMPRIME MENSAJE
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 
    ;______________________________
    DADDI $sp, $0, 0x400

    DADDI $a0, $a0, 4       ; CANTIDAD DE DIGITOS A LEER
    JAL CHAR
    DADDI $t0, $t0, 4       ; contador para el bucle :D

    DADDI $t3, $t3, 0       ;inicializo para recorrer ambos caracteres

    loopComparar: LD $t1, CLAVE($t3)    ; ME MUEVO POR AMBAS CADENAS
        LD $t2, INGRESADO($t3)
        BNE $t1, $t2 , INCORRECTO
        DADDI $t0, $t0 , -1
        DADDI $t3, $t3 , 1
    beqz $t0, loopComparar

    DADDI $t0, $0, CORRECTO  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 
    J TERMINO

    INCORRECTO: DADDI $t0, $0, ERROR  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 
TERMINO: HALT

CHAR:  LOOP: beqz $a0, FIN 
        SD $s4,0 ($s0)                ; CONTROL = 9
        LBU $t1,0 ($s1)               ; *PRESIONA UNA TECLA*
        SB $t1, INGRESADO($t9)        ; GUARDO LA VARIABLE
        DADDI $s3, $t9, INGRESADO     ; TOMO LA DIR DE INGRESADO
        SD $s3, 0 ($s1)               ; MANDO DIR DE INGRESADO
        SD $s2, 0 ($s0)               ; IMPRIMIR INGRESADO , CONTROL 4
        DADDI $a0, $a0 , -1           ; DECREMENTO MI CONTADOR
        DADDI $t9, $t9 , 1            ;AVANZO LA CLAVE
        J LOOP
    FIN: JR $ra
```
CUATRO MEDIO RARO ✍️
```s
.data 
    CONTROL:       .word 0x10000
    DATA:          .word 0x10008
    CLAVE:        .asciiz 'VAMO'
    ERROR:         .asciiz ' ERROR!'
    CORRECTO:      .asciiz ' BIENVENIDO'
    MENSAJE:       .asciiz ' \n INGRESE UNA CLAVE: '
    INGRESADO:      .byte 0,0,0,0
.code
    LWU $s0, CONTROL($0)
    LWU $s1, DATA($0)
    DADDI $s2, $s2, 4
    DADDI $s4, $s4, 9
    ;DADDI $s5, $s5, 6

    ;______________________________ IMPRIME MENSAJE
    REPETIR: SD $0, INGRESADO($0) 
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 
    ;______________________________
    DADDI $sp, $0, 0x400

    DADDI $a0, $a0, 4       ; CANTIDAD DE DIGITOS A LEER
    JAL CHAR
    DADDI $t0, $t0, 4       ; contador para el bucle :D

    DADDI $t3, $t3, 0       ;inicializo para recorrer ambos caracteres
    DADDI $t7, $0, 0
    loopComparar: LD $t1, CLAVE($t3)    ; ME MUEVO POR AMBAS CADENAS
        LD $t2, INGRESADO($t3)
        BNE $t1, $t2 , ERRONEO
        DADDI $t0, $t0 , -1
        DADDI $t3, $t3 , 1
    beqz $t0, loopComparar
    DADDI $t7, $0, 1           ; PARA PASAR LOS PARAMETROS EN CORRECTO
    J CONTINUAR
    
    ERRONEO: DADDI $t7, $0, 0

    CONTINUAR: JAL RESPUESTA
    
    J REPETIR
    
TERMINO: HALT

CHAR: DADDI $t9, $0 , 0
    LOOP: beqz $a0, FIN 
        SD $s4,0 ($s0)                ; CONTROL = 9
        LBU $t1,0 ($s1)               ; *PRESIONA UNA TECLA*
        SB $t1, INGRESADO($t9)        ; GUARDO LA VARIABLE
        DADDI $s3, $t9, INGRESADO     ; TOMO LA DIR DE INGRESADO
        SD $s3, 0 ($s1)               ; MANDO DIR DE INGRESADO
        SD $s2, 0 ($s0)               ; IMPRIMIR INGRESADO , CONTROL 4
        DADDI $a0, $a0 , -1           ; DECREMENTO MI CONTADOR
        DADDI $t9, $t9 , 1            ;AVANZO LA CLAVE
        J LOOP
    FIN: JR $ra

RESPUESTA: beqz $t7, INCORRECTO

    DADDI $t0, $0, CORRECTO  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 
    J FIN2

    INCORRECTO: DADDI $t0, $0, ERROR  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 

    FIN2: JR $ra
```
