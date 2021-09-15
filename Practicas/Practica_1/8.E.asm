; Recibe el caracter a verificar por AH
; Devuelve el resultado en AL


ORG 1000H
 CAD DB "FXCELENTe" 
 CERO DB 0
 CARACTER DB "E"
 resultado DW ?
; Recibe en BX la dirección de la cadena
; retorna en CX la cantidad de vocales

ORG 3000H
 CONTAR_CAR: MOV DX, 0
  
  MOV BX, SP ;PASO EL STACK
  ADD BX, 2  ;Me muevo en la pila
  MOV AX, [BX] ;Paso la letra
  ADD BX, 2 ;Me muevo en la pila
  MOV BX, [BX] ;Paso la direccion de la cadena
  LOOP: MOV CL, BYTE PTR [BX] ;El primer digito de la cadena
  CMP CL, 0
  JZ TERMINO
  CMP CL, AL
  JNZ CONTINUAR
  INC DX
  CONTINUAR: INC BX
   JMP LOOP
  INC BX
  
  
  
  TERMINO: RET

ORG 2000h
 
 MOV AX, OFFSET CAD
 PUSH AX
 MOV AL, CARACTER
 MOV AH, 0
 PUSH AX
 CALL CONTAR_CAR
 MOV resultado, CX
 HLT
END