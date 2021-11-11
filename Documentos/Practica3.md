<h1 align="center"> 💻Practica 4 </h1>

<h1 align="center"> Segmentación de cauce en procesador RISC</h1>

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

a ) Ejecutar el programa con Forwarding habilitado y responder: [Resolución](#Ejercicio_3a)

- ¿Por qué se presentan atascos tipo RAW?
- Branch Taken es otro tipo de atasco que aparece. ¿Qué significa? ¿Por qué se produce?
- ¿Cuántos CPI tiene la ejecución de este programa? Tomar nota del número de ciclos, cantidad de instrucciones y CPI.

b ) Ejecutar ahora el programa deshabilitando el Forwarding y responder: [Resolución](#Ejercicio_3b)

- ¿Qué instrucciones generan los atascos tipo RAW y por qué? ¿En qué etapa del cauce se produce el atasco en cada caso y durante cuántos ciclos?
- Los Branch Taken Stalls se siguen generando. ¿Qué cantidad de ciclos dura este atasco en cada vuelta del lazo ***loop***?
 
Comparar con la ejecución con Forwarding y explicar la diferencia.

- ¿Cuántos CPI tiene la ejecución del programa en este caso? Comparar número de ciclos, cantidad de instrucciones y CPI con el caso con Forwarding.

c ) Reordenar las instrucciones para que la cantidad de RAW sea „0‟ en la ejecución del programa (Forwarding habilitado) [Resolución](#Ejercicio_3c)

d ) Modificar el programa para que almacene en un arreglo en memoria de datos los contenidos parciales del registro r1 ¿Qué significado tienen los elementos de la tabla que se genera? [Resolución](#Ejercicio_3d)


4 ) Dado el siguiente programa 

```s
.data
    tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
    num: .word 7
    long: .word 10
.code
    ld R1, long(R0)         ; R1  = 10
    ld R2, num(R0)          ; R2 = 7
    dadd R3, R0, R0         ; R3 = R0 + R0 (INICIALIZO R3)
    dadd R10, R0, R0        ; R10 = R0 + R0 (INICIALIZO R10)

    loop: ld R4, tabla(R3)  ; R4 = TABLA + R3(POS) RECORRO LA TABLA
        beq R4, R2, listo   ; SI EL NRO DE LA TABLA ACTUAL ES IGUAL AL NRO QUE ESTOY BUSCANDO, TERMINO
        daddi R1, R1, -1    ; DECREMENTO EL CONTADOR DE TABLA
        daddi R3, R3, 8     ; R3 = R3 + 8 (CADA NRO EN LA TABLA OCUPA 1 BYTE QUE SON 8 BITS)
        bnez R1, loop       ; MIENTRAS NO LLEGUE AL FINAL, CONTINUO

    j fin                   ; TERMINO
    listo: daddi R10, R0, 1 ; R10 = 0 + 1 ; QUIERO ENTENDER QUE ES PARA AVISAR QUE ENCONTRE EL NRO
fin: halt
```

a ) Ejecutar en simulador con Forwarding habilitado. ¿Qué tarea realiza? ¿Cuál es el resultado y dónde queda indicado? [Resolución](#Ejercicio_4a)

b) Re-Ejecutar el programa con la opción Configure/Enable Branch Target Buffer habilitada. Explicar la ventaja de usar este método y cómo trabaja. [Resolución](#Ejercicio_4b)

c) Confeccionar una tabla que compare número de ciclos, CPI, RAWs y Branch Taken Stalls para los dos casos anteriores. [Resolución](#Ejercicio_4c)

5 ) El siguiente programa multiplica por 2 los elementos de un arreglo llamado datos y genera un nuevo arreglo llamado res. Ejecutar el programa en el simulador winmips64 con la opción Delay Slot habilitada. [Resolución](#Ejercicio_5)

```s
.data
    cant: .word 8
    datos: .word 1, 2, 3, 4, 5, 6, 7, 8
    res: .word 0
.code
    dadd R1, R0, R0         ;INICIALIZO R1
    ld R2, cant(R0)         ; R2 = 8
    loop: ld R3, datos(R1)  ; R3 = ELEMENTO DE TABLA EN X POSICION
        daddi R2, R2, -1    ; DECREMENTO EL CONTADOR DE TABLA
        dsll R3, R3, 1      ; MUEVO LOS BITS UNA POSICION A LA IZQUIERDA QUE SERIA EL EQUIVALENTE A MULTIPLICARLOS X2
        sd R3, res(R1)      ; R3 = REMPLAZO EL VALOR NUEVO EN LA TABLA
        daddi R1, R1, 8     ; ME MUEVO AL SIGUIENTE ELEMENTO DE LA TABLA
        bnez R2, loop       ; MIENTRAS NO TERMINE DE RECORRER LA TABLA, CONTINUO
    nop
halt
```

a ) ¿Qué efecto tiene habilitar la opción Delay Slot (salto retardado)?.

