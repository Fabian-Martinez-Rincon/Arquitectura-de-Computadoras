;c) 
;Escribir un programa que calcule la suma de dos números 
;De 32 bits almacenados en la memoria sin hacer llamados a
;Subrutinas, resolviendo el problema desde el programa principal.
ORG 1000h
 num1A DW 3000h; PARTE ALTA 
 num1B DW 2000h; PARTE BAJA 
 num2A DW 0001h; PARTE ALTA
 num2B DW 0002h; PARTE BAJA
 ResA DW ?
 ResBB DW ?

ORG 2000h
 MOV AX,num1A ; PARTE ALTA
 MOV BX,num1B ; PARTE BAJA
 MOV CX,num2A ; PARTE ALTA
 MOV DX,num2B ; PARTE BAJA
 ADD BX,DX ; SUMA DE PARTES BAJAS
 ADC AX,CX ; SUMA DE PARTES ALTAS
 MOV ResA,AX ; RESULTADO PARTE ALTA
 MOV ResBB,BX ; RESULTADO PARTE BAJA
HLT
END