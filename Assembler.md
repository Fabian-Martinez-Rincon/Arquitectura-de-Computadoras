<h1 align="center"> 💻Assembler</h1>


Indice
=================

   * [If](#IF)
   * [Potencias](#Potencias)
   * [Suma De Elementos en una Tabla](#Suma_De_Elementos_En_Una_Tabla)
   * [Menores o Iguales de x en una Tabla](#Menores_o_Iguales_de_X_en_una_Tabla)
   * [Suma De Vectores](#Suma_De_Vectores)
   * [Subrutinas](#Subrutinas)
   * [Parametros_Por_Valor](#Parametros_Por_Valor)
   * [Parametros Por Referencia](#Parametros_Por_Referencia)
   * [SWAP](#SWAP)
   * [SUMA DE TODA LA TABLA ES PAR](#Suma_tabla_par)


IF
================


<table>
<tr>
<td> Variables </td> <td> IF A < B THEN </td> <td>IF A <= B THEN</td> <td>IF A = B THEN</td>
</tr>
<tr>
<td>
 
```Assembly
ORG 1000H
  A DB 4
  B DB 8
  C DB ?

C:=A
else
C:=B
```
</td>
<td>
 

```Assembly
org 2000h
  MOV AL, A
  MOV BL, B
  MOV CL, C
  CMP AL,BL
  JS MENOR
  MOV C,BL
  JMP TERMINAR
  MENOR: MOV C,AL
  TERMINAR:HLT
END
```
  
</td>
<td>
  
 ```Assembly
org 2000h
  MOV AL, A
  MOV BL, B
  MOV CL, C
  CMP AL,BL
  JS MENOR
  JZ MENOR
  MOV C,BL
  JMP TERMINAR
  MENOR: MOV C,AL
  TERMINAR:HLT
 END
  ```
 </td>
  <td>
    
```Assembly
org 2000h
  MOV AL, A
  MOV BL, B
  MOV CL, C
  CMP AL,BL
  JZ IGUAL
  MOV C,BL
  JMP TERMINAR
  IGUAL: MOV C,AL
  TERMINAR:HLT
END
```
  </td>
</tr>
</table>

Potencias
=========
```Assembly
ORG 2000H ;empiezo en la 2000
  MOV AX, 1  ;Al registro le pongo 1 en AL
  MOV BX, 1000H  
  CARGA: MOV [BX], AX ; A la direccion 1000H mando 1 que es AX
  ADD BX, 2 ; A 1000h le sumo 2h= 1002h
  ADD AX, AX ;hago 1 + 1 =2
  CMP AX, 200 ; resto Ax - 200
  JS CARGA  ; Vuelve a carga hasta que Ax-200 sea positivo
  HLT
END
;1,2,4,8,16,32,64,128,256
```

Suma_De_Elementos_En_Una_Tabla
==============================

<table>
<tr>
<td> Variables </td> <td> Programa Principal </td>
</tr>
<tr>
<td>
 
```Assembly
ORG 1000H
  TABLA DB 2,4,6,8,10,12,14,16,18,20
  FIN DB ? 
  ;Lo empiezo con basura 1010h
  TOTAL DB ? 
  ;Tambien tiene basura 1011h
  MAX DB 13 ; 1012h
```
</td>
<td>
 

```Assembly
ORG 2000H
  MOV AL, 0  ;Pongo el registro AL en 0
  MOV CL, OFFSET FIN-OFFSET TABLA ;Resta ambas direcciones
  ;100Ah-1000h
  ;El resultado nos da la cantidad de elementos que tiene tabla
  MOV BX, OFFSET TABLA ;Mandamos al registro BX la dir de tabla (1000h)
  SUMA: ADD AL, [BX];Sumo a lo que apunta 1000h se lo suma al registo AL
  INC BX ;Incremento la posicion de memoria para ir a 1001h
  DEC CL ;Decremento el contador de elementos que tengo en la tabla
  JNZ SUMA ;Mientras nuestro contador no esta en cero
  HLT
END
; El resultado final es 6E (110 en decimal) 
```
 
</td>
</tr>
 
</table>

Menores_o_Iguales_de_X_en_una_Tabla
===================================

<table>
<tr>
<td> Variables </td> <td> Programa Principal </td>
</tr>
<tr>
<td>
 
```Assembly
ORG 1000H
  TABLA DB 2,4,6,8,10,12,14,16,18,20
  FIN DB ?
  TOTAL DB ?
  MAX DB 13
```
</td>
<td>
 

```Assembly
ORG 2000H
  MOV AL, 0 ;Inicializo el contador de elementos menores iguales
  MOV CL, OFFSET FIN-OFFSET TABLA ;Saco los elementos de la tabla 
  MOV BX, OFFSET TABLA ;Le paso la posicion de tabla (1000h)
  MOV DL, MAX  ;Inicializo Max que es 13
  COMPARA: CMP [BX],DL ;A lo que apunta BX le resto 13
  JS MENOR_IGUAL ;Si [BX] - 13 es negativo lo mando a la etiqueta
  JZ MENOR_IGUAL ; Si es igual tambien lo mando a la etiqueta
  JMP SIGUE   ;Si no se cumple ningunas, salto a sigue e incremento en BX
  MENOR_IGUAL: INC AL;El contador
  SIGUE: INC BX
  DEC CL ;Decrenebto hasta que los elementos sean 0
  JNZ COMPARA  ;Si el contador no llego a 0 vuelvo a comparar
  mov TOTAL,AL ;La cantidad de elementos menores iguales los paso a total
  HLT
END
```
 
</td>
</tr>
 
</table>

Suma_De_Vectores
================

<table>
<tr>
<td> Variables </td> <td> Programa Principal </td>
</tr>
<tr>
<td>
 
```Assembly
; Memoria de Datos
ORG 1000H
  TAB1 DW 1, 1, 1, 1, 1, 1
  ;6 Elementos de 16 bits c/u 
  TAB2 DW 2, 2, 2, 2, 2, 2
  TAB3 DW ?, ?, ?, ?, ?, ?
  ;Guardo las direcciones para el resultado

  Contador DB 6 
  ;Para recorrer la tabla 

  DIRECCION DW ?  
  ;Es solo para no perder la direccion de TAB3
```
</td>
<td>
 

```Assembly
ORG 2000H
  MOV AX, OFFSET TAB1 ;Guardo la dir de Tab1 en AX
  MOV CX, OFFSET TAB2 ;Guardo la dir de Tab2 en CX
  MOV DIRECCION, OFFSET TAB3;Guardo la dir de Tab3 en DIRECCION

  BUCLE: MOV BX, AX ;Copio AX en BX
  MOV DX, [BX] ;Copio el contenido de la direccion BX
  MOV BX, CX ;Copio CX en BX
  ADD DX, [BX];Sumo TAB1 con TAB2

  MOV BX, DIRECCION ;Copio en BX la direccion de TAB3
  MOV [BX], DX ;A TAB3 le paso la suma de TAB1 + TAB2

  ADD AX, 2 ;Como tengo 2 bytes por numero, avanzo sumando 2
  ADD CX, 2 ;x2
  ADD DIRECCION, 2 ;x3

  DEC Contador; Repito para todos los numeros de la tabla
  JNZ BUCLE ;Si el flag Z no es 0, vuelvo a ejecutar
  HLT
END
```
 
</td>
</tr>
 
</table>

Subrutinas
==========

<table>
<tr>
<td> Variables </td> <td> Modulo </td> <td>Programa Principal</td>
</tr>
<tr>
<td>
 
```Assembly
ORG 1000H
  NUM1 DW 3
  NUM2 DW 3
  RES DW ?
```
</td>
<td>
 

```Assembly
ORG 3000H
  MUL:MOV CX,0 
  ;Por el momento el resultado es 0
  LOOP: ADD CX,BX
    DEC AX
    JNZ LOOP
  FIN: RET
```
 
</td>
<td>
  
```Assembly
ORG 2000H
  ;Inicializamos AX y BX
  MOV AX,NUM1
  MOV BX,NUM2
  CALL MUL
  MOV RES,CX
  HLT 
END
```
</td>
</tr>
 
</table>

Parametros_Por_Valor
====================

<table>
<tr>
<td> Variables </td> <td> Modulo </td> <td>Programa Principal</td>
</tr>
<tr>
<td>
 
```Assembly
ORG 1000H
   NUM1 DW 3
   NUM2 DW 3
   RES DW ?
```
</td>
<td>
 

```Assembly
ORG 3000H
   MUL:MOV CX,0 ;Por el momento el resultado es 0
   MOV BX, SP 
   ADD BX,2 ;Posiciono en NUM2
   MOV DX, [BX] ;Tomo NUM2 en DX
   ADD BX,2 ;Posiciono en NUM1
   MOV AX,[BX];Tomo NUM1 en AX
   LOOP: ADD CX,DX
      DEC AX
      JNZ LOOP
   FIN: RET
```
 
</td>
<td>
  
```Assembly
ORG 2000H
  ;Inicializamos AX y BX
  MOV AX,NUM1
  MOV BX,NUM2
  ;Apilamos antes de llamar
  PUSH AX
  PUSH BX
  CALL MUL
  MOV RES,CX
  POP AX
  POP BX
  HLT 
END
```
</td>
</tr>
 
</table>


Parametros_Por_Referencia
=========================

<table>
<tr>
<td> Variables </td> <td> Modulo </td> <td>Programa Principal</td>
</tr>
<tr>
<td>
 
```Assembly
ORG 1000H
   NUM1 DW 3
   NUM2 DW 3
   RES DW ?
```
</td>
<td>
 

```Assembly
ORG 3000H
  MUL:MOV BX, SP 
  ;Tomo Valor de NUM2 en AX
  ADD BX,2       ;Posiciono en DIR de NUM2
  MOV AX, [BX]   ;AX = Dir de NUM2
  MOV DX, BX     ;Backup de BX
  MOV BX, AX     ;BX = Dir de NUM2
  MOV AX, [BX]   ;AX = NUM2
  MOV BX, DX     ;Recupero el puntero de la pila
  
  ;Tomo valor NUM1 en DX
  ADD BX, 2
  MOV DX, [BX] ;DX = DIR NUM1(1000H)
  MOV BX, DX   ;BX = DIR NUM1(1000H)
  MOV DX, [BX] ;DX = NU1
  
  ;MULTIPLICAR
  LOOP: ADD CX,DX
    DEC AX
    JNZ LOOP
    
  FIN: RET
```
 
</td>
<td>
  
```Assembly
ORG 2000H
  ;Inicializamos AX y BX
  MOV AX,NUM1
  MOV BX,NUM2
  ;Apilamos antes de llamar
  PUSH AX
  PUSH BX
  CALL MUL
  MOV RES,CX
  POP AX
  POP BX
  HLT 
END
```
</td>
</tr>
 
</table>

SWAP
====

<table>
<tr>
<td> Variables </td> <td> Modulo </td> <td>Programa Principal</td>
</tr>
<tr>
<td>
 
```Assembly
ORG 1000H
 NUM1 DW 3
 NUM2 DW 2
```
</td>
<td>
 

```Assembly
ORG 3000H
  SWAP: PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  
  MOV BX, SP
  ;Tomar Dir NUM1
  ADD BX, 12
  MOV AX,[BX]
  
  ;Tomar Dir NUM2
  SUB BX, 2
  MOV CX, [BX]
  
  ;Tomar Valor NUM1
  MOV BX, AX
  MOV AX, [BX]
  MOV DX, BX  ;GUARDAMOS DIR NUM1
  
  ;Tomar Valor NUM2
  MOV BX, CX
  MOV CX, [BX]
  
  ;Insertar Valor de Num1 en Dir Num2
  MOV [BX], AX
  
  ;Insertar Valor de Num1 en Dir Num2
  MOV BX, DX
  MOV [BX], CX
  
  POP DX
  POP CX
  POP BX
  POP AX

    
  RET
```
 
</td>
<td>
  
```Assembly
ORG 2000H
  ;Inicializamos AX y BX
  MOV AX,OFFSET NUM1
  PUSH AX
  MOV AX,OFFSET NUM2
  PUSH AX
  CALL SWAP
  HLT 
END
```
</td>
</tr>
 
</table>

Suma_tabla_par
==============
```Assembly
ORG 1000H
  TABLA DB 2,4,6,8,10,12,14,16,18,20
  FIN DB ? 
  MENSAJE DB "PAR  "
  FIN1 DB ?
  MENSAJE2 DB "IMPAR"
  FIN2 DB ?
ORG 2000H
  MOV DL, 0  ;Pongo el registro AL en 0
  MOV CL, OFFSET FIN-OFFSET TABLA ;Resta ambas direcciones
  
  MOV BX, OFFSET TABLA 
  SUMA: ADD DL, [BX]
  INC BX 
  DEC CL 
  JNZ SUMA 
  
  AND DL, 1H
  JZ PAR
  MOV BX, OFFSET MENSAJE2
  MOV AL, OFFSET FIN2 - OFFSET MENSAJE2
  INT 7  
  
  JMP TERMINA
  
  
  
  PAR: MOV BX, OFFSET MENSAJE
  MOV AL, OFFSET FIN1 - OFFSET MENSAJE
  INT 7  
  
  TERMINA: INT 0
END
; El resultado final es 6E (110 en decimal) 
```
