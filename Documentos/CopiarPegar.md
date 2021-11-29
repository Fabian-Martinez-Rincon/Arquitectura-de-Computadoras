<h1 align="center"> 💻RISC </h1>

Indice
======
   * [Instrucciones](#Instrucciones)
   * [Atascos](#Atascos)
     * [Estructurales](#Estructurales) 
     * [Dependencia_de_Datos](#Dependencia_de_Datos)
       * [RAW](#RAW) 
       * [Fordwarding](#Forwarding)
       * [WAR y WAW](#WAR_Y_WAW)
     * [Dependencia_de_Control](#Dependencia_de_Control)
       * [Branch Taken Stall](#Branch_Taken_Stall)
       * [Branch Target Buffer (BTB)](#Branch_Target_Buffer) 
       * [Delay Slot](#Delay_Slot)
   * [Punto Flotante](#Punto_Flotante) 
   * [Subrutinas](#Subrutinas)
   * [E/S](#Entrada_Salida)
     * [Pantalla Alfanumérica](#Pantalla_Alfanumerica) 
     * [Pantalla Grafica](#Pantalla_Grafica) 
     * [Teclado](#Teclado) 
   * [Fases de una instrucción](#Fases_de_una_instruccion)
   * [Codigos](#Codigos)
     * [Intercambio de datos](#Intercambio)
     * [Multiplicación](#Multiplicacion)
     * [Potencia](#Potencia)
     * [BASE_EXPONENTE](#BASE_EXPONENTE)
     * [Pasar un String a mayusculas](#String_Mayusculas)
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

Provocados por conflicto de recursos.

En el MIPS sucede cuando dos instrucciones intentan acceder a la etapa ***MEM*** simultáneamente.



<table>

<tr>
<td>
 
![Imagen1](https://user-images.githubusercontent.com/55964635/141484332-582750ca-f2a6-489a-b82e-5ea5d366c52e.png)

  
</td>
<td>
 

Dos instrucciones listas para pasar a la etapa de memoria.
  
Se produce un atasco estructural y solo pasa una de ellas
  
***Tiene prioridad la primera instruccion que entró en el cause***
 
</td>
</tr>
 
</table>

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

WAR_Y_WAW
=========

Se producen cuando:
- Hay ***dependencia de datos*** entre dos instrucciones (igual que RAW)
- Una instrucción puede sobrepasar a una instrucción anterior, queriendo escribir un registro pendiente de lectura ```(WAR)``` o escritura ```(WAW)```
- El simulador produce atascos cuando detecta una situación potencial (***Puede que realmente no suceda***) de dependencia WAR o WAW.

<table>
<tr>
<td> Ejemplo 1 </td> <td> Ejemplo 2 </td>
</tr>
<tr>
<td>
 
```s
.data
    n1:    .double 	9.13 
    n2:    .double 	6.58 
    res1:  .double 	0.0 
    res2:  .double 	0.0 

.code 
    L.D F1, n1 (R0)     ; F1 = n1
    L.D F2, n2 (R0)     ; F2 = n2
    ADD.D F3, F2, F1    ; F3 = F2 + F1
    MUL.D F4, F2, F1    ; F4 = F2 * F1
    S.D F3, res1 (R0)   ; Guarda la suma en res1
    S.D F4, res2 (R0)   ; Guarda la mult en res2
HALT
```
</td>
<td>
 

```s
.data
    n1:    .double 	9.13 
    n2:    .double 	6.58 
    res1:  .double 	0.0 
    res2:  .double 	0.0 

.code 
    L.D F1, n1 (R0)     ; F1 = n1
    L.D F2, n2 (R0)     ; F2 = n2
    ADD.D F3, F2, F1    ; F3 = F2 + F1
    MUL.D F2, F2, F1    ; F2 = F2 * F1
    MUL.D F4, F2, F1    ; F4 = F2 * F1
    S.D F3, res1 (R0)   ; Guarda la suma en res1
    S.D F4, res2 (R0)   ; Guarda la mult en res2
HALT
```
 
</td>
</tr>
 
</table>

Dependencia_de_Control
----------------------

Provocados al esperar la decisión de otra instrucción anterior (por ejemplo: si se realiza o no un salto).

Tenemos dos tipos de saltos

- ***Incondicionales:*** Salta siempre.
- ***Condicionales:*** Salta dependiendo de que se cumpla una condición.

Branch_Taken_Stall
------------------

Definicion: Atasco de salto, es un salto que tuvimos que haber hecho y no lo hicimos. (Empezamos a ejecutar una instrucción que no debiamos ejecutar). El programa se da cuenta, corta la ejecución y abajo comienza la sentencia que tendria que haber ejecutado.

***Ejemplo:***



<table>
<tr>
<td> Ejemplo </td> <td> Estadisticas </td>
</tr>
<tr>
<td>
 
```s
.data
B: .word 5

.code
    DADDI R1, R0, 1
    LD R2, B (R0)
    LOOP: DSLL R1, R1, 1    ; Desplazo a la izquierda
        DADDI R2, R2, -1    ; Cant. de desplazamientos que faltan
        BNEZ R2, LOOP       ; Si no es 0 salto a LOOP
HALT

```
  
</td>
<td>
 

![image](https://user-images.githubusercontent.com/55964635/141319796-9e25a0de-8651-48ea-9627-92abc1ae44ac.png)
 
</td>
</tr>
 
</table>

Branch_Target_Buffer
--------------------

Al igual que los atascos de dependencia de datos, tenemos diferentes técnicas para evitar los atascos por saltos.

La primera se denomina ***Branch Target Buffer*** que consiste en tener un flag que indica que si se debe saltar incondicionalmente o no dependiendo de qué hizo antes (es decir, predice).

Cada vez que ese flag/buffer se actualiza cuenta como un ***atasco de salto!*** Cada vez que le erramos a la predicción cuenta como atasco.

***Misprediction*** (nuevo atasco): Es un atasco que me va a contabilizar cuando el ***BTB*** este equivocado

***Ejemplo:***

![gifPro](https://user-images.githubusercontent.com/55964635/141326920-15b9364c-8d09-4fa5-94a4-dd1708c6cd70.gif)

***¿Cuando conviene activar el BTB?***

Como solo fallamos al principio y al final de loop, conviene usarlo cuando tenemos bucles muy grandes. (sin condiciones de por medio)

<table>
<tr>
<td> Buenoooo </td> <td> Maloooo </td>
</tr>
<tr>
<td>
 
```Pas
for i:=1 to 100000000 do
begin
  // Hace algo                          
end;
```
  
Vamos a tener dos atascos al principio
y dos atascos al final
  
</td>
<td>
 


```Pas
for i:=1 to 100000000 do
begin
  if i es par then
    // Hace algo
  else
    // Hace otro algo
end;
```

Vamos a tener dos atascos en cada interación 
(porque vamos a fallar la predicción)
 
</td>
</tr>
 
</table>

Delay_Slot
----------

Es la otra técnica. Simplemente consiste en ejecutar ***SIEMPRE*** la siguiente instrucción a un salto

<table>
<tr>
<td> Programa </td> <td> Definicion </td>
</tr>
<tr>
<td>
 
```s
DADDI R2, R0, 3
LOOP: DADDI R2, R2, -1
  BNEZ R2, LOOP
HALT
```

Se terminaría el programa ya que se ejecuta el ***HALT*** en la primera interación!
  

  
</td>
<td>
 


- Buscamos ubicar instrucciones que ***no dependen del salto***
- De esta manera aprovechamos una instrucción y no tenemos atascos de salto!
- Cómo último recurso usar sentencias NOP


 
</td>
</tr>
 



<tr>
<td> Ejemplo Mal </td> <td> Delay Slot Activado </td>
</tr>
<tr>
<td>
 
```s
.data
    cant: .word 8
    datos: .word 1, 2, 3, 4, 5, 6, 7, 8
    res: .word 0

.code
    DADD R1, R0, R0          ; Inicializa R1 = 0
    LD R2, cant (R0)         ; R2 = cant
    LOOP: LD R3, datos (R1)  ; R3 = elemento de datos en la posición R1
        DADDI R2, R2, -1     ; Resta 1 a la cantidad de elementos a procesar
        DSLL R3, R3, 1       ; Multiplica por dos el elemento actual
        SD R3, res (R1)      ; Almacena el resultado en la tabla de resultados
        DADDI R1, R1, 8      ; Avanza a la siguiente posición
        BNEZ R2, LOOP        ; Si quedan elementos sigo iterando
    NOP
HALT

```
  
</td>
<td>
 

![image](https://user-images.githubusercontent.com/55964635/141335494-364c723f-0629-43df-9db7-8dc6ed41a694.png)
 
</td>
</tr>
  
  
<tr>
<td> Ejemplo Bien </td> <td> Delay Slot Activado </td>
</tr>
<tr>
<td>
 
```s
.data
    cant: .word 8
    datos: .word 1, 2, 3, 4, 5, 6, 7, 8
    res: .word 0

.code
    DADD R1, R0, R0          ; Inicializa R1 = 0
    LD R2, cant (R0)         ; R2 = ca
    LOOP: LD R3, datos (R1)  ; R3 = elemento de datos en la posición R1
        DADDI R2, R2, -1     ; Resta 1 a la cantidad de elementos a procesar
        DSLL R3, R3, 1       ; Multiplica por dos el elemento actual
        SD R3, res (R1)      ; Almacena el resultado en la tabla de resultados
        BNEZ R2, LOOP        ; Si quedan elementos sigo iterando
    DADDI R1, R1, 8          ; Avanza a la siguiente posición
HALT

```
  
</td>
<td>
 

![image](https://user-images.githubusercontent.com/55964635/141336345-a413cef9-aa34-43b5-bc52-18657310112f.png)
 
</td>
</tr>
 
</table>

Punto_Flotante
==============

MIPS utiliza IEE 754 para números en punto flotante.

Contamos con 32 registros: desde F0 (simpre vale 0) hasta F31

Tiene un único tipo de dato que es el .double

[Pagina recomendada](https://zator.com/Cpp/E2_2_4a1.htm)

***NO todas las etapas tardan lo mismo***.
- Generales = 1 ciclo
- Multiplicar en Pto. F. = 7 ciclos
- Sumar en Pto. F. = 4 ciclos.
- Dividir en Pto. F. = 24 Ciclos

Esta arquitectura nos permite tener múltiples instrucciones en la etapa EX

Podemos ejecutar múltiples instrucciones en menos tiempo!

No todo es color de rosas. Introduce los siguientes atascos:

- Dependencia Estructural
- Dependencia de datos ***WAR***
- Dependencia de datos ***WAW***

Subrutinas
==========

***IMPORTANTE***
- No hay manejo implícito de la pila!
- La dirección de retorno ***siempre*** estará en ***R31***
  - Esto si se hace implícitamente en el ***JAL***
- Los registros se pueden ***sobrescribir*** , incluído ***R31***
  - Vamos a tener que salvarlos en la pila 

***CONVENCIONES***

Las subrutinas deben garantizar el guardado de los registros que correspondan. De esta manera, una subrutina podrá llamar a otra sabiendo que esta no modificará el valor de estos registros, para poder mantener esta garantía, es necesario guardar los registros en la ***pila***. (PERO MIPS NO TIENE PILA 😧). Pero existe un registro que por convención todas las subrutinas usarán como puntero al tope de la pila. Y ese registro es.........

```El registro $sp```

<table>
<tr>
<td> PUSH $t1 </td> <td> POP $t1 </td>
</tr>
<tr>
<td>
 
```s
daddi $sp, $sp, -8 ; "Subo" una celda de memoria
sd $t1, 0 ($sp)    ; Almaceno el dato
```
</td>
<td>
 

```s
ld $t1, 0 ($sp)     ; Extraigo el dato
daddi $sp, $sp, 8   ; "Bajo" una celda de memoria
```
 
</td>
</tr>
 
</table>




<table>
  
  
<tr>
<td> Como ejemplo </td> <td> Como lo vamos a usar </td>
</tr>
<tr>
<td>
 
```s
.data
    NUM1: .word 5
    NUM2: .word 8
    RES: .word 0

.code
    LD R1, NUM1 (R0)
    LD R2, NUM2 (R0)
    JAL SUMAR ; Llama a la subrutina
    SD R3, RES (R0)
HALT

SUMAR: DADD R3, R1, R2 
    JR R31 ; Retorna al punto donde fue llamado
```
</td>
<td>
 

```s
.data
    NUM1: .word 5
    NUM2: .word 8
    RES: .word 0

.code
    LD $a0, NUM1 (R0)
    LD $a1, NUM2 (R0)
    JAL SUMAR ; Llama a la subrutina
    SD $v0, RES (R0)
HALT

SUMAR: DADD $v0, $a0, $a1
    JR $ra ; Retorna al punto donde fue llamado
```
 
</td>
</tr>
 
</table>

![registros](https://user-images.githubusercontent.com/55964635/141483880-dd4a0804-4b23-4d06-873d-0b8fe19a2515.png)


- En verde aquellos que, en caso de usarse, ***deben ser salvados***
- En azul aquellos que podemos sobrescribir sin ningún problema

Entrada_Salida
==============
Existen dos "registros" (es decir, dos celdas de memoria comunes)

- ***CONTROL*** sirve para enviar códigos de operaciones. (0x10000)
- ***DATA*** sirve para enviar o recibir datos.	(0x10008)

Como son celdas de memoria se leen y escriben con instrucciones de memoria: LD/L.D/LBU/SD/S.D....


Pantalla_Alfanumerica
---------------------

***IMPRIMIR UN STRING***
- ***DATA*** --> Direccion del string
- ***CONTROL*** --> El valor 4

***IMPRIMIR UN NÚMERO***
- ***DATA*** --> El Dato
- ***CONTROL*** 
  - 1 Imprime un ***entero sin signo***
  - 2 Imprime un ***entero con signo***
  - 3 Imprime un ***flotante***

***LIMPIAR LA PANTALLA***
- ***CONTROL*** -> El valor 6

<table>
<tr>
<td> Imprimir Entero </td> <td> Imprimir Double </td> <td> Imprimir String </td>
</tr>
<tr>
<td>
 
```s
.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    NUM:     .word 2

.code
    LD $s0, CONTROL ($0)    
    LD $s1, DATA ($0)      

    LD $t0, NUM ($0)
    SD $t0, 0 ($s1)         
     ; CONTROL = 2
    DADDI $t0, $0, 2
    SD $t0, 0 ($s0)        
    ; LIMPIA LA PANTALLA
    ;DADDI $t0, $0, 6       
    ;SD $t0, 0 ($s0)        
HALT
```
</td>
<td>
 

```s
.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    NUM:     .double 19.5

.code
    LD $s0, CONTROL ($0)    
    LD $s1, DATA ($0)      

    L.D f1, NUM ($0)
    S.D f1, 0 ($s1)        
    ; Control 3
    DADDI $t0, $0, 3
    SD $t0, 0 ($s0)         

    ;DADDI $t0, $0, 6       
    ;SD $t0, 0 ($s0)        
HALT
```
 
</td>
	
<td>

```s
.data
    CONTROL:  .word 0x10000
    DATA:     .word 0x10008
    TEXTO:    .asciiz "Hola, Mundo!" 

.code
    LD $s0, CONTROL($0)  
    LD $s1, DATA($0)      
     
    DADDI $t0, $0, TEXTO  
    SD $t0, 0($s1)        
    
    DADDI $t0, $0, 4      
    SD $t0, 0($s0)        
HALT

;(1) $t0 = 4 -> función 4: salida de una cadena ASCII
;(2) CONTROL recibe 4 y produce la salida del mensaje

```
	
</td>
	
</tr>
 
</table>

Pantalla_Grafica
----------------
Pantalla de 50x50px

***PINTAR UN PÍXEL***
- ***DATA*** --> Color y coordenadas
- ***CONTROL*** --> El valor 5

***LIMPIAR LA PANTALLA***
- ***CONTROL*** -> El valor 7

![NUEVOOWO](https://user-images.githubusercontent.com/55964635/141663154-5352df7d-2e41-46a4-b4f9-49837c3a5349.png)






<table>
<tr>
<td>
 
```s
.data ;Imprimir un pixel
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    PIXEL:   .byte 0, 185, 135, 0, 23, 10, 0, 0
.code 
    LD $s0, CONTROL ($0)     ; $s0 = CONTROL
    LD $s1, DATA ($0)        ; $s1 = DATA

    LD $t0, PIXEL ($0)
    SD $t0, 0 ($s1)      ; Mando el dato a DATA

    DADDI $t0, $0, 5
    SD $t0, 0 ($s0)             ; CONTROL = 5

HALT
```
</td>
<td>
 

```s
.data
    coorX:   .byte 24 ; X
    coorY:   .byte 24 ; Y
    color:   .byte 255, 0, 255, 0 
    CONTROL: .word 0x10000
    DATA:    .word 0x10008

.code 
    ld $s0, CONTROL ($zero)   ; $s0 = dir de CONTROL
    ld $s1, DATA ($zero)      ; $s1 = dir de DATA

    ; limpia la pantalla

    daddi $t0, $zero, 7			
    sd $t0, 0 ($s0) 				

    lbu $t0, coorX ($zero) 			
    sb $t0, 5 ($s1) 				

    lbu $t1, coorY ($zero)    ; $t1 = valor de coordenada Y
    sb $t1, 4 ($s1) 	      ; DATA + 4 recibe el valor de coordenada Y
    
    lwu $t2, color ($zero)    ; $t2 = color
    sw $t2, 0 ($s1) 	      ; Pongo color en DATA
    daddi $t0, $zero, 5
    sd $t0, 0 ($s0) 	      ; Pinta el píxel
HALT
```
 
</td>
</tr>
 
</table>

Teclado
-------

***LEER UN NÚMERO (ENTERO O FLOTANTE)***

- ***CONTROL*** --> El valor 8
- ***DATA*** --> 
  - ***Muestra*** el caracter presionado
  - Termina de leer cuando presiona ENTER
  - Si el dato ingresado no es un número se guarda 0. Tomar el valor (***HEXADECIMAL***) con LD o L.D desde ***DATA***

***LEER UN CARACTER***
- ***CONTROL*** -> El valor 9
- ***DATA*** ->
  - ***NO*** muestra el caracter presionado
  - No espera al ENTER
  - Tomar el valor (***ASCII***) con LBU desde ***DATA*** 

<table>
<tr>
<td> Leer Double </td> <td> Leer Infinito </td>
</tr>
<tr>
<td>
 
```s
.data ;leer desde teclado
    CONTROL:    .word 0x10000
    DATA:       .word 0x10008
    NUM:        .double 0.0
    CARACTER:   .byte 0

.code
    LWU $s0, CONTROL ($zero) 	; $s0 = CONTROL
    LWU $s1, DATA ($zero) 	   	; $s1 = DATA

    DADDI $t0, $zero, 8
    SD $t0, 0 ($s0)             ; CONTROL = 8
    L.D f1, 0 ($s1)             ; Tomo número en f1
    S.D f1, NUM ($zero)         ; Guardo en variable

    DADDI $t1, $zero, 9
    SD $t1, 0 ($s0)             ; CONTROL = 9
    LBU $t1, 0 ($s1)            ; Tomo caracter en $t1
    SB $t1, CARACTER ($zero)    ; Guardo en variable
HALT
```
</td>
<td>
 

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
 
</td>
</tr>
 
</table>



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
Potencia
--------
```s
.data
    B: .word 5

.code
    DADDI R1, R0, 1
    LD R2, B (R0)
    LOOP: DSLL R1, R1, 1    ; Desplazo a la izquierda
        DADDI R2, R2, -1    ; Cant. de desplazamientos que faltan
        BNEZ R2, LOOP       ; Si no es 0 salto a LOOP
HALT
```

String_Mayusculas
-----------------
```s
.data
cadena: .asciiz "Caza"

.code
    ; La pila comienza en el tope de la memoria de datos
    DADDI $sp, $0, 0x400 ; bus 10 bits 🡪 2^10 = 1024 = 0x400

    ; Guarda como primer argumento para upcaseStr
    ; la dirección de cadena
    DADDI $a0, $0, cadena
    JAL upcaseStr
HALT

upcaseStr: DADDI $sp, $sp, -16      ; Reserva lugar en pila -> 2 x 8
    SD $ra, 0 ($sp)                 ; Guarda en pila $ra
    SD $s0, 8 ($sp)                 ; Guarda en pila $s0
    DADD $s0, $a0, $zero            ; Copia la dirección de inicio de la cadena
    LOOP: LBU $a0, 0 ($s0)	        ; Toma car. actual
        BEQ $a0, $zero, FIN         ; Si es el fin, termina
        JAL upcase
        SB $v0, 0 ($s0)             ; Guarda el caracter procesado en la cadena
        DADDI $s0, $s0, 1           ; Avanza al siguiente caracter
    J LOOP
    ; Recupera los datos salvados en la pila
    FIN: 	LD $ra, 0 ($sp)
    LD $s0, 8 ($sp)
    DADDI $sp, $sp, 16
    JR $ra


; Pasa un caracter a mayúscula.
; Parámetros: $a0 -> caracter
; Retorna $v0 -> caracter en mayúscula
; No se utiliza la pila porque no se usan registros que deban ser salvados

upcase: DADD $v0, $a0, $zero
SLTI $t0, $v0, 0x61 ; Compara con ‘a’ minúscula
	BNEZ $t0, salir ; No es un caracter en minúscula
	SLTI $t0, $v0, 0x7B ; Compara con el car sig a 'z' minúscula (z=7AH)
	BEQZ $t0, salir ; No es un caracter en minúscula
	DADDI $v0, $v0, -0x20 ; Pasa a minúscula
salir: JR $ra 	; Retorna
```

BASE_EXPONENTE
==============

```s
.data
    BASE: .word 2
    EXPONENTE: .word 3
.code
    LD $t0, BASE($0)
    LD $t1, EXPONENTE($0)
    DADD $t2, $t2 , $t0
    LOOP: BEQZ $t1, TERMINO
        dmul $t2, $t2, $t0  
        DADDI $t1, $t1, -1        
    J LOOP
TERMINO: HALT
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

