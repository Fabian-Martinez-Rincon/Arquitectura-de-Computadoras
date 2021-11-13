<h1 align="center">💻Practica 5 </h1>

<h1 align="center">Instrucciones de Punto Flotante y pasaje de parámetros</h1>

```1)``` Simular el siguiente programa de suma de números en punto flotante y analizar minuciosamente la ejecución paso a paso. Inhabilitar Delay Slot y mantener habilitado Forwarding. [Resolución](#Ejercicio_1)

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

```2)``` Es posible convertir valores enteros almacenados en alguno de los registros ```r1-r31``` a su representación equivalente en punto flotante y viceversa. Describa la funcionalidad de las instrucciones ***mtc1, cvt.1.d, cvt.d.1 y mfc1***. [Resolución](#Ejercicio_2)

```3)``` Escribir un programa que calcule la superficie de un triángulo rectángulo de base 5,85 cm y altura 13,47 cm. [Resolución](#Ejercicio_3)

Pista: la superficie de un triángulo se calcula como: 

```Superficie = (base x altura) / 2```

```4)``` El índice de masa corporal (IMC) es una medida de asociación entre el peso y la talla de un individuo. [Resolución](#Ejercicio_4)

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



```5)``` El procesador MIPS64 posee 32 registros, de 64 bits cada uno, llamados r0 a r31 (también conocidos como $0 a $31).  [Resolución](#Ejercicio_5)

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

```6)``` Como ya se observó anteriormente, muchas instrucciones que normalmente forman parte del repertorio de un procesador con arquitectura CISC no existen en el MIPS64. En particular, el soporte para la invocación a subrutinas es mucho más simple que el provisto en la arquitectura x86 (pero no por ello menos potente). El siguiente programa muestra un ejemplo de invocación a una subrutina. [Resolución](#Ejercicio_6)

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

```a)``` ¿Qué hace el programa? ¿Cómo está estructurado el código del mismo?

```b)```  ¿Qué acciones produce la instrucción ***jal***? ¿Y la instrucción ***jr***?

```c)``` ¿Qué valor se almacena en el registro ***$ra***? ¿Qué función cumplen los registros ***$a0*** y ***$a1***? ¿Y el registro ***$v0***?

```d)``` ¿Qué sucedería si la subrutina a_la_potencia necesitara invocar a otra subrutina para realizar la multiplicación, por ejemplo, en lugar de usar la instrucción ***dmul***? ¿Cómo sabría cada una de las subrutinas a que dirección de memoria deben retornar?

```7)``` Escriba una subrutina que reciba como parámetros un número positivo M de 64 bits, la dirección del comienzo de una tabla que contenga valores numéricos de 64 bits sin signo y la cantidad de valores almacenados en dicha tabla. La subrutina debe retornar la cantidad de valores mayores que M contenidos en la tabla. [Resolución](#Ejercicio_7)

```8)``` Escriba una subrutina que reciba como parámetros las direcciones del comienzo de dos cadenas terminadas en cero y retorne la posición en la que las dos cadenas difieren. En caso de que las dos cadenas sean idénticas, debe retornar -1. [Resolución](#Ejercicio_8)

```9)``` Escriba la subrutina ES_VOCAL, que determina si un carácter es vocal o no, ya sea mayúscula o minúscula. La rutina debe recibir el carácter y debe retornar el valor 1 si el carácter es una vocal, o 0 en caso contrario. [Resolución](#Ejercicio_9)

```10)``` Usando la subrutina escrita en el ejercicio anterior, escribir la subrutina ***CONTAR_VOC***, que recibe una cadena terminada en cero , y devuelve la cantidad de vocales que tiene esa cadena. [Resolución](#Ejercicio_10)

```11)``` Escribir una subrutina que reciba como argumento una tabla de números terminada en 0. La subrutina debe contar la cantidad de números que son impares en la tabla, esta condición se debe verificar usando una subrutina es_impar. La subrutina es_impar debe devolver 1 si el número es impar y 0 si no lo es. [Resolución](#Ejercicio_11)

```12)``` El siguiente programa espera usar una subrutina que calcule en forma recursiva el factorial de un número entero: [Resolución](#Ejercicio_12)

```s
data
    valor: .word 10
    result: .word 0
.text
    daddi $sp, $zero, 0x400 ; Inicializa puntero al tope de la pila
    (1)
    ld $a0, valor($zero)
    jal factorial
    sd $v0, result($zero)
    halt
factorial: ...
...
```

(1) La configuración inicial de la arquitectura del WinMIPS64 establece que el procesador posee un bus de direcciones de 10 bits para la memoria de datos. Por lo tanto, la mayor dirección dentro de la memoria de datos será de 2^10 = 1024 = 400 sub 16

```a)``` Implemente la subrutina factorial definida en forma recursiva. Tenga presente que el factorial de un número entero n se calcula como el producto de los números enteros entre 1 y n inclusive:

```factorial(n) = n! = n * (n - 1) * (n - 2) * ... * 3 * 2 * 1```

```b)``` ¿Es posible escribir la subrutina factorial sin utilizar una pila? Justifique.


<h1 align="center">Ejercicios</h1>

Ejercicio_1
===========
```a)``` 16 ciclos, 7 instrucciones y 2,286 Ciclos por Instrucción (CPI)

```b)``` Se generan dos atascos por dependencia de datos

Ejercicio_2
===========

- mtc1 Rx, Fx: Copia los 64 bits del registro entero Rx al registro Fx de punto flotante
- cvt.1.d Fx, Fy: Convierte a entero el valor en punto flotante contenido en Fy, dejándolo en Fx
- cvt.d.1 Fx, Fy: Convierte a punto flotante el valor entero copiado al registro Fy, dejándolo en Fx
- mfc1 Rx, Fx: Copia los 64 bits del registro Fx de punto flotante al registro Rx entero  

Ejercicio_3
===========

Resultado ```39,39975  exa 3C 1E87```

Ejercicio_4
===========
Ejercicio_5
===========

| Registros | Nombres | ¿Para que se los utiliza? | ¿Preservado? |
| :---         |     :---:      |          ---: |     ---: |
| r0   | $zero     | Siempre tiene el valor 0 y no se puede cambiar    |      |
| r1     | $at       | Return Address- Dir. de retorno de subrutina. Debe ser salvado      | |
| r2-r3     | $v0-$v1       | Valores de retorno de la subrutina llamada      | |
| r4-r7     | $a0-$a3       | Argumentos pasados a la subrutina llamada      | |
| r8-r15     | $t0-$t7      | Registros temporarios      | |
| r16-r23     | $s0-$s7       | Registros que deben ser salvados      | |
| r24-r25     | $t8-$t9       | Registros temporarios      | |
| r26-r27     | $k0-$k1      | Para uso del kernel del sistema operativo     | |
| R28     | $gp       | Global pointer - puntero a zona de memoria estástica. Debe ser salvado      | |
| R29     | $sp       | Stack Pointer - Puntero de pila. Debe ser salvado      | |
| R30     | $fp       | Frame Pointer -  Puntero de pila. Debe ser salvado      | |
| R31     | $ra       | Return Addres - Dir. de retorno de subrutina. Debe ser salvado      | |

Ejercicio_6
===========
```s
.data
    VALOR1: .word 2
    VALOR2: .word 4
    RES:    .word 0
    
.text
    ld $a0, VALOR1($zero)   ; a = 16
    ld $a1, VALOR2($zero)   ; a1 = 4
    jal a_la_potencia       ; Salta y guarda la dir en R31
    sd $v0, RES($zero)      ; Muesto el valor de retorno de la subrutina
    halt

    a_la_potencia: daddi $v0, $zero, 1  ; Incremento v0
        lazo: slt $t1, $a1, $zero       ; si a1 < 0 deja un 1 en t1
        bnez $t1, terminar              ; cuando t1 llega a 0 termino
        daddi $a1, $a1, -1              ; decremento a1
        dmul $v0, $v0, $a0              ; v0 = v0 * a0
        j lazo

    terminar: jr $ra

    ; El programa saca la potencia de un nro, el programa hace VALOR2 ^ VALOR1

    ; jal Salta a la dirección rotulada offN y copia en r31 la dirección de retorno

    ; Salta a la dirección contenida en el registro rd
```
Ejercicio_7
===========
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
Ejercicio_8
===========
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
Ejercicio_9
===========
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
Ejercicio_10
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
Ejercicio_11
============
```s
.data
    TABLA: .word 1,2,3,4,5,0
    IMPARES: .word 0
    MASCARA: .byte 00000001
.code
    DADDI $sp, $0, 0x400
    DADDI $a0, $0, TABLA
    DADD $v0, $0, $0 
    
    JAL CONT_IMPAR
    sd $v0,IMPARES($0)
HALT

CONT_IMPAR: DADDI $sp, $sp, -16     
    SD $ra, 0 ($sp)                  
    SD $s0, 8 ($sp)
    DADD $s0, $a0, $0  
    
    LOOP: LD $a0, 0 ($s0)	        ; Toma nro. actual
        BEQ $a0, $0, FIN            ; Si es el fin, termina
        JAL ESIMPAR
        dadd $v0,$v0,$v1
        DADDI $s0, $s0, 8           ; Avanza al siguiente nro
    J LOOP

    FIN: LD $ra, 0 ($sp)
        LD $s0, 8 ($sp)
        DADDI $sp, $sp, 16
        JR $ra

ESIMPAR: LD $s1,MASCARA($0)      ;inicializo la mascara(como constante)
    AND $t1, $a0, $s1            ;valor actual and mascara
    BEQZ $t1 ,PAR 
    DADDI $v1,$0, 1
    J TERMINO
    PAR: DADDI $v1, $0, 0     
    TERMINO: JR $ra         
```
Ejercicio_12
============
```s
.data
    NRO: .word 10
    RESULTADO: .word 0
.code
    daddi $sp, $0, 0x400    ; Inicializa el puntero al tope de la pila
    ld $a0, NRO($0)         ; a0 = NRO
    jal FACTORIAL           ; Llamo a la subrutina
    sd $v0, RESULTADO($0)   ; Guardo el dato
halt

 
FACTORIAL: daddi $sp, $sp, -16      ; PUSH
    sd $ra, 0($sp)
    sd $s0, 8($sp)

    beqz $a0, FIN_RECURSIVO         ; Si nro - 1 = 0, termino
    dadd $s0, $0, $a0               ; Tomo el valor actual    
    daddi $a0, $a0, -1              ; nro = nro - 1

    jal FACTORIAL                   ; RECURSIVO
    dmul $v0, $v0, $s0              ; v0 * nro actual
    j FIN                           ; termino

    FIN_RECURSIVO: daddi $v0, $0, 1

    FIN: ld $s0, 8($sp)             ; POP
        ld $ra, 0($sp)
        daddi $sp, $sp, 16
    jr $ra 
```
