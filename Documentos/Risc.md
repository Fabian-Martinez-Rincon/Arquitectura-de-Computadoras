<h1 align="center"> 💻RISC </h1>

Indice
======
   * [Instrucciones](#Instrucciones)
   * [Atascos](#Atascos)
     * [Estructurales](#Estructurales) 
     * [Dependencia_de_Datos](#Dependencia_de_Datos)
       * [RAW](#RAW) 
       * [Fordwarding](#Forwarding)
     * [Dependencia_de_Control](#Dependencia_de_Control)
       * [Branch Taken Stall](#Branch_Taken_Stall)
       * [Branch Target Buffer (BTB)](#Branch_Target_Buffer) 
       * [Delay Slot](#Delay_Slot)
   * [Fases de una instrucción](#Fases_de_una_instruccion)
   * [Codigos](#Codigos)
     * [Intercambio de datos](#Intercambio)
     * [Multiplicación](#Multiplicacion)
   * [Set de instrucciones](#SetDeInstrucciones) 
     * [De Transferencia de datos](#Instrucciones_de_Transferencia_de_datos)
     * [Aritmeticas](#Instrucciones_Aritmeticas)
     * [Logicas](#Instrucciones_Logicas)
     * [De desplazamiento de bits](#Instrucciones_de_desplazamiento_de_bits)
     * [De Transferencia de control](#Instrucciones_de_Transferencia_de_control)
     * [Control](#Instrucciones_control)


Instrucciones
=============

Veamos cómo nos manejamos con variables.

- Para empezar, ***todas*** las operaciones aritméticas-lógicas ***deben*** hacerse con ***registros***
- Si quiero usar variables, debo cargarlas antes en un registro
- Las variables se definen en un bloque .data y arrancan en la dirección 0
- Para tomar una variable se usa ***LD "DESTINO", "VARIABLE" (DESPLAZAMIENTO)***.

```s
.data                     ; LD R1, A (R0)
  A: .word 5              ; R1 = variable en dir. de A + 0
  B: .word 8
.code
  LD R1, A(R0)
```

- Para guardar un valor en memoria se utiliza el mismo mecanismo de desplazamiento
- La sintaxis es ***SD "REGISTRO ORIGEN", "VARIABLE" (DESPLAZAMIENTO)***

```s
.data                     ; SD R1, A (R0)
  A: .word 0              ; RES = VALOR DE R1 EN VARIABLE EN DIR. DE A + 0
.code
  DADDI R1, R0, 5
  SD R1, A(R0)
```


Atascos
=======

Se pueden dar en situaciones que impiden a la siguiente instruccion que se ejecute en el ciclo que le corresponde.

Los queremos evitar a toda costa. Si tenemos atascos significa que una instruccion esta estancada esperando algo de una instruccion anterior.

Estructurales
-------------

Provocados por conflicto de recursos

Dependencia_de_Datos
--------------------

RAW
---

Significa: Read After Write.

- Se produce cuando una instrucción necesita leer un dato que todavía no esta disponible.
- Si no nos queda de otra, podemos usar un ***NOP***

<table>
<tr>
<td> Por software </td> <td> Con NOPS </td> <td> Ordenando Sentencias </td>
</tr>
<tr>
<td>
 
```s
.data
    NUM1: .word 15

.code
    DADDI R1, R0, 8
    DADDI R2, R1, 10
    LD R7, NUM1 (R0)
HALT
```
</td>
<td>
 

```s
.data
    NUM1: .word 15

.code
    DADDI R1, R0, 8
    NOP
    NOP
    DADDI R2, R1, 10
    LD R7, NUM1 (R0)
HALT

```
 
</td>
<td>
  
```s
.data
    NUM1: .word 15

.code
    DADDI R1, R0, 8
    LD R7, NUM1 (R0)
    DADDI R2, R1, 10
HALT
  
```  
  
  
</td>
</tr>

 
</table>

- WAR Write After Read y WAW Write After Write (estan pero tengo idea del para que)

Forwarding
----------
***POR HARDWARE***
Si ya tenemos los valores necesarios, podemos "adelantarlos"

![bufer](https://user-images.githubusercontent.com/55964635/141218205-34408dfc-a65e-4603-a07b-d00ff3784647.png)

En estos buffers se almacena los valores para que los puedan usar en las próximas instrucciones. De esta manera no hace falta esperar a las etapas ***MEM*** y ***WB*** para usar los valores!. Este adelantamiento de operando lo llamamos ***Forwarding***. Los buffers no se pueden ver en el simulador. Una ventaja que tiene esta técnica es que nos permite postergar la "necesidad" de los operandos.

¿Cuando conviente tenerlo activado? Siempre es conveniente tenerlo activado (en la mayoria de los casos)

Dependencia_de_Control
----------------------

Provocados al esperar la decisión de otra instrucción anterior (por ejemplo: si se realiza o no un salto).

Tenemos dos tipos de saltos

- ***Incondicionales:*** Salta siempre.
- ***Condicionales:*** Salta dependiendo de que se cumpla una condición.

Fases_de_una_instruccion
========================
Las instrucciones se organizan en ***fases*** de manera que esto sea posible



<table>
<tr>
<td> Fases </td> <td> Funcion </td>
</tr>
<tr>
<td>
 
![if](https://user-images.githubusercontent.com/55964635/138571830-e84e64ad-3720-4abf-96cb-dff21fa88120.png)

  
</td>
<td>
 
```Instruction Fetch```
- Se accede a memoria por la instrucción
- Se incrementa el PC (antes conocido como el IP)
 
</td>

</tr>
  
<tr>
<td>
  
![ID](https://user-images.githubusercontent.com/55964635/138571834-3aceb35f-500d-47f2-b236-2b1dd4600a34.png)
  
</td>
<td>
 
```Instruction Decoding```
 
- Se decodifica la instruccion
- Se accede al banco de registros por los operandos. Se atasca si no están disponibles
- Se calcula el valor del operando inmediato
- Si es un salto, se calcula el destino y si se toma o no (requiere acceder al banco de reg)
  
</td>

</tr>

<tr>
<td>
 
![EX](https://user-images.githubusercontent.com/55964635/138571858-3e9bb33b-1038-414a-915f-213a92fc7652.png)

 
  
</td>
<td>
 
```Execution```
 
- Si es una instrucción de cómputo, se ejecuta en la ALU
- Si es un acceso a memoria, se calcula la dirección efectiva
- Si es un salto, se realiza (se modifica el registro PC)
  
</td>

</tr>

<tr>
<td>
  
 ![ME](https://user-images.githubusercontent.com/55964635/138571868-6e02dbbd-f576-4d33-a165-c52618c1dd16.png)


</td>
<td>
 
```Memory access```
  
- Si es un acceso a memoria, se lee/escribe el dato
 
</td>

</tr>

<tr>
<td>
 
![WB](https://user-images.githubusercontent.com/55964635/138571875-ba381a67-ea8c-44f3-98d0-c1f5e69b9d75.png)

  
</td>
<td>
 
```Write Back```
  
- Se almacena el resultado ***(si lo hay)*** en los registros
</td>

</tr>
   

</table>

Codigos
=======
  
Intercambio
-----------
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

Multiplicacion
--------------
```s
.data
    NUM1: .word 5
    NUM2: .word 8
    RES:  .word 0

.code
    LD R1, NUM1 (R0)
    LD R2, NUM2 (R0)

    ;MULTIPLICAMOS 
    DMUL R3, R1, R2

    ;ALMACENAMOS EL RESULTADO EN RES
    SD R3, RES (R0)

HALT
```


Instrucciones_de_Transferencia_de_datos
=======================================

![1 2](https://user-images.githubusercontent.com/55964635/138572631-5ffa8dad-9e94-4169-98b1-6da7469b068a.png)

Instrucciones_Aritmeticas
=========================

![2 2](https://user-images.githubusercontent.com/55964635/138572635-14e74e64-d413-4683-b2ca-44fd9d8cb4b7.png)

Instrucciones_Logicas
=====================

![3 2](https://user-images.githubusercontent.com/55964635/138572637-cced63b8-1c27-4b7b-8f1d-a65127dd239e.png)

Instrucciones_de_desplazamiento_de_bits
=======================================

![4 2](https://user-images.githubusercontent.com/55964635/138572646-63c7e2e5-eae3-487a-8078-6e6533acc5a8.png)

Instrucciones_de_Transferencia_de_control
=========================================

![5 2](https://user-images.githubusercontent.com/55964635/138572649-ae11d424-0282-48ef-8858-35b94f457428.png)

Instrucciones_control
=====================

![6 2](https://user-images.githubusercontent.com/55964635/138572652-3c317cb1-732d-41a9-999e-fa6494174c87.png)

