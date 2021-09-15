;Le resto el num2 a num1 hasta que sea 0 o negativo
;Mientras sea positivo, hago un cointador
ORG 3000H
 DIV: PUSH BX ; preservo los 3 registros
 PUSH AX
 PUSH DX
 
 MOV BX, SP
 ADD BX, 10 ; Voy a la direccion de num2
 MOV AX, [BX] ; Paso el valor 2
 
 ADD BX,2 ;Voy a la direccion de num1
 MOV CX, [BX]; Paso el valor de num1
 
 LOOP: SUB CX,AX ;Resto el num2 al num1 hasta que sea negativo
 JS TERMINO

 INC DX
 JMP LOOP
 
 TERMINO: SUB BX,4 ;Paso el valor a la pila
 MOV [BX], DX
 ;restauro los 3 registros
 POP DX
 POP AX
 POP BX
 
 RET
ORG 1000H
 val1 DB 8H
 val2 DB 2H
 RESULTADO DB ?
  
ORG 2000H
 MOV AL, val1
 MOV AH, 0
 PUSH AX
 MOV AL, val2
 MOV AH, 0
 PUSH AX
 MOV AL, RESULTADO
 MOV AH, 0
 PUSH AX
 CALL DIV
 
 HLT
END