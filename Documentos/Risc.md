<h1 align="center"> 💻RISC </h1>

Indice
======
   * [Fases de una instrucción](#Fases_de_una_instruccion)
     * [Instruction Fetch](#Instruction_Fetch)
     * [Instruction Decoding](#Instruction_Decoding)
     * [Execution](#Execution)
     * [Memory access](#Memory_access)
     * [Write Back](#Write_Back)

Fases_de_una_instruccion
========================
Las instrucciones se organizan en ***fases*** de manera que esto sea posible

Instruction_Fetch
-----------------
- Se accede a memoria por la instrucción
- Se incrementa el PC (antes conocido como el IP)


Instruction_Decoding
--------------------
- Se decodifica la instruccion
- Se accede al banco de registros por los operandos. Se atasca si no están disponibles
- Se calcula el valor del operando inmediato
- Si es un salto, se calcula el destino y si se toma o no (requiere acceder al banco de reg)

Execution
---------
- Si es una instrucción de cómputo, se ejecuta en la ALU
- Si es un acceso a memoria, se calcula la dirección efectiva
- Si es un salto, se realiza (se modifica el registro PC)

Memory_access
-------------
- Si es un acceso a memoria, se lee/escribe el dato

Write_Back
----------
- Se almacena el resultado ***(si lo hay)*** en los registros


| Interrupcion | Funcion |
| ------------- | ------------- |
| ![image](https://user-images.githubusercontent.com/55964635/138571333-979edb35-72b2-4fb8-88bd-7ada6bd71af4.png) | Detiene el programa. Igual a HLT  |
| ![image](https://user-images.githubusercontent.com/55964635/138571428-4c9b5905-5a6e-4bbf-8c7b-f927dc841262.png)  | Debug. No lo vamos a utilizar  |
| ![image](https://user-images.githubusercontent.com/55964635/138571346-2e5ee125-ee18-4e7c-b417-ceb2986e5bf6.png) | Lee un caracter desde teclado  |
| ![image](https://user-images.githubusercontent.com/55964635/138571400-e324f2a6-efc4-49cb-8c65-b29418fd2026.png) | Imprime un string en pantalla  |
| ![image](https://user-images.githubusercontent.com/55964635/138571376-4b6c4dd6-5f55-4386-a123-88c3533bca3e.png)  | Imprime un string en pantalla  |

<table>
<tr>
<td> Fases </td> <td> Funcion </td>
</tr>
<tr>
<td>
 
```Assembly
ORG 1000H
 LEIDO DB ?
ORG 2000H
 MOV BX, OFFSET LEIDO
 INT 6    
 INT 0
END
```
</td>
<td>
 
```Assembly
ORG 1000H
 MENSAJE DB "ARQUITECTURA DE COMPUTADORAS"
 FIN DB ?
ORG 2000H
 MOV BX, OFFSET MENSAJE
 MOV AL, OFFSET FIN - OFFSET MENSAJE
 INT 7    
 INT 0
END
```
 
</td>

</tr>
  
<tr>
<td>
 
```Assembly
ORG 1000H
 LEIDO DB ?
ORG 2000H
 MOV BX, OFFSET LEIDO
 INT 6    
 INT 0
END
```
</td>
<td>
 
```Assembly
ORG 1000H
 MENSAJE DB "ARQUITECTURA DE COMPUTADORAS"
 FIN DB ?
ORG 2000H
 MOV BX, OFFSET MENSAJE
 MOV AL, OFFSET FIN - OFFSET MENSAJE
 INT 7    
 INT 0
END
```
 
</td>

</tr>

<tr>
<td>
 
```Assembly
ORG 1000H
 LEIDO DB ?
ORG 2000H
 MOV BX, OFFSET LEIDO
 INT 6    
 INT 0
END
```
</td>
<td>
 
```Assembly
ORG 1000H
 MENSAJE DB "ARQUITECTURA DE COMPUTADORAS"
 FIN DB ?
ORG 2000H
 MOV BX, OFFSET MENSAJE
 MOV AL, OFFSET FIN - OFFSET MENSAJE
 INT 7    
 INT 0
END
```
 
</td>

</tr>

<tr>
<td>
 
```Assembly
ORG 1000H
 LEIDO DB ?
ORG 2000H
 MOV BX, OFFSET LEIDO
 INT 6    
 INT 0
END
```
</td>
<td>
 
```Assembly
ORG 1000H
 MENSAJE DB "ARQUITECTURA DE COMPUTADORAS"
 FIN DB ?
ORG 2000H
 MOV BX, OFFSET MENSAJE
 MOV AL, OFFSET FIN - OFFSET MENSAJE
 INT 7    
 INT 0
END
```
 
</td>

</tr>

<tr>
<td>
 
```Assembly
ORG 1000H
 LEIDO DB ?
ORG 2000H
 MOV BX, OFFSET LEIDO
 INT 6    
 INT 0
END
```
</td>
<td>
 
```Assembly
ORG 1000H
 MENSAJE DB "ARQUITECTURA DE COMPUTADORAS"
 FIN DB ?
ORG 2000H
 MOV BX, OFFSET MENSAJE
 MOV AL, OFFSET FIN - OFFSET MENSAJE
 INT 7    
 INT 0
END
```
 
</td>

</tr>
  

 
</table>
