<h1 align="center"> 💻Practica 6</h1>

<h1 align="center"> Procesador RISC: utilizando la E/S</h1>

```1)``` El siguiente programa produce la salida de un mensaje predefinido en la ventana Terminal del simulador WinMIPS64. [Resolución](#Ejercicio_1)

Teniendo en cuenta las condiciones de control del puerto de E/S (en el resumen anterior), modifique el programa de modo que el mensaje a mostrar sea ingresado por teclado en lugar de ser un mensaje fijo.

```s
.data
    texto: .asciiz "Hola, Mundo!" ; El mensaje a mostrar
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
.text
    lwu $s0, DATA($zero)        ; $s0 = dirección de DATA
    daddi $t0, $zero, texto     ; $t0 = dirección del mensaje a mostrar
    sd $t0, 0($s0)              ; DATA recibe el puntero al comienzo del mensaje
    lwu $s1, CONTROL($zero)     ; $s1 = dirección de CONTROL
    daddi $t0, $zero, 6         ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
    sd $t0, 0($s1)              ; CONTROL recibe 6 y limpia la pantalla
    daddi $t0, $zero, 4         ; $t0 = 4 -> función 4: salida de una cadena ASCII
    sd $t0, 0($s1)              ; CONTROL recibe 4 y produce la salida del mensaje
    halt
```

```2)``` Escriba un programa que utilice sucesivamente dos subrutinas: La primera, denominada ***ingreso***, debe solicitar el ingreso por teclado de un número entero (de un dígito), verificando que el valor ingresado realmente sea un dígito. La segunda, denominada ***muestra***, deberá mostrar en la salida estándar del simulador (ventana Terminal) el valor del número ingresado expresado en letras (es decir, si se ingresa un ***‘4’***, deberá mostrar ‘CUATRO’). Establezca el pasaje de parámetros entre subrutinas respetando las convenciones para el uso de los registros y minimice las detenciones del cauce (ejercicio similar al ejercicio 6 de Práctica 2). [Resolución](#Ejercicio_2)

```3)``` Escriba un programa que realice la suma de dos números enteros (de un dígito cada uno) utilizando dos subrutinas: La denominada ***ingreso*** del ejercicio anterior (ingreso por teclado de un dígito numérico) y otra denominada ***resultado***, que muestre en la salida estándar del simulador (ventana Terminal) el resultado numérico de la suma de los dos números ingresados (ejercicio similar al ejercicio 7 de Práctica 2). [Resolución](#Ejercicio_3)

```4)``` Escriba un programa que solicite el ingreso por teclado de una clave (sucesión de cuatro caracteres) utilizando la subrutina ***char*** de ingreso de un carácter. Luego, debe comparar la secuencia ingresada con una cadena almacenada en la variable ***clave***. Si las dos cadenas son iguales entre si, la subrutina llamada ***respuesta*** mostrará el texto ***“Bienvenido”*** en la salida estándar del simulador (ventana Terminal). En cambio, si las cadenas no son iguales, la subrutina deberá mostrar ***“ERROR”*** y solicitar nuevamente el ingreso de la clave. [Resolución](#Ejercicio_4)


```5)``` Escriba un programa que calcule el resultado de elevar un valor en punto flotante a la potencia indicada por un exponente que es un número entero positivo. Para ello, en el programa principal se solicitará el ingreso de la base (un número en punto flotante) y del exponente (un número entero sin signo) y se deberá utilizar la subrutina ***a_la_potencia*** para calcular el resultado pedido (que será un valor en punto flotante). Tenga en cuenta que cualquier base elevada a la 0 da como resultado 1. Muestre el resultado numérico de la operación en la salida estándar del simulador (ventana Terminal). [Resolución](#Ejercicio_5)

```6)``` El siguiente programa produce una salida estableciendo el color de un punto de la pantalla gráfica (en la ventana Terminal del simulador WinMIPS64). Modifique el programa de modo que las coordenadas y color del punto sean ingresados por teclado. [Resolución](#Ejercicio_6)

```s
data
    coorX: .byte 24                 ; coordenada X de un punto
    coorY: .byte 24                 ; coordenada Y de un punto
    color: .byte 255, 0, 255, 0     ; color: máximo rojo + máximo azul => magenta
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
.text
    lwu $s6, CONTROL($zero)         ; $s6 = dirección de CONTROL
    lwu $s7, DATA($zero)            ; $s7 = dirección de DATA
    daddi $t0, $zero, 7             ; $t0 = 7 -> función 7: limpiar pantalla gráfica
    sd $t0, 0($s6)                  ; CONTROL recibe 7 y limpia la pantalla gráfica
    lbu $s0, coorX($zero)           ; $s0 = valor de coordenada X
    sb $s0, 5($s7)                  ; DATA+5 recibe el valor de coordenada X
    lbu $s1, coorY($zero)           ; $s1 = valor de coordenada Y
    sb $s1, 4($s7)                  ; DATA+4 recibe el valor de coordenada Y
    lwu $s2, color($zero)           ; $s2 = valor de color a pintar
    sw $s2, 0($s7)                  ; DATA recibe el valor del color a pintar
    daddi $t0, $zero, 5             ; $t0 = 5 -> función 5: salida gráfica
    sd $t0, 0($s6)                  ; CONTROL recibe 5 y produce el dibujo del punto
    halt
```

```7)``` Se desea realizar la demostración de la transformación de un carácter codificado en ASCII a su visualización en una matriz de puntos con 7 columnas y 9 filas. Escriba un programa que realice tal demostración, solicitando el ingreso por teclado de un carácter para luego mostrarlo en la pantalla gráfica de la terminal. [Resolución](#Ejercicio_7)

El "8" se representa como: 

![image](https://user-images.githubusercontent.com/55964635/141034358-d29c5f5e-4f04-480c-8885-0219aca8140a.png)

```8)``` El siguiente programa implementa una animación de una pelotita rebotando por la pantalla. Modifíquelo para que en lugar de una pelotita, se muestren simultáneamente varias pelotitas (cinco, por ejemplo), cada una con su posición, dirección y color particular. [Resolución](#Ejercicio_8)

```s
.data
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
    color_pelota: .word32 0x00FF0000        ; Azul
    color_fondo: .word32 0x00FFFFFF         ; Blanco
.text
    lwu $s6, CONTROL($zero)
    lwu $s7, DATA($zero)
    lwu $v0, color_pelota($zero)
    lwu $v1, color_fondo($zero)
    daddi $s0, $zero, 23                    ; Coordenada X de la pelota
    daddi $s1, $zero, 1                     ; Coordenada Y de la pelota
    daddi $s2, $zero, 1                     ; Dirección X de la pelota
    daddi $s3, $zero, 1                     ; Dirección Y de la pelota
    daddi $s4, $zero, 5                     ; Comando para dibujar un punto

loop: sw $v1, 0($s7) ; Borra la pelota
    sb $s0, 4($s7)
    sb $s1, 5($s7)
    sd $s4, 0($s6)
    dadd $s0, $s0, $s2                      ;Mueve la pelota en la dirección actual
    dadd $s1, $s1, $s3
    daddi $t1, $zero, 48                    ; Comprueba que la pelota no esté en la columna de más
    slt $t0, $t1, $s0                       ; a la derecha. Si es así, cambia la dirección en X.
    dsll $t0, $t0, 1
    dsub $s2, $s2, $t0
    slt $t0, $t1, $s1                       ; Comprueba que la pelota no esté en la fila de más arriba.
    dsll $t0, $t0, 1                        ; Si es así, cambia la dirección en Y.
    dsub $s3, $s3, $t0
    slti $t0, $s0, 1                        ; Comprueba que la pelota no esté en la columna de más
    dsll $t0, $t0, 1                        ; a la izquierda. Si es así, cambia la dirección en X.
    dadd $s2, $s2, $t0
    slti $t0, $s1, 1                        ; Comprueba que la pelota no esté en la fila de más abajo.
    dsll $t0, $t0, 1                        ; Si es así, cambia la dirección en Y.
    dadd $s3, $s3, $t0
    sw $v0, 0($s7)                          ; Dibuja la pelota.
    sb $s0, 4($s7)
    sb $s1, 5($s7)
    sd $s4, 0($s6)
    daddi $t0, $zero, 500                   ; Hace una demora para que el rebote no sea tan rápido.
demora: daddi $t0, $t0, -1                  ; Esto genera una infinidad de RAW y BTS pero...
    bnez $t0, demora                        ; ¡hay que hacer tiempo igualmente!
    j loop
```

```9)``` Escriba un programa que le permita dibujar en la pantalla gráfica de la terminal. Deberá mostrar un cursor (representado por un punto de un color particular) que pueda desplazarse por la pantalla usando las teclas ‘a’, ‘s’, ‘d’ y ‘w’ para ir a la izquierda, abajo, a la derecha y arriba respectivamente. Usando la barra espaciadora se alternará entre modo desplazamiento (el cursor pasa por arriba de lo dibujado sin alterarlo) y modo dibujo (cada punto por el que el cursor pasa quedará pintado del color seleccionado). Las teclas del ‘1’ al ‘8’ se usarán para elegir uno entre los ocho colores disponibles para pintar. [Resolución](#Ejercicio_9)

```Observaciones: ``` Para poder implementar este programa, se necesitará almacenar en la memoria la imagen completa de la
pantalla gráfica. 

Si cada punto está representado por un byte, se necesitarán 50x50x1 = 2500 bytes. El simulador WinMIPS64 viene configurado para usar un bus de datos de 10 bits, por lo que la memoria disponible estará acotada a 2^10=1024 bytes. Para poder almacenar la imagen, será necesario configurar el simulador para usar un bus de datos de 12 bits, ya que 2^12=4096 bytes, los que si resultarán suficientes. La configuración se logra yendo al menú “Configure -> Architecture” y poniendo “Data Address Bus” en 12 bits en lugar de los 10 bits que trae por defecto.

![image](https://user-images.githubusercontent.com/55964635/141035436-6e5567fe-2165-4925-9c18-b1481c46473c.png)

Ejercicio_1
===========
```s
.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    CARACTER: .byte 0
.code
    LWU $s0, CONTROL($0)
    LWU $s1, DATA($0)
    
    DADDI $s4, $0, 13       ; 13 el ascii del enter pá

    LOOP: DADDI $t1, $0, 9
        SD $t1,0 ($s0)      ; CONTROL = 9

        ; *PRESIONA UNA TECLA*
        ; LA CPU GUARDA EL CARACTER EN DATA

        LBU $t1,0 ($s1)

        ; COMPARO CON EL ENTER
        BEQ $t1, $s4, FIN

        ; GUARDO LA VARIABLE
        SB $t1, CARACTER($0)

        ;TOMO LA DIR DE CARACTER
        DADDI $s3, $0, CARACTER

        ; MANDO DIR DE CARACTER
        SD $s3, 0 ($s1)

        ; IMPRIMIR CARACTER
        DADDI $t1, $0, 4
        SD $t1, 0 ($s0) ; CONTROL 4

        J LOOP
FIN: HALT
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
.code
    LWU $s0, CONTROL ($0) 	; $s0 = CONTROL
    LWU $s1, DATA ($0) 	   	; $s1 = DATA
    ;_______________________________    IMPRIME MENSAJE
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)          
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
    
    
    
    MALO: DADDI $t0, $0, MENSAJEMAL  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)   

    TERMINO: HALT


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

MUESTRA:  daddi $t7,$0,0x30
    LOOP: BEQ $t0, $t7, IMPRIMIR
        DADDI $t0, $t0, -1
        DADDI $a1, $a1, 8
        J LOOP

    IMPRIMIR:  SD $a1, 0($s1)        
    DADDI $t1, $0, 4        
    SD $t1, 0($s0)    
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
    ;_______________________________    IMPRIME MENSAJE
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)          
    ;_______________________________
    DADDI $sp, $0, 0x400        ; INICIALIZO EL PUNTERO A TOPE DE PILA

    JAL INGRESO   

    LD $t6, NRO($0)
    

    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0) 
    
    JAL INGRESO   
    LD $t7, NRO($0)
    
    DADD $t6, $t6, $t7
    

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

RESULTADO: DADDI $t0, $0, MENSAJE2  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)    

    DADDI $t6, $t6 , 0x30   ; PARA IMPRIMIR EL ASCII DEL NRO
    SD $t6, RES ($0)  

    DADDI $s3, $0, RES
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 

    JR $ra
```


Ejercicio_4
===========
```s
.data 
    CONTROL:       .word 0x10000
    DATA:          .word 0x10008
    CONTRA:        .asciiz 'VAMOO'
    ERROR:         .asciiz ' ERROR!'
    CORRECTO:      .asciiz ' BIENVENIDO'
    MENSAJE:       .asciiz 'INGRESE UNA CONTRA: '
    CARACTER:      .byte 0
.code
    LWU $s0, CONTROL($0)
    LWU $s1, DATA($0)
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0) 
    
    DADDI $sp, $0, 0x400
    JAL CHAR
HALT


CHAR: daddi $t6, $0, 0           ;CONTADOR PARA CARACTERES
    LOOP: DADDI $t1, $0, 9
        SD $t1,0 ($s0)      ; CONTROL = 9

        
        ; *PRESIONA UNA TECLA*
        ; LA CPU GUARDA EL CARACTER EN DATA

        LBU $t1,0 ($s1)

        DADD $t7, $0, $t1       ;MANDO MI CARACTER A UN REGISTRO PARA COMPARAR
        ; GUARDO LA VARIABLE
        SB $t1, CARACTER($0)

        ;TOMO LA DIR DE CARACTER
        DADDI $s3, $0, CARACTER

        ; MANDO DIR DE CARACTER
        SD $s3, 0 ($s1)

        lbu $t5, CONTRA($t6)    ;GUARDO EN T5 EL CARACTER ACTUAL DE CONTRA
        beqz $t5, FIN_BIEN           ; INDICA QUE TERMINO LA CONTRA (QUE TERMINO BIEN)
        BNE $t1, $t5, FIN_MAL

        ; IMPRIMIR CARACTER
        DADDI $t1, $0, 4
        SD $t1, 0 ($s0) ; CONTROL 4
        daddi $t6, $t6, 1           ;AVANZO AL SIGUIENTE CARACTER DE MI CONTRA
        J LOOP

        FIN_BIEN: DADDI $t0, $0, CORRECTO  ;IMPRIMO CORRECTO
            SD $t0, 0($s1)        
            DADDI $t0, $0, 4        
            SD $t0, 0($s0)   
            J FIN
        FIN_MAL: DADDI $t0, $0, ERROR  ;IMPRIMO CORRECTO
            SD $t0, 0($s1)        
            DADDI $t0, $0, 4        
            SD $t0, 0($s0)   
            J FIN

    FIN: JR $ra
```
Ejercicio_5
===========
```s
.data ;leer desde teclado
    CONTROL:    .word 0x10000
    DATA:       .word 0x10008
    BASE:       .double 0.0
    EXPONENTE:       .word 0
    MENSAJE:    .asciiz "BASE (FLOTANTE): "
    MENSAJE2:    .asciiz "EXPONENTE (ENTERO): "
    RES: .double 0
    UNO: .double 1.0

.code
    LWU $s0, CONTROL ($zero) 	; $s0 = CONTROL
    LWU $s1, DATA ($zero) 	   	; $s1 = DATA

    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)   

    DADDI $t0, $zero, 8
    SD $t0, 0 ($s0)             ; CONTROL = 8
    L.D f1, 0 ($s1)             ; Tomo número en f1
    S.D f1, BASE ($zero)        ; Guardo en variable

    DADDI $t0, $0, MENSAJE2  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)   

    DADDI $t0, $zero, 8
    SD $t0, 0 ($s0)                 ; CONTROL = 8
    LD $t1, 0 ($s1)                 ; Tomo número en t0
    SD $t1, EXPONENTE ($zero)       ; Guardo en variable

    JAL POTENCIA
    S.D f2, RES($0)
  
    S.D f2, 0 ($s1)
    ; Control 3
    DADDI $t0, $0, 3
    SD $t0, 0 ($s0)               
HALT

POTENCIA: L.D f2, UNO($0)
    LOOP: BEQZ $t1, FIN
        mul.d f2, f2, f1
        DADDI $t1, $t1, -1    
    J LOOP

    FIN: jr $ra
```

Ejercicio_6
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
    ;__________________________________
    DADDI $t0, $0, MENSAJE1 
    SD $t0, 0 ($s7) 
    DADDI $t1, $0, 4 
    SD $t1, 0 ($s6) 

    DADDI $t1, $0, 8
    SB $t1, 0($s6) 
    LBU $t2, 0($s7) 
    SB $t2, coorX($0)
    ;__________________________________    
    DADDI $t0, $0, MENSAJE2 
    SD $t0, 0 ($s7) 
    DADDI $t1, $0, 4 
    SD $t1, 0 ($s6) 
    
    DADDI $t1, $0, 8
    SB $t1, 0($s6) 
    LBU $t3, 0($s7) 
    SB $t3, coorY($0)
    ;__________________________________
    DADDI $t0, $0, MENSAJE3
    SD $t0, 0 ($s7)
    DADDI $t1, $0, 4 
    SD $t1, 0 ($s6)

    DADDI $a0, $0, 0    ;CONTADORES PARA LEER
    DADDI $a1, $0, 3
    
    LOOP: DADDI $t1, $0, 8
        SB $t1, 0($s6) 
        LBU $t3, 0($s7) 
        SB $t3, color($a0)
        DADDI $a0, $a0, 1   ;AVANZO AL SIGUIENTE BYTE
    bne $a0, $a1 ,LOOP
    ;__________________________________
    DADDI $t0, $zero, 7
    SD $t0, 0($s6)
    
    LBU $s0, coorX($zero)
    SB $s0, 5($s7)

    LBU $s1, coorY($zero)
    SB $s1, 4($s7)

    LWU $s2, color($zero)
    sw $s2, 0($s7)
    
    DADDI $t0, $zero, 5
    SD $t0, 0($s6)         
HALT
```
Ejercicio_7
===========

Ejercicio_8
===========
```s
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
```

Ejercicio_9
===========
```s
.data
        CONTROL: .word32  0x10000
        DATA:    .word32  0x10008
        MENU:    .asciiz "  Reset    (0)\n  NEGRO    (1)\n  AZUL     (2)\n  VERDE    (3)\n  CYAN     (4)\n  ROJO     (5)\n  VIOLETA  (6)\n  AMARILLO (7)\n  BLANCO   (8)\n  ACTUAL: "

        NEGRO:          .byte    0,  0,  0,  0     
        AZUL:           .byte    0,  0,  255,0     
        VERDE:          .byte    0,  255,0,  0     
        CYAN:           .byte    0,  255,255,0     
        ROJO:           .byte    255,0,  0,  0     
        VIOLETA:        .byte    255,0,  255,0   
        AMARILLO:       .byte    255,255,0,  0     
        BLANCO:         .byte    255,255,255,0     
        GRIS:           .byte    150,150,150,0    
                                
        NEGROCAR:       .asciiz  "NEGRO"          
        AZULCAR:        .asciiz  "AZUL"            
        VERDECAR:       .asciiz  "VERDE"          
        CYANCAR:        .asciiz  "CYAN"            
        ROJOCAR:        .asciiz  "ROJO"            
        VIOLETACAR:     .asciiz  "VIOLETA"         
        AMARILLOCAR:    .asciiz  "AMARILLO"         
        BLANCOCAR:      .asciiz  "BLANCO"                                     
        IMAGE:          .space   2500             
        OFF:            .space   1                

.code                      
        DADDI  $sp, $0, 0x400    
        DADDI  $v1, $0, 1         
        DADDI  $s1, $0, 5          
        DADDI  $s2, $0, 7         
        DADDI  $s3, $0, 9         
        DADDI  $s4, $0, 50       ;LIMITE     
        DADDI  $s0, $0, GRIS      
        DADDI  $s5, $0, NEGRO  

        DADDI  $s6, $0, 24         
        DADDI  $s7, $0, 24        
        DADDI  $t2, $0, 24         
        DADDI  $t3, $0, 24         

        LWU    $t8, DATA($0)       
        LWU    $t9, CONTROL($0)    

LIMPIAR: DADDI  $t0, $0, IMAGE      
         DADDI  $t1, $0, OFF        
         DADDI  $t3, $0, BLANCO      
INICIAR: SB     $t3, 0($t0)         
         DADDI  $t0, $t0, 1        
         BNE    $t0, $t1, INICIAR   

         JAL    IMPRIMIRMENU            
LEER:    JAL    DIBUJARPIXEL             
         JAL    DIBUJARESQUINA             
         SD     $s3, 0($t9)         
         LB     $t0, 0($t8)         
;____________________________________________________________
ARRIBA: DADDI  $v0, $0, 0x57                            ; W
        BNE    $t0, $v0, ARRIBA2       
        J MAXARRIBA             

ARRIBA2: DADDI  $v0, $0, 0x77                           ; w
         BNE    $t0, $v0, DERECHA       
         J MAXARRIBA             

DERECHA: DADDI  $v0, $0, 0x44                           ; D
         BNE    $t0, $v0, DERECHA2       
         J MAXDERECHA             

DERECHA2: DADDI  $v0, $0, 0x64                          ; d
          BNE $t0, $v0, IZQUIERDA       
          J MAXDERECHA             

IZQUIERDA: DADDI  $v0, $0, 0x41                         ; A
           BNE $t0, $v0, IZQUIERDA2       
           J MAXIZQUIRDA             

IZQUIERDA2: DADDI  $v0, $0, 0x61                        ; a
            BNE    $t0, $v0, ABAJO       
            J MAXIZQUIRDA             

ABAJO: DADDI  $v0, $0, 0x53                             ; S
       BNE    $t0, $v0, ABAJO2       
       J MAXABAJO              

ABAJO2: DADDI  $v0, $0, 0x73                            ; s
        BNE    $t0, $v0, ESPACIO     
        J MAXABAJO             
;____________________________________________________________
ESPACIO: DADDI  $v0, $0, 0x20                   ; ESPACIO
         BNE    $t0, $v0, REINICIAR             ; t0 <> 
         BEQ    $v1, $0, CONCEDIDO       
DENEGAR: DADDI  $v1, $0, 0          
         J LEER                
CONCEDIDO: DADDI  $v1, $0, 1          
           J LEER               

REINICIAR: DADDI  $v0, $0, 0x30                 ; 0
           BNE    $t0, $v0, CONEGRO   
           DADDI  $t0, $0, 7          
           SD     $t0, 0($t9)        
           DADDI  $v1, $0, 1          
           J LIMPIAR             
;____________________________________________________________COLORES
CONEGRO: DADDI  $v0, $0, 0x31                   ; 1
         BNE    $t0, $v0, COAZUL     
         DADDI  $s5, $0, NEGRO       
         JAL IMPRIMIRMENU            
         J LEER                

COAZUL: DADDI  $v0, $0, 0x32                    ; 2       
        BNE    $t0, $v0, COVERDE     
        DADDI  $s5, $0, AZUL       
        JAL IMPRIMIRMENU             
        J LEER                

COVERDE: DADDI  $v0, $0, 0x33                   ; 3
         BNE    $t0, $v0, COCYAN     
         DADDI  $s5, $0, VERDE       
         JAL    IMPRIMIRMENU             
         J LEER                

COCYAN: DADDI  $v0, $0, 0x34                    ; 4
        BNE    $t0, $v0, COROJO     
        DADDI  $s5, $0, CYAN       
        JAL    IMPRIMIRMENU            
        J LEER                

COROJO: DADDI  $v0, $0, 0x35                    ; 5
        BNE    $t0, $v0, COVIOLETA    
        DADDI  $s5, $0, ROJO       
        JAL    IMPRIMIRMENU             
        J LEER                

COVIOLETA: DADDI  $v0, $0, 0x36                 ; 6
           BNE    $t0, $v0, COAMARILLO     
           DADDI  $s5, $0, VIOLETA       
           JAL    IMPRIMIRMENU             
           J LEER                

COAMARILLO: DADDI  $v0, $0, 0x37                ; 7
            BNE    $t0, $v0, COBLANCO     
            DADDI  $s5, $0, AMARILLO       
            JAL    IMPRIMIRMENU             
            J LEER                

COBLANCO: DADDI  $v0, $0, 0x38                  ; 8
          BNE    $t0, $v0, LEER      
          DADDI  $s5, $0, BLANCO       
          JAL    IMPRIMIRMENU             
          J LEER               
;____________________________________________________________
MAXARRIBA: BEQ    $s7, $s4, LEER      
           DADD   $t2, $s6, $0        
           DADD   $t3, $s7, $0        
           DADDI  $s7, $s7, 1         
           J LEER                

MAXDERECHA: BEQ    $s6, $s4, LEER      
            DADD   $t2, $s6, $0        
            DADD   $t3, $s7, $0        
            DADDI  $s6, $s6, 1         
         J LEER                


MAXABAJO:  BEQZ   $s7, LEER          
         DADD   $t2, $s6, $0        
         DADD   $t3, $s7, $0        
         DADDI  $s7, $s7, -1        
         J      LEER               

MAXIZQUIRDA: BEQZ   $s6, LEER           
         DADD   $t2, $s6, $0        
         DADD   $t3, $s7, $0        
         DADDI  $s6, $s6, -1        
         J      LEER                
;____________________________________________________________
DIBUJARPIXEL: BNEZ   $v1, PINCEL  ; SI = 1 , VOY A PINCEL      
              LBU    $t0, 0($s5)         
              SB     $t2, 5($t8)         
              SB     $t3, 4($t8)         
              DADDI  $t0, $t0, -8        
              LWU    $t0, 0($s0)        
              SW     $t0, 0($t8)        
              SD     $t1, 0($t9)        
              JR     $ra         
                 
PINCEL: DMUL   $t0, $t2, $s4       
        SB     $t2, 5($t8)         
        SB     $t3, 4($t8)        
        DADD   $t0, $t0, $t3       
        DADDI  $t0, $t0, IMAGE     
        LBU    $t0, 0($t0)         
        DADDI  $t0, $t0, -8        
        LWU    $t0, 0($t0)         
        SW     $t0, 0($t8)         
        SD     $s1, 0($t9)         
        JR     $ra                

DIBUJARESQUINA: SB     $s6, 5($t8)        
                SB     $s7, 4($t8)         
                BEQZ   $v1, COPINCEL        
                DADDI  $t0, $0, CYAN            ; QUE COLOR DE TROLO
                J      COCURSOR  
                           
COPINCEL: DMUL   $t1, $s6, $s4       
          DADD   $t0, $0, $s5        
          DADD   $t1, $t1, $s7       
          DADDI  $t1, $t1, IMAGE     
          SB     $s5, 0($t1)    

COCURSOR: DADDI  $t0, $t0, -8        
          LWU    $t0, 0($t0)         
          SW     $t0, 0($t8)         
          SD     $s1, 0($t9)         
          JR     $ra                 

IMPRIMIRMENU: DADDI  $t0, $0, 6          
              SD     $t0, 0($t9)         
              DADDI  $t0, $0, MENU       
              SD     $t0, 0($t8)         
              DADDI  $t0, $0, 4          
              SD     $t0, 0($t9)         
              DADD   $t0, $0, $s5        
              DADDI  $t0, $t0, 64       
              SD     $t0, 0($t8)         
              DADDI  $t0, $0, 4          
              SD     $t0, 0($t9)         
              JR     $ra                 
```
