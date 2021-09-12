<h1 align="center"> 💻Assembler</h1>


Indice
=================

   * [If](#Registros_Indice)
   * [Flags](#Flags)
   * [Direccionamientos](#Direccionamientos)
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
</tr>
</table>
