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

ORG 3000H
 SUM32: MOV BX,SP
 ADD BX,2
 MOV DX, [BX]
 ADD BX,4
 ADD DX, [BX]
 ADD BX,4
 MOV [BX],DX
 
 MOV BX,SP
 ADD BX,4
 MOV DX, [BX]
 ADD BX,4
 ADD DX, [BX]
 ADD BX,4
 MOV [BX],DX
 
 
RET
ORG 2000h
 MOV AX, OFFSET ResA  ; RESULTADO PARTE ALTA
 PUSH AX
 MOV AX, OFFSET ResBB ; RESULTADO PARTE BAJA
 PUSH AX
 MOV AX,num1A ; PARTE ALTA
 PUSH AX
 MOV AX,num1B ; PARTE BAJA
 PUSH AX
 MOV AX,num2A ; PARTE ALTA
 PUSH AX
 MOV AX,num2B ; PARTE BAJA
 PUSH AX
 
 CALL SUM32
HLT
END