<h1 align="center"> 💻RISC </h1>

Indice
======
   * [Fases de una instrucción](#Fases_de_una_instruccion)
   * [Atascos](#Atascos)


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

![1 2](https://user-images.githubusercontent.com/55964635/138572631-5ffa8dad-9e94-4169-98b1-6da7469b068a.png)

![2 2](https://user-images.githubusercontent.com/55964635/138572635-14e74e64-d413-4683-b2ca-44fd9d8cb4b7.png)


![3 2](https://user-images.githubusercontent.com/55964635/138572637-cced63b8-1c27-4b7b-8f1d-a65127dd239e.png)


![4 2](https://user-images.githubusercontent.com/55964635/138572646-63c7e2e5-eae3-487a-8078-6e6533acc5a8.png)

![5 2](https://user-images.githubusercontent.com/55964635/138572649-ae11d424-0282-48ef-8858-35b94f457428.png)

![6 2](https://user-images.githubusercontent.com/55964635/138572652-3c317cb1-732d-41a9-999e-fa6494174c87.png)
