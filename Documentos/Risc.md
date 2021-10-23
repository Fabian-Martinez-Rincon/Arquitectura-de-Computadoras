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




<table>
<tr>
<td> Fases </td> <td> Funcion </td>
</tr>
<tr>
<td>
 
![if](https://user-images.githubusercontent.com/55964635/138571830-e84e64ad-3720-4abf-96cb-dff21fa88120.png)

  
</td>
<td>
 
TEXTO

 
</td>

</tr>
  
<tr>
<td>
  
![ID](https://user-images.githubusercontent.com/55964635/138571834-3aceb35f-500d-47f2-b236-2b1dd4600a34.png)
  
</td>
<td>
 
TEXTO
 
</td>

</tr>

<tr>
<td>
 
![EX](https://user-images.githubusercontent.com/55964635/138571858-3e9bb33b-1038-414a-915f-213a92fc7652.png)

 
  
</td>
<td>
 
TEXTO
 
</td>

</tr>

<tr>
<td>
  
 ![ME](https://user-images.githubusercontent.com/55964635/138571868-6e02dbbd-f576-4d33-a165-c52618c1dd16.png)


</td>
<td>
 
TEXTO
 
</td>

</tr>

<tr>
<td>
 
![WB](https://user-images.githubusercontent.com/55964635/138571875-ba381a67-ea8c-44f3-98d0-c1f5e69b9d75.png)

  
</td>
<td>
 
TEXTO
 
</td>

</tr>
  

 
</table>
