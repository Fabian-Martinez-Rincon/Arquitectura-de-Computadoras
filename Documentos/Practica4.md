<h1 align="center">💻Practica 5 Instrucciones de Punto Flotante y pasaje de parámetros</h1>

```1)``` Simular el siguiente programa de suma de números en punto flotante y analizar minuciosamente la ejecución paso a paso. Inhabilitar Delay Slot y mantener habilitado Forwarding.

```s
.data
    n1: .double 9.13
    n2: .double 6.58
    res1: .double 0.0
    res2: .double 0.0
.code
    l.d f1, n1(r0)
    l.d f2, n2(r0)
    add.d f3, f2, f1
    mul.d f4, f2, f1
    s.d f3, res1(r0)
    s.d f4, res2(r0)
    halt
```

```a)``` Tomar nota de la cantidad de ciclos, instrucciones y CPI luego de la ejecución del programa.

```b)``` ¿Cuántos atascos por dependencia de datos se generan? Observar en cada caso cuál es el dato en conflicto y las instrucciones involucradas.

```c)``` ¿Por qué se producen los atascos estructurales? Observar cuales son las instrucciones que los generan y en qué etapas del pipeline aparecen.

```d)``` Modificar el programa agregando la instrucción ```mul.d f1, f2, f1``` entre las instrucciones ```add.d y mul.d```. Repetir la ejecución y observar los resultados. ¿Por qué aparece un atasco tipo ***WAR***?

```e)``` Explicar por qué colocando un ***NOP*** antes de la suma, se soluciona el ***RAW*** de la instrucción ***ADD*** y como consecuencia se elimina el ***WAR***. 

```2)``` Es posible convertir valores enteros almacenados en alguno de los registros ```r1-r31``` a su representación equivalente en punto flotante y viceversa. Describa la funcionalidad de las instrucciones ***mtc1, cvt.1.d, cvt.d.1 y mfc1***.

```3)``` Escribir un programa que calcule la superficie de un triángulo rectángulo de base 5,85 cm y altura 13,47 cm.

Pista: la superficie de un triángulo se calcula como: 

```Superficie = (base x altura) / 2```

```4)``` El índice de masa corporal (IMC) es una medida de asociación entre el peso y la talla de un individuo.

Se calcula a partir del peso (expresado en kilogramos, por ejemplo: 75,7 kg) y la  estatura (expresada en metros, por ejemplo 1,73 m), usando la fórmula:

```IMG = PESO / (ESTATURA)^2```

De acuerdo al valor calculado con este índice, puede clasificarse el estado nutricional de una persona en:

***Infrapeso*** (IMC < 18,5), ***Normal*** (18,5 ≤ IMC < 25), ***Sobrepeso*** (25 ≤ IMC < 30) y ***Obeso*** (IMC ≥ 30).

Escriba un programa que dado el peso y la estatura de una persona calcule su IMC y lo guarde en la dirección etiquetada ***IMC***. También deberá guardar en la dirección etiquetada ```estado``` un valor según la siguiente tabla:

| IMC | Clasificación | Valor guardado |
| :---         |     :---:      |          ---: |
| < 18,5   | Infrapeso     | 1    |
| < 25     | Normal       | 2      |
| < 30     | Sobrepeso       | 3      |
| >=30     | Obeso       | 4      |



```5)``` El procesador MIPS64 posee 32 registros, de 64 bits cada uno, llamados r0 a r31 (también conocidos como $0 a $31).

Sin embargo, resulta más conveniente para los programadores darles nombres más significativos a esos registros.

La siguiente tabla muestra la convención empleada para nombrar a los 32 registros mencionados:

| Registros | Nombres | ¿Para que se los utiliza? | ¿Preservado? |
| :---         |     :---:      |          ---: |     ---: |
| r0   | $zero     | 1    | |
| r1     | $at       | 2      | |
| r2-r3     | $v0-$v1       | 3      | |
| r4-r7     | $a0-$a3       | 4      | |
| r8-r15     | $t0-$t7      | 4      | |
| r16-r23     | $s0-$s7       | 4      | |
| r24-r25     | $t8-$t9       | 4      | |
| r26-r27     | $k0-$k1      | 4      | |
| R28     | $gp       | 4      | |
| R29     | $sp       | 4      | |
| R30     | $fp       | 4      | |
| R31     | $ra       | 4      | |

Complete la tabla anterior explicando el uso que normalmente se le da cada uno de los registros nombrados. Marque en la columna ```“¿Preservado?”``` si el valor de cada grupo de registros debe ser preservado luego de realizada una llamada a una subrutina. Puede encontrar información útil en el apunte Programando sobre MIPS64

```6)``` Como ya se observó anteriormente, muchas instrucciones que normalmente forman parte del repertorio de un procesador con arquitectura CISC no existen en el MIPS64. En particular, el soporte para la invocación a subrutinas es mucho más simple que el provisto en la arquitectura x86 (pero no por ello menos potente). El siguiente programa muestra un ejemplo de invocación a una subrutina.

```s
.data
    valor1: .word 16
    valor2: .word 4
    result: .word 0
    
.text
    ld $a0, valor1($zero)
    ld $a1, valor2($zero)
    jal a_la_potencia
    sd $v0, result($zero)
    halt

a_la_potencia: daddi $v0, $zero, 1
    lazo: slt $t1, $a1, $zero
    bnez $t1, terminar
    daddi $a1, $a1, -1
    dmul $v0, $v0, $a0
    j lazo
    terminar: jr $ra
```

<h1 align="center">Ejercicios</h1>
