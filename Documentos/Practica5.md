<h1 align="center"> 💻Practica 6</h1>

<h1 align="center"> Procesador RISC: utilizando la E/S</h1>

```1)``` El siguiente programa produce la salida de un mensaje predefinido en la ventana Terminal del simulador WinMIPS64.

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

```2)``` Escriba un programa que utilice sucesivamente dos subrutinas: La primera, denominada ***ingreso***, debe solicitar el ingreso por teclado de un número entero (de un dígito), verificando que el valor ingresado realmente sea un dígito. La segunda, denominada ***muestra***, deberá mostrar en la salida estándar del simulador (ventana Terminal) el valor del número ingresado expresado en letras (es decir, si se ingresa un ***‘4’***, deberá mostrar ‘CUATRO’). Establezca el pasaje de parámetros entre subrutinas respetando las convenciones para el uso de los registros y minimice las detenciones del cauce (ejercicio similar al ejercicio 6 de Práctica 2).

```3)``` Escriba un programa que realice la suma de dos números enteros (de un dígito cada uno) utilizando dos subrutinas: La denominada ***ingreso*** del ejercicio anterior (ingreso por teclado de un dígito numérico) y otra denominada ***resultado***, que muestre en la salida estándar del simulador (ventana Terminal) el resultado numérico de la suma de los dos números ingresados (ejercicio similar al ejercicio 7 de Práctica 2).

```4)``` Escriba un programa que solicite el ingreso por teclado de una clave (sucesión de cuatro caracteres) utilizando la subrutina ***char*** de ingreso de un carácter. Luego, debe comparar la secuencia ingresada con una cadena almacenada en la variable ***clave***. Si las dos cadenas son iguales entre si, la subrutina llamada ***respuesta*** mostrará el texto ***“Bienvenido”*** en la salida estándar del simulador (ventana Terminal). En cambio, si las cadenas no son iguales, la subrutina deberá mostrar ***“ERROR”*** y solicitar nuevamente el ingreso de la clave.


```5)``` Escriba un programa que calcule el resultado de elevar un valor en punto flotante a la potencia indicada por un exponente que es un número entero positivo. Para ello, en el programa principal se solicitará el ingreso de la base (un número en punto flotante) y del exponente (un número entero sin signo) y se deberá utilizar la subrutina ***a_la_potencia*** para calcular el resultado pedido (que será un valor en punto flotante). Tenga en cuenta que cualquier base elevada a la 0 da como resultado 1. Muestre el resultado numérico de la operación en la salida estándar del simulador (ventana Terminal). 

```6)``` El siguiente programa produce una salida estableciendo el color de un punto de la pantalla gráfica (en la ventana Terminal del simulador WinMIPS64). Modifique el programa de modo que las coordenadas y color del punto sean ingresados por teclado.

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
