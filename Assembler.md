<h1 align="center"> 💻Assembler</h1>


Indice
=================

   * [If](#Registros_Indice)
   * [Potencias](#Flags)
   * [Suma De Elementos en una Tabla](#Direccionamientos)
   * [Transeferencia de Datos](#Transferencia_De_Datos)
   * [Instrucciones Aritmeticas](#Instrucciones_Aritmeticas)
   * [Saltos](#Saltos)
   * [Instrucciones Logicas](#Instrucciones_Logicas)
   * [Instrucciones de Control y Manejo de Interrupciones](Instrucciones_De_Control_Y_Manejo_De_Interrupciones)


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
Suma De Elementos En Una Tabla
==============================
```Assembly
ORG 1000H
  TABLA DB 2,4,6,8,10,12,14,16,18,20 ;Se ejecuta la misma cantidad de numeros que tiene la tabla
  FIN DB ? ;Lo empiezo con basura 1010h
  TOTAL DB ? ;Tambien tiene basura 1011h
  MAX DB 13 ; 1012h
ORG 2000H
  MOV AL, 0  ;Pongo el registro AL en 0
  MOV CL, OFFSET FIN-OFFSET TABLA ;Resta ambas direcciones
  ;100Ah-1000h
  ;El resultado nos da la cantidad de elementos que tiene tabla
  MOV BX, OFFSET TABLA ;Mandamos al registro BX la direccion de tabla (1000h)
  SUMA: ADD AL, [BX];Sumo a lo que apunta 1000h se lo suma al registo AL
  INC BX ;Incremento la posicion de memoria para ir a 1001h
  DEC CL ;Decremento el contador de elementos que tengo en la tabla
  JNZ SUMA ;Mientras nuestro contador no esta en cero, que se vuelva a ajecutar
  HLT
END
; El resultado final es 6E (110 en decimal) 
```
