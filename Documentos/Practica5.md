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