b ) ¿Con qué fin se incluye la instrucción NOP? ¿Qué sucedería si no estuviera?.

c ) Tomar nota de la cantidad de ciclos, la cantidad de instrucciones y los CPI luego de ejecutar el programa.

d ) Modificar el programa para aprovechar el „Delay Slot‟ ejecutando una instrucción útil. Simular y comparar número de ciclos, instrucciones y CPI obtenidos con los de la versión anterior.

6 ) Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D. [Resolución](#Ejercicio_6)

7 ) Escribir un programa que recorra una TABLA de diez números enteros y determine cuántos elementos son mayores que X. [Resolución](#Ejercicio_7)

El resultado debe almacenarse en una dirección etiquetada CANT. El programa debe generar además otro arreglo llamado RES cuyos elementos sean ceros y unos. Un „1‟ indicará que el entero correspondiente en el arreglo TABLA es mayor que X, mientras que un „0‟ indicará que es menor o igual.

8 ) Escribir un programa que multiplique dos números enteros utilizando sumas repetidas (similar a Ejercicio 6 o 7 de la Práctica 1). El programa debe estar optimizado para su ejecución con la opción Delay Slot habilitada. [Resolución](#Ejercicio_8)


Ejercicio_1
===========
```s
# dadd r1, r2, r0   R1 = R2 + R0
# daddi r3, r0, 5   R3 = R0 + 5
# dsub r4, r4, r4   R4 = R4 - R4
# daddi r5, r5, -1  R5 = R5 + -1
# xori r6, r6, 0xffffffffffffffff  R6 = R6 XOR 0xffffffffffffffff
```

Ejercicio_2a
============

- ¿Qué instrucción está generando atascos ***(stalls)*** en el cause ***(ó pipeline)*** y por qué?

La instrucción ```SD R2, A(r0)``` almacena en la dirección de memoria ***A*** el valor contenido en el registro ***R2***, mientras que la instrucción  anterior ```LD R2, B(r0)``` carga desde la dirección de memoria ***B*** el contenido de esa posición en el registro ***R2***.

Cuando fordwarding no está habilitado la instrucción ```SD R2, A(r0)``` que en la etapa ***ID*** trata de leer el contenido de ***R2***, pero dicho contenido no estará disponible hasta que la instrucción anterior ```LD R2, B(r0)``` llegue a la etapa ***WB***.

Y debido a esto se genera un atasco en la etapa ***ID*** donde se procesa la instrucción ```SD R2, A(r0)``` retrasando la salida de la etapa ***(con RAWs)*** a la espera del contenido del registro. Esto además genera que la instrucción posterior ```SD R1, B(r0)``` deba permanecer en la etapa ***IF*** sin poder avanzar a la etapa ***ID*** (el pipeline se detuvo) como se puede ver en la imagen.

Tener en cuenta que en la primera mitad de la etapa ***WB*** se escribe el contenido en ***R2*** y en el segundo ***RAW*** se lee el contenido de dicho registro.

![image](https://user-images.githubusercontent.com/55964635/140976382-6b7297b5-732f-42e8-ad5b-c9b1ee52a9ea.png)

- Branch Taken es otro tipo de atasco que aparece. ¿Qué significa? ¿Por qué se produce?

Aparecen atascos de tipo ***RAW (Read After Write)*** causado por una dependencia de datos, en este caso intenta leer un dato antes que esté guardado en el registro. Serán dos atascos, equivalentes a dos ciclos hasta que ```LD R2, B(r0)``` salga de la estapa ***WB***.

- ¿Cuántos CPI tiene la ejecución de este programa? Tomar nota del número de ciclos, cantidad de instrucciones y CPI.

El ***CPI*** de la ejecución de este programa es de 2.2

<table>
<tr>
<td> Ejecución </td> <td> Funciones </td>
</tr>
<tr>
<td>
 
![image](https://user-images.githubusercontent.com/55964635/140979278-78e2e908-83cc-4ee5-9544-b9d857686baa.png)
    
</td>
<td>
 

Ciclos por instrucción (CPI) = 2,2
    
Espera por dependencia de datos (RAW) = 2
 
</td>
</tr>
 
</table>

Ejercicio_2b
============

Con la opción forwarding habilitada el dato contenido en el registro R2 podrá ser leído por la instrucción ```SD R2, A(r0)``` cuando la instrucción ```LD R2, B(r0)``` se encuentra finalizando la etapa ***MEM***. La instrucción ```SD R2, A(r0)``` no tiene que esperar a que la instrucción ```LD R2, B(r0)``` salga de la etapa ***WB***. De esta manera no aparecen atascos del tipo ***RAW***.

![image](https://user-images.githubusercontent.com/55964635/140980974-2d170779-38ae-4b28-8594-03465e485b71.png)


Ejercicio_3a
============

- ¿Por qué se presentan atascos tipo RAW?

Se presentan atasco por dependencia de datos de tipo ***RAW*** causado por la instrucción ***BNEZ R2***, loop al procesarse en la etapa ***ID***. Esta instrucción necesita del contenido del registro ***R2*** que está siendo utilizado por la instrucción ***DADDI R2,R2, -1*** en la etapa EX sin salir aún de esta.

- Branch Taken es otro tipo de atasco que aparece. ¿Qué significa? ¿Por qué se produce?

El atasco de tipo ***Branch Taken Stalls (BTS)***, ocurre como concecuencia de la ejecución incorrecta de la instrucción siguiente a una instrucción condicional. Esto se debe a que la condición a evaluar tarda algunos ciclos en ser ejecutada, mientras que durante esos ciclos siguen entrando nuevas instrucciones al pipeline. Luego de evaluada la condición si la instrucción posterior a ésta que se ejecutó no es la que debía ser ejecutada, su ejecución se trunca y se ejecuta la que está en el lugar de memoria indicada por la etiqueta en la instrucción condicional.

![image](https://user-images.githubusercontent.com/55964635/141157733-1ba69e9c-8889-46fa-9460-868e51ecf04e.png)

- ¿Cuántos CPI tiene la ejecución de este programa? Tomar nota del número de ciclos, cantidad de instrucciones y CPI.

Se ejecutan 12 instrucciones en 21 ciclos dando un ***CPI*** de 1.750

![image](https://user-images.githubusercontent.com/55964635/141158306-30d4fc0a-dd46-4e7c-a4c2-dc8f2a6d438a.png)


Ejercicio_3b
============

- ¿Qué instrucciones generan los atascos tipo RAW y por qué? ¿En qué etapa del cauce se produce el atasco en cada caso y durante cuántos ciclos?

Las instrucciones que generan atascos ***RAW*** son:

la instrucción ```DSLL R1,R1,1``` (ver registro ***R1*** coloreado en gris), que trata de leer el contenido del registro ***R1***, mientras que la instrucción ```LD R1,A(r0)``` todavía no copio el contenido de la dirección de memoria A en R1 y permanece aún en la etapa WB (RAW durante 1 ciclo).

Y la instrucción ```BNEZ R2,loop``` (ver registro ***R2*** coloreado en gris), que trata de leer el contenido del registro ***R2***, mientras que ```DADDI R2,R2,-1``` está buscando copiar el resultado de la operación en dicho registro, permaneciendo en la etapa ***MEM*** y posteriormente en la etapa ***WB*** (***RAW*** durante 2 ciclos).

![image](https://user-images.githubusercontent.com/55964635/141158925-d29f52e4-74ad-4ad9-a2e0-ddbcf5484e4e.png)

- Los Branch Taken Stalls se siguen generando. ¿Qué cantidad de ciclos dura este atasco en cada vuelta del lazo ***‘loop’***? Comparar con la ejecución con Forwarding y explicar la diferencia.

Con forwarding deshabilitada, Los atascos por Branch Taken Stalls duran 2 ciclos en cada vuelta del lazo loop, mientras que con dicha opción habilitada se reducen a 1 ciclo por vuelta de lazo.

Esta diferencia tiene su causa en la instrucción condicional que es la que está generando los atascos ***RAW;*** entonces al disminuir la cantidad de ***RAWs*** producidos por esta, también disminuyen los ciclos de espera de la instrucción siguiente, que además se dejara de ejecutar si la condicional así se lo indica al procesador.

- ¿Cuántos CPI tiene la ejecución del programa en este caso? Comparar número de ciclos, cantidad de instrucciones y CPI con el caso con Forwarding.

```a completar```

Ejercicio_3c
============

Con la opción forwarding habilitada aún siguen apareciendo atascos RAW. Existe la posibilidad de tratar de eliminarlos reordenando las instrucciones en el programa y Dicho reordenamiento no debe afectar la lógica de este. El resultado de este método puede observarse en la imagen siguiente.

![image](https://user-images.githubusercontent.com/55964635/141161278-22c3d010-d133-4bd9-b8c7-17a1666bfb93.png)

![image](https://user-images.githubusercontent.com/55964635/141164804-dad4f7ab-d78f-4c22-974f-b16fe14e7c6b.png)


Ejercicio_3d
============

```Completar```

Ejercicio_4a
============

![image](https://user-images.githubusercontent.com/55964635/141165757-05440f46-6fb1-4c37-8c53-7952e3fdbfb6.png)

Ejercicio_4b
============

Ejercicio_4c
============

El programa busca en TABLA un elemento igual al contenido en la dirección de memoria NUM. En este caso dicha coincidencia se produce cuando el contenido del registro R4 es igual al contenido del registro R2 (R4=R2), razón por la cual luego de evaluada esta condición y de resultar verdadera se salta a la posición de memoria indicada por la etiqueta “listo”. Cuando hay coincidencia la línea de programa en listo suma al registro R10 un 1, caso contrario el contenido del registro R10 queda en 0. Este es el resultado y queda almacenado en el registro R10. El registro R3 se utiliza como índice para recorrer la TABLA. El contenido del registro R3 se incrementa de a 8 porque cada elemento de tabla es del tamaño word, es decir de 64 bits (8 bytes).

Habilitando la opción Branch Target Buffer (BTB) logramos reducir los atascos Branch Taken stalls a la mitad.

Tener en cuenta que esta opción es útil cuando aumenta la cantidad de iteraciones de un lazo. Como vemos también esta opción no actúa sobre los atascos por dependencia de datos (RAW en este caso) que no se modifican. 


Ejercicio_5
===========

Ejercicio_6
===========

```s
.data
    NROA: .word 1
    NROB: .word 2
    NROC: .word 1
    NROD: .word 0

.code
    ld R1, NROA(R0) 
    ld R2, NROB(R0) 
    ld R3, NROC(R0)
    ld R4, NROD(R0)

    
    bne R1, R2, continuar
    DADDI R4, R4, 2
    bne R1, R3, continuar2
    DADDI R4, R4, 1
    j TERMINAR

    continuar: bne R1, R3, TERMINAR
    DADDI R4, R4, 2
    bne R3, R2, TERMINAR
    DADDI R4, R4, 1
    j TERMINAR

    continuar2: bne R2, R3, TERMINAR
    DADDI R4, R4, 2

    TERMINAR: sd R4, NROD(R0)


    FIN: HALT

````

Ejercicio_7
===========

```s
.data
    TABLA: .word 1,2,3,4,5,6,7,8,9,10
    X: .word 6
    CANT: .word 0
    RES: .word 0

.code
    DADDI R10, R0, -8
    DADDI R11, R0, 80
    LD R1, X(R0)
    DADDI R4, R0, 1
    LD R5, CANT(R0)

    LOOP: DADDI R10, R10, 8
        BEQ R10, R11, FIN
        LD R2, TABLA(R10)
        SLT R3, R1, R2
        BNE R3, R4, LOOP
        DADDI R5, R5, 1
        SD R4, RES(R10)
        j LOOP
    FIN: SD R5, CANT(R0)
    HALT
```

Ejercicio_8
===========

```s
.data
    NUM1: .word 3
    NUM2: .word 5
    RES: .word 0
.code
    ld R1, NUM1(r0) ; 3
    ld R2, NUM2(r0) ; 8
    dadd R3, R0, R0
    loop: dadd R3, R3, R1
        daddi R2,R2, -1
        bnez R2, loop
    sd R3, RES(r0)
halt
```
con delay slot activado

```s
.data
    num1: .word 3
    num2: .word 5
    res: .word 0
.code
    LD r1, num1(r0)
    LD r2, num2(r0)
    DADD r10, r0, r0
    LOOP: DADDI r2, r2, -1
        BNEZ r2, LOOP
        DADD r10, r10, r1
        SD r10, res(r0)
    HALT
```
