<h1 align="center"> 💻Ejercicios Random</h1>

```1)``` Escribir un programa para Winmips que lea un arreglo (tabla) de N datos en punto flotante almacenados en la memoria, y genere un segundo arreglo  (tabla2) cuyos N-1 elementos sean el promedio de cada par de datos consecutivos del arreglo original. Es decir, el primer elemento de tabla2 debera ser el promedio entre los elementos 1 y 2 de tabla1, el segundo elemento de tabla2 deberpa ser el promedio entre los elementos 2 y 3 de tabla1, etc. El calculo del promedio se debe realizar en una subrutina. El arreglo tabla2 debe quedar almacenado en memoria a continuación de tabla1. Una vez generado el arreglo tabla2, todos sus elementos deben visualizarse en la pantalla terminal del simulador. Esto debe implementarse a través de otra subrutina que reciba como parámetro la dirección inicial del arreglo. Considerar N = 12 (10 puntos) [Resolución](#Ejercicio_1)

```2)``` Escriba un programa que utilice sucesivamente dos subrutinas: La primera, denominada ingreso, debe solicitar el ingreso por teclado de un número entero (de un dígito), verificando que el valor ingresado realmente sea un dígito. La segunda, denominada muestra, deberá mostrar en la salida estándar del simulador (ventana Terminal) el valor del número ingresado expresado en letras (es decir, si se ingresa un ‘4’, deberá mostrar ‘CUATRO’).  [Resolución](#Ejercicio_2)

```3)``` Escriba un programa que realice la suma de dos números enteros (de un dígito cada uno) utilizando dos subrutinas: La denominada ***ingreso*** del ejercicio anterior (ingreso por teclado de un dígito numérico) y otra denominada ***resultado***, que muestre en la salida estándar del simulador (ventana Terminal) el resultado numérico de la suma de los dos números ingresados. [Resolución](#Ejercicio_3)

```4)``` Escriba un programa que solicite el ingreso por teclado de una clave (sucesión de cuatro caracteres) utilizando la subrutina ***char*** de ingreso de un carácter. Luego, debe comparar la secuencia ingresada con una cadena almacenada en la variable ***clave***. Si las dos cadenas son iguales entre si, la subrutina llamada ***respuesta*** mostrará el texto ***“Bienvenido”*** en la salida estándar del simulador (ventana Terminal). En cambio, si las cadenas no son iguales, la subrutina deberá mostrar ***“ERROR”*** y solicitar nuevamente el ingreso de la clave. [Resolución](#Ejercicio_4)

```5)``` Escribir un programa que multiplique dos numeros enteros almacenados en memoria (sin utilizar la instruccion DMUL), mediante sumas sucesivas y almacene el resultado en memoria. [Resolución](#Ejercicio_5)

```6)``` Escribir un programa que busque un valor existente en la posicion de memoria ***BUSCAR*** en una ***TABLA*** de cantidad de elementos indicada en la posición de memoria ***LONG***. Si se encuentra el valor en la tabla debe cargarse el valor en R10, caso contrario debe cargarse 0 [Resolución](#Ejercicio_6)

```7)``` Escribir un programa que recorra una ***TABLA*** de cantidad de elementos indicada en la posición de memoria ***LONG*** y genere otra a partir de las posiciones de memoria IMPARES que contenga todos los elementos impares de ***TABLA*** [Resolución](#Ejercicio_7)

```8)```Escribir un programa que lea 3 números enteros (A,B y C) ingresados por el usuario desde teclado, realice un calculo aritmético y almacene el resultado en la memoria en la variable ***RESUL***. para mostrar el resultado en la pantalla alfanumerica. [Resolución](#Ejercicio_8)

OPCIONES:

```a)``` El calculo aritmetico es  (A+B) elevado a la C, en este caso debe hacer 2 subrutinas: una para el ingreso de los números y otra para mostrar el resultado en la pantalla alfanumerica

```b)``` El calculo aritmetico es (A+B) x C, en este caso debe hacer dos subrutinas, una para el ingreso de los numeros y otra para realizar el calculo.

```c)``` El calculo aritmetico es (A-B) / C, en este caso se deben hacer dos subrutinas, una para realizar el calculo y otra para mostrar el resultado en la pantalla

```9)``` Implementar un programa que produzca una salida estableciendo el color de un punto de la pantalla gráfica (en la ventana Terminal del simulador WinMIPS64). Y que las coordenadas y color del punto sean ingresados por teclado [Resolución](#Ejercicio_9)


```10)``` Escriba una subrutina que reciba como parámetros un número positivo M de 64 bits, la dirección del comienzo de una tabla que contenga valores numéricos de 64 bits sin signo y la cantidad de valores almacenados en dicha tabla. La subrutina debe retornar la cantidad de valores mayores que M contenidos en la tabla. [Resolución](#Ejercicio_10)

```11)``` Escriba una subrutina que reciba como parámetros las direcciones del comienzo de dos cadenas terminadas en cero y retorne la posición en la que las dos cadenas difieren. En caso de que las dos cadenas sean idénticas, debe retornar -1. [Resolución](#Ejercicio_11)

```12)``` Escriba la subrutina ES_VOCAL, que determina si un carácter es vocal o no, ya sea mayúscula o minúscula. La rutina debe recibir el carácter y debe retornar el valor 1 si el carácter es una vocal, o 0 en caso contrario. [Resolución](#Ejercicio_12)

```13)``` Usando la subrutina escrita en el ejercicio anterior, escribir la subrutina ***CONTAR_VOC***, que recibe una cadena terminada en cero , y devuelve la cantidad de vocales que tiene esa cadena. [Resolución](#Ejercicio_13)

```14)``` Escribir un programa que solicite el ingreso de una cadena de caracteres por teclado que finalice al leer el caracter 0. Luego, el programa debe imprimir la cadena ingresada al derecho y al revés. [Resolución](#Ejercicio_14)

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
    CERO:         .ascii " CERO"
    UNO:          .ascii " UNO"
    DOS:          .ascii " DOS"
    TRES:         .ascii " TRES"
    CUATRO:       .ascii " CUATRO"
    CINCO:        .ascii " CINCO"
    SEIS:         .ascii " SEIS"
    SIETE:        .ascii " SIETE"
    OCHO:         .ascii " OCHO"
    NUEVE:        .ascii " NUEVE"
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
INGRESO: DADDI $t1, $0, 9   ; LEE UN CARACTER
    SD $t1,0 ($s0)
    LBU $t1,0 ($s1)
    SB $t1, CARACTER($0)
    ; IMPRIME
    DADDI $s3, $0, CARACTER
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 
    ;_______________________________  LEE E IMPRIME EL CARACTER
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
    LWU $s0, CONTROL ($0) 	    ; $s0 = CONTROL
    LWU $s1, DATA ($0) 	   	    ; $s1 = DATA
    DADDI $s2, $s2 , 4          ; 4 IMPRIMIR UN STRING
    DADDI $s3, $s3 , 8          ; 8 LEE UN NUMERO
    DADDI $s4, $s4 , MENSAJE
    DADDI $s5, $s5 , MENSAJE2 
    DADDI $s6, $s6 , 2          ; PARA IMPRIMIR UN NUMERO
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

    DADD $a0, $0, $t6

    ;DADDI $a0, $0, -1 
    JAL RESULTADO
    HALT

INGRESO: DADDI $t1, $0, 8   ; LEE UN NRO
    SD $t1,0 ($s0)
    LD $t1,0 ($s1)
    SD $t1, NRO($0)
    ; IMPRIME
    DADD $s3, $0, $t1
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 
    ;_______________________________  LEE E IMPRIME EL NRO
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
    MENSAJE:       .asciiz ' \n INGRESE UNA CLAVE: '
    INGRESADO:      .byte 0,0,0,0
.code
    LWU $s0, CONTROL($0)
    LWU $s1, DATA($0)
    DADDI $s2, $0, 4
    DADDI $s4, $0, 9
    ;______________________________ IMPRIME MENSAJE
    REPETIR: SD $0, INGRESADO($0) 
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)             
    SD $s2, 0($s0) 
    ;______________________________
    DADDI $sp, $0, 0x400

    DADDI $a0, $a0, 4       ; CANTIDAD DE DIGITOS A LEER

    DADDI $t9, $0 , 0
    LOOP: beqz $a0, FIN     ; LECTURA DE A UN DIGITO :d
        JAL CHAR
        DADDI $a0, $a0 , -1           ; DECREMENTO MI CONTADOR
    J LOOP

    ;______________________________
    FIN: DADDI $t0, $t0, 4       ; contador para el bucle :D

    DADDI $t3, $0, 0       ;inicializo para recorrer ambos caracteres
    DADDI $t7, $0, 0

    LD $t1, CLAVE($t3)    ; ME MUEVO POR AMBAS CADENAS
    LD $t2, INGRESADO($t3)
    BNE $t1, $t2 , ERRONEO
    DADDI $t0, $t0 , -1
    
    DADDI $t7, $0, 1           ; PARA PASAR LOS PARAMETROS EN CORRECTO
    J CONTINUAR
    
    ERRONEO: DADDI $t7, $0, 0

    CONTINUAR: JAL RESPUESTA
    J REPETIR
    
TERMINO: HALT

CHAR: SD $s4,0 ($s0)                ; CONTROL = 9
        LBU $t1,0 ($s1)               ; *PRESIONA UNA TECLA*
        SB $t1, INGRESADO($t9)        ; GUARDO LA VARIABLE
        DADDI $s3, $t9, INGRESADO     ; TOMO LA DIR DE INGRESADO
        SD $s3, 0 ($s1)               ; MANDO DIR DE INGRESADO
        SD $s2, 0 ($s0)               ; IMPRIMIR INGRESADO , CONTROL 4
        
        DADDI $t9, $t9 , 1            ;AVANZO LA CLAVE
    JR $ra

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

Ejercicio_5
===========
```s
.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008

    NUMERO1: .word -50
    NUMERO2: .word -2
    RES: .word 0
    MASC: .word 0xffffffffffffffff
.code
    LD $s0, CONTROL ($0)
    LD $s1, DATA ($0)
    DADDI $s2, $0, 2

    LD $t1, NUMERO1 ($0)     
    LD $t2, NUMERO2 ($0)

    ;-----------------------------
    slti $t0, $t1, 0
    beqz $t0, JUMP
    daddi $t4, $0, 1
    dadd $a0, $t1, $0
    jal CA2
    dadd $t1, $v0, $0
    ;-----------------------------

    JUMP: DADD $t3, $t3, $t2 
        DADDI $t1, $t1 , -1
    BNEZ $t1, JUMP

    ;-----------------------------
    beqz $t4, FIN
    dadd $a0, $t3, $0
    jal CA2
    dadd $t3, $v0, $0
    ;-----------------------------

    FIN: SD $t3, RES($0)
    SD $t3, 0 ($s1)
    SD $s2, 0 ($s0)
HALT

CA2:        ld $t0, MASC($0)  ;  MASC: .word 0xffffffffffffffff
            xor $v0, $a0, $t0
            daddi $v0, $v0, 1
            jr $ra

```
Ejercicio_6
===========
```s
.data
    TABLA:    .word 1,2,3,4,5,6,7
    BUSCAR:   .word 4
    LONG:     .word 7
.code
    LD $s0, LONG($0)
    DADDI $s1,$s1, TABLA
    LD $s2, BUSCAR($0)
    LOOP: LD $t0, 0($s1)
        BEQ $t0, $s2, IGUAL
        DADDI $s1, $s1, 8
        DADDI $s0, $s0, -1
    BNEZ $s0, LOOP
    DADDI R10,$0,0
    J FIN
    IGUAL: DADDI R10,R0,1
FIN: HALT
```
Ejercicio_7
===========
```s
                .data
TABLA:          .word 7, 8, 9, 99, 10
LONG:           .word 5
IMPARES:        .word 0

                .text
                daddi $s0, $0, TABLA
                ld $s1, LONG($0)
                daddi $s2, $0, IMPARES
                
                
LOOP:           beqz $s1, FIN
                ld $t1, 0($s0)
                daddi $s0, $s0, 8
                daddi $s1, $s1, -1
                andi $t2, $t1, 1
                beqz $t2, LOOP
                sd $t1, 0($s2)
                daddi $s2, $s2, 8
                j LOOP
FIN: halt
```
Ejercicio_8
===========
```s
.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    A: .word 0
    B: .word 0
    C: .word 0
    RESUL: .word 0
    MENSAJE:      .asciiz " INGRESE UN NUMERO: "

.code
    LD $s0, CONTROL ($0)    
    LD $s1, DATA ($0)
    DADDI $s2, $s2, 2           ; MOSTRAR ENTERO
    DADDI $s3, $s3, 4           ; IMPRIMIR
    DADDI $s4, $s4, MENSAJE
    DADDI $s5, $s5, 8           ; LEER

            daddi $t0, $0, 0
            daddi $t2, $0, 24
LECTURA:    SD $s4, 0($s1)              
            SD $s3, 0($s0)

            SD $s5, 0 ($s0)             
            LD $t1, 0 ($s1)             
            SD $t1, A($t0)
            daddi $t0, $t0, 8
            bne $t0, $t2, LECTURA


    DADDI $t0, $0, 0
    ld $t1, A($0) 
    ld $t2, B($0) 
    DADD $t4, $t1, $t2      ; A + B
    
 
    ld $t3, C($0)
    DADDI $t0, $t0 ,1
    LOOP: BEQZ $t3, TERMINO
        dmul $t0, $t0, $t4  
        DADDI $t3, $t3, -1        
    J LOOP

    TERMINO: SD $t0, RESUL ($0) 
    SD $t0, 0 ($s1)         
    SD $s2, 0 ($s0)

HALT

```

Ejercicio_9
===========
```s
.data
    coorX:      .byte 0
    coorY:      .byte 0
    color:      .byte 0, 0, 0, 0; 
    CONTROL:    .word32 0x10000
    DATA:       .word32 0x10008
    MENSAJE1:   .asciiz "INGRESE X: "
    MENSAJE2:   .asciiz "INGRESE Y: "
    MENSAJE3:   .asciiz "INGRESE (R,G,B,TRANSPARENCIA) : "

.code
    LWU $s6, CONTROL($zero)
    LWU $s7, DATA($zero)
    DADDI $s0, $s0, 4           ; PARA IMPRIMIR UN STRING
    DADDI $s1, $s1, 8           ; LEER UN ENTERO DESDE TECLADO
    DADDI $s2, $s2, 7           ; LIMPIAR LA PANTALLA
    DADDI $s3, $s3, 5           ; PINTAR UN PIXEL

    ;__________________________________
    DADDI $t0, $0, MENSAJE1 
    SD $t0, 0 ($s7) 
    SD $s0, 0 ($s6) 

    SB $s1, 0($s6) 
    LBU $t2, 0($s7) 
    SB $t2, coorX($0)
    ;__________________________________    
    DADDI $t0, $0, MENSAJE2 
    SD $t0, 0 ($s7) 
    SD $s0, 0 ($s6) 

    SB $s1, 0($s6) 
    LBU $t3, 0($s7) 
    SB $t3, coorY($0)
    ;__________________________________
    
    DADDI $a0, $0, 4    ;CONTADORES PARA LEER
    DADDI $t0, $0, 0
    LOOP: DADDI $t1, $0, MENSAJE3
        SD $t1, 0 ($s7)
        SD $s0, 0 ($s6)

        SB $s1, 0($s6) 
        LBU $t3, 0($s7) 
        SB $t3, color($t0)
        DADDI $t0, $t0, 1
        DADDI $a0, $a0, -1   ;AVANZO AL SIGUIENTE BYTE
    bnez $a0,LOOP
    ;__________________________________

    SD $s2, 0($s6)      ; LIMPIO LA PANTALLA
    
    LBU $s0, coorX($zero)
    SB $s0, 5($s7)

    LBU $s1, coorY($zero)
    SB $s1, 4($s7)

    LWU $s2, color($zero)
    sw $s2, 0($s7)
    
    SD $s3, 0($s6)       ; IMPRIMIR EL CARACTER
HALT
```
Ejercicio_10
============
```s
.data
    M: .word 3
    TABLA: .word 1,2,3,4,5
    RESULTADO: .word 0
.code
    ld $a0, M(r0)           ; a0 = 14
    daddi $a1, $0, 5        ; a1 = cantidad de elementos
    daddi $a2, $0, TABLA    ; a2 = paso la direccion de TABLA
    jal VALORES             ; salto a la rutina y guardo la direccion de retorno
    nop                     ; pinto
    sd $v0, RESULTADO($0)   ; VALORES de retorno de la subrutina, lo guardo en RESULTADO
    halt

VALORES: dadd $t0, $a1, $0              ; guardo 5 en el registro temporal
    dadd $v0, $0, $0                    ; inicializo v0
    LOOP: ld $t4, 0($a2)                ; copia en el registro temporal el primer elemento de la TABLA
        slt $t2, $t4, $a0               ; si t4 es menor que a0, entonces dejo 1 en t2
        bnez $t2 ,NO_INCREMENTAR        ; si t2 <> 0 entonces salto a NO_INCREMENTAR
        beq $t4, $a0, NO_INCREMENTAR    ; Si es igual, no incremento
        daddi $v0, $v0, 1               ; aumento el contador 
    NO_INCREMENTAR: daddi $a2, $a2, 8   ; avanzo en la tabla
        daddi $t0, $t0, -1              ; decremento el contador de elementos de tabla
        bnez $t0, LOOP                  ; si t0 <> 0 salto a loop
        jr $ra                          ; vuelve al programa principal

```
Ejercicio_11
============
```s
.data
    CADENA1: .asciiz "hola"
    CADENA2: .asciiz "holaa"
    result:  .word 0
.code
    daddi $a0, $0, CADENA1      ; a0 = CADENA1
    daddi $a1, $0, CADENA2      ; a1 = CADENA2
    jal compara                 ; Llamo a la subrutina
    sd $v0, result($zero)       ; guardo el valor
halt

compara: dadd $v0, $0, $0   ; inicializo V0
    LOOP: lbu $t0, 0($a0)   ; COPIA LA DIRECCION DE CADENA1
        lbu $t1, 0($a1)     ; COPIA LA DIRECCION DE CADENA2
        beqz $t0, FIN_CAD1  ; SI LLEGO AL FINAL DE CADENA1, SALTO
        beqz $t1, FIN       ; SI LLEGO AL FINAL DE CADENA2, SALTO
        bne $t0, $t1, FIN   ; SI EL CARACTER ACTUAL DE CADENA1 <> CARACTER ACTUAL CADENA2, TERMINO
        
        daddi $v0, $v0, 1       ; INCREMENTO
        daddi $a0, $a0, 1       ; INCREMENTO
        daddi $a1, $a1, 1       ; INCREMENTO
    j LOOP

    FIN_CAD1: bnez $t1, FIN     ; SI T1 <> 0, TERMINO
        daddi $v0, $0, -1
    FIN: jr $ra

```
Ejercicio_12
============
```s
.data
    LETRA: .ascii '1'
    VOCALES: .asciiz 'AEIOUaeiou'
    RESULTADO: .word 0
.code
    lbu $a0, LETRA($0)          ; paso el CARACTER
    jal ES_VOCAL                ; llamo a la subrutina
    sd $v0, RESULTADO($zero)    ; guardo el resultado
halt

ES_VOCAL:   dadd $v0, $0, $0                ; inicializo v0
            daddi $t0, $0, 0                ; inicializo t0
            LOOP: lbu $t1, VOCALES($t0)     ; copia el  caracter en t1
                beqz $t1, FIN_VOCAL         ; si t1 = 0, no se encontro VOCALES
                beq $a0, $t1, ENCONTRO      ; si LETRA = caracterActual, salto
                daddi $t0, $t0, 1           ; continuo con el siguiente caracter
            j LOOP

            ENCONTRO: daddi $v0, $0, 1      ; si es vocal, retorno 1
            
            FIN_VOCAL: jr $ra               ;vuelvo al programa principal

```
Ejercicio_13
============
```s
.data
    CADENA: .asciiz "CazaAAA"
    VOCALES: .asciiz 'AEIOUaeiou'
    CANT: .word 0
.code
    ; La pila comienza en el tope de la memoria de datos
    DADDI $sp, $0, 0x400            ; bus 10 bits 🡪 2^10 = 1024 = 0x400

    ; Guarda como primer argumento para CONT_VOCALES
    ; la dirección de CADENA

    DADDI $a0, $0, CADENA
    dadd $v0, $0, $0  
    JAL CONT_VOCALES
    sd $v0, CANT($0)                  ; Cantidad de caracteres
HALT

CONT_VOCALES: DADDI $sp, $sp, -16     ; Reserva lugar en pila -> 2 x 8
    SD $ra, 0 ($sp)                   ; Guarda en pila $ra
    SD $s0, 8 ($sp)                   ; Guarda en pila $s0

    DADD $s0, $a0, $0                 ; Copia la dirección de inicio de la CADENA
    LOOP: LBU $a0, 0 ($s0)	        ; Toma car. actual
        BEQ $a0, $zero, FIN         ; Si es el fin, termina
        JAL ES_VOCAL
        DADDI $s0, $s0, 1           ; Avanza al siguiente caracter
    J LOOP

    ; Recupera los datos salvados en la pila
    FIN: LD $ra, 0 ($sp)
        LD $s0, 8 ($sp)
        DADDI $sp, $sp, 16
    JR $ra




ES_VOCAL: daddi $t0, $0, 0                    ; inicializo t0
    LOOP2: lbu $t1, VOCALES($t0)     ; copia el  caracter en t1
        beqz $t1, FINVOCAL         ; si t1 = 0, no se encontro VOCALES
        beq $a0, $t1, ENCONTRO      ; si LETRA = caracterActual, salto
        daddi $t0, $t0, 1           ; continuo con el siguiente caracter
    j LOOP2

    ENCONTRO: daddi $v0, $v0, 1      ; si es vocal, aumento 1 el contador
    FINVOCAL: jr $ra               ;vuelvo al programa principal             

```
Ejercicio_14
============
```s
                .data
CONTROL:        .word32 0x10000
DATA:           .word32 0x10008
MSJ:            .asciiz "Ingrese un mensaje terminado en 0: \n"
CAR:            .asciiz ""
TXT:            .asciiz ""

                .text
                lwu $s6, CONTROL($0)
                lwu $s7, DATA($0)

                jal cargarMSJ
                DADDI $a0, $v0, 0
                jal imprimirDerecho
                jal imprimirAlrevez
halt

cargarMSJ:      DADDI $t0, $0, MSJ
                sd $t0, 0($s7)
                DADDI $t1, $0, 4
                sd $t1, 0($s6)
                DADDI $t4, $0, 48
                DADDI $t0, $0, TXT
                DADDI $t2, $0, 9

loop:           sd $t2, 0($s6)
                lbu $t3, 0($s7)
                beq $t3, $t4, fin
                sb $t3, 0($t0)
                sd $t0, 0($s7)
                sd $t1, 0($s6)
                DADDI $t0, $t0, 1
                j loop
fin:            DADDI $t1, $0, TXT
                dsub $v0, $t0, $t1
                jr $ra

imprimirDerecho: DADDI $t0, $0, TXT
                sd $t0, 0($s7)
                DADDI $t0, $0, 4
                sd $t0, 0($s6)
                jr $ra

imprimirAlrevez: DADDI $t0, $0, TXT
                dadd $t0, $t0, $a0
                DADDI $t0, $t0, -1
                DADDI $t1, $0, 4
                DADDI $t3, $0, CAR
                sd $t3, 0($s7)
loop2:          lbu $t2, 0($t0)
                sb $t2, 0($t3)
                sd $t1, 0($s6)
                DADDI $t0, $t0, -1
                DADDI $a0, $a0, -1
                bnez $a0, loop2
                jr $ra
```
