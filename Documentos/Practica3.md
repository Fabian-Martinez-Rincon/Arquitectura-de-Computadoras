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

a ) Ejecutar el programa con Forwarding habilitado y responder:

- ¿Por qué se presentan atascos tipo RAW?
- Branch Taken es otro tipo de atasco que aparece. ¿Qué significa? ¿Por qué se produce?
- ¿Cuántos CPI tiene la ejecución de este programa? Tomar nota del número de ciclos, cantidad de instrucciones y CPI.

b ) Ejecutar ahora el programa deshabilitando el Forwarding y responder:

- ¿Qué instrucciones generan los atascos tipo RAW y por qué? ¿En qué etapa del cauce se produce el atasco en cada caso y durante cuántos ciclos?
- Los Branch Taken Stalls se siguen generando. ¿Qué cantidad de ciclos dura este atasco en cada vuelta del lazo ***loop***?
 
Comparar con la ejecución con Forwarding y explicar la diferencia.

- ¿Cuántos CPI tiene la ejecución del programa en este caso? Comparar número de ciclos, cantidad de instrucciones y CPI con el caso con Forwarding.

c ) Reordenar las instrucciones para que la cantidad de RAW sea „0‟ en la ejecución del programa (Forwarding habilitado)

d ) Modificar el programa para que almacene en un arreglo en memoria de datos los contenidos parciales del registro r1 ¿Qué significado tienen los elementos de la tabla que se genera?


4 ) Dado el siguiente programa

```s
.data
    tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
    num: .word 7
    long: .word 10
.code
    ld r1, long(r0)
    ld r2, num(r0)
    dadd r3, r0, r0
    dadd r10, r0, r0
    loop: ld r4, tabla(r3)
    beq r4, r2, listo
    daddi r1, r1, -1
    daddi r3, r3, 8
    bnez r1, loop
    j fin
    listo: daddi r10, r0, 1
fin: halt
```

a ) Ejecutar en simulador con Forwarding habilitado. ¿Qué tarea realiza? ¿Cuál es el resultado y dónde queda indicado?

b) Re-Ejecutar el programa con la opción Configure/Enable Branch Target Buffer habilitada. Explicar la ventaja de usar este método y cómo trabaja.

c) Confeccionar una tabla que compare número de ciclos, CPI, RAWs y Branch Taken Stalls para los dos casos anteriores.

5 ) El siguiente programa multiplica por 2 los elementos de un arreglo llamado datos y genera un nuevo arreglo llamado res. Ejecutar el programa en el simulador winmips64 con la opción Delay Slot habilitada.

```s
.data
    cant: .word 8
    datos: .word 1, 2, 3, 4, 5, 6, 7, 8
    res: .word 0
.code
    dadd r1, r0, r0
    ld r2, cant(r0)
    loop: ld r3, datos(r1)
    daddi r2, r2, -1
    dsll r3, r3, 1
    sd r3, res(r1)
    daddi r1, r1, 8
    bnez r2, loop
    nop
halt
```

a ) ¿Qué efecto tiene habilitar la opción Delay Slot (salto retardado)?.

b ) ¿Con qué fin se incluye la instrucción NOP? ¿Qué sucedería si no estuviera?.

c ) Tomar nota de la cantidad de ciclos, la cantidad de instrucciones y los CPI luego de ejecutar el programa.

d ) Modificar el programa para aprovechar el „Delay Slot‟ ejecutando una instrucción útil. Simular y comparar número de ciclos, instrucciones y CPI obtenidos con los de la versión anterior.

6 ) Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D.

7 ) Escribir un programa que recorra una TABLA de diez números enteros y determine cuántos elementos son mayores que X. 

El resultado debe almacenarse en una dirección etiquetada CANT. El programa debe generar además otro arreglo llamado RES cuyos elementos sean ceros y unos. Un „1‟ indicará que el entero correspondiente en el arreglo TABLA es mayor que X, mientras que un „0‟ indicará que es menor o igual.

8 ) Escribir un programa que multiplique dos números enteros utilizando sumas repetidas (similar a Ejercicio 6 o 7 de la Práctica 1). El programa debe estar optimizado para su ejecución con la opción Delay Slot habilitada
