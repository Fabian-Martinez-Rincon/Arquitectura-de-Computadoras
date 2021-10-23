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
| ![image](https://user-images.githubusercontent.com/55964635/138571266-37ebd734-e752-455d-bd36-431565fab869.png) | Detiene el programa. Igual a HLT  |
| INT 3  | Debug. No lo vamos a utilizar  |
| INT 6  | Lee un caracter desde teclado  |
| INT 7  | Imprime un string en pantalla  |
