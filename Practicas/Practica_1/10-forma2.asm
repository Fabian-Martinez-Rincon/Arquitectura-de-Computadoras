; Recibe las direcciones de dos celdas de memoria a intercambiar M1 y M2
; a través de la pila
ORG 3000H
 SWAP: PUSH BX ; preservo los 3 registros
 PUSH AX
 PUSH DX
 
 ; OBTENER EL VALOR DE M2 en CX
 MOV BX, SP
 ADD BX, 8 ; apunto al segundo parámetro
 ; 8=6+2: 6=3*2 son de los push; los otros 2 por la dir de retorno
 MOV BX, [BX] ; BX tiene la DIR de M2
 MOV CX, [BX] ; CX tiene el valor de M2
 
 ; OBTENER EL VALOR DE M1 en DX
 MOV BX, SP
 ADD BX, 10 ; apunto al primer parámetro
 ; 10=6+2+2: 6=3*2 son de los push; 2 por la dir de retorno, y 2 por M2
 MOV BX, [BX] ; BX tiene la DIR de M1
 MOV DX, [BX] ; DX tiene el valor de M1
 
 ; PONER EL VALOR DE M1 (DX) en M2
 MOV BX, SP
 ADD BX, 8 ; apunto al segundo parámetro
 MOV BX, [BX] ; BX tiene la DIR de M2
 MOV [BX], DX ; Asigno el valor de M1 en la dir de M2
 
 ; PONER EL VALOR DE M2 (CX) en M1
 MOV BX, SP
 ADD BX, 10 ; apunto al primer parámetro
 MOV BX, [BX] ; BX tiene la DIR de M2
 MOV [BX], CX ; Asigno el valor de M2 en la dir de M1
 
 
 ; restauro los 3 registros
 POP DX
 POP AX
 POP BX

RET
ORG 1000H
 val1 DW 1234H
 val2 DW 5678H
  
ORG 2000H
 MOV AX, offset val1
 PUSH AX
 MOV AX, offset val2
 PUSH AX
 CALL SWAP
 ; verificar que se hayan intercambiado los valores entre val1 y val2
 HLT
END