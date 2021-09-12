ORG 1000H
CAD DB "EXCELENTE"
 DB 00H
 
ORG 3000H
 LONGITUD: MOV DX, 0 ;contador
 LOOP: MOV AH, [BX]
  CMP AH, 00H;Hasta que no llegue al ultimo
  JZ FIN
  INC DX ;Aumento el contador
  INC BX ;Recorro la Cadena
  JMP LOOP
FIN: RET

ORG 2000h
 MOV BX, offset CAD
 CALL LONGITUD
 HLT
END