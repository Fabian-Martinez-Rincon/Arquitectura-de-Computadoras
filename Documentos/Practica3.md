<h1 align="center"> 💻Practica 4</h1>


Ejercicios
==========
1 ) Muchas instrucciones comunes en procesadores con arquitectura CISC no forman parte del repertorio de instrucciones del MIPS64, pero pueden implementarse haciendo uso de una única instrucción. Evaluar las siguientes instrucciones, indicar qué tarea realizan y cuál seria su equivalente en el lenguaje assembly del x86. [Resolución](#Ejercicio_1)

```s
a) dadd r1, r2, r0
b) daddi r3, r0, 5
c) dsub r4, r4, r4
d) daddi r5, r5, -1
e) xori r6, r6, 0xffffffffffffffff
```


2 ) El siguiente programa intercambia el contenido de dos palabras de la memoria de datos, etiquetadas A y B.

```s
.data
    A: .word 1
    B: .word 2
.code
    ld r1, A(r0)
    ld r2, B(r0)
    sd r2, A(r0)
    sd r1, B(r0)
halt
```

a ) Ejecutarlo en el simulador con la opción Configure/Enable Forwarding deshabilitada. Analizar paso a paso su funcionamiento, examinar las distintas ventanas que se muestran en el simulador y responder: [Resolución](#Ejercicio_2a)

- ¿Qué instrucción está generando atascos ***(stalls)*** en el cause ***(ó pipeline)*** y por qué?
- ¿Qué tipo de ```stall``` es el que aparece?
- ¿Cuál es el promedio de Ciclor por instrucciones ***(CPI)*** en la ejecución de este programa bajo esta configuración?

b ) Una forma de solucionar los atascos por dependencia de datos es utilizando el Adelantamiento de Operandos o Forwarding. [Resolución](#Ejercicio_2b)

Ejecutar nuevamente el programa anterior con la opción Enable Forwarding habilitada y responder:

- ¿Por que no se presenta ningún atasco en este caso? Explicar la mejora.
- ¿Qué indica el color de los registros en la ventana ***Register*** durante la ejecución?
- ¿Cuál es el promedio de Ciclos Por Instruccion ***(CPI)*** en este caso? Comparar con el anterior

3 ) Analizar el siguiente programa con el simulador MIPS64:

```s
.data
    A: .word 1
    B: .word 3
.code
    ld r1, A(r0)
    ld r2, B(r0)
    loop: dsll r1, r1, 1
    daddi r2, r2, -1
    bnez r2, loop
halt
```
