ORG 1000H
 num1 DB 6H
 num2 DB 4H

; subrutina resto
; Recibe dos números en los registros CH y CL
; Retorna el resto de la división entera (sin coma) de CH/CL
; Por ejemplo el resto de 6/4 es 2
ORG 3000H
 resto: MOV AL, 0 ; inicializo el resto en 0
  MOV DH, 0 ; inicializo el cociente de la división
  CMP CH, 0 ; CH tiene NUM2
  JZ FIN
  CMP CL, 0 ; CL tiene NUM1
  JZ FIN
 DIV: SUB CL, CH
  JS RES ; si resultado negativo, voy a calcular el resto
  INC DH ; sumo al cociente
  JMP DIV
 RES: ADD CL, CH ; sumo de vuelta CH para determinar el resto
  MOV AL, CL ; devuelvo el resto en AX
FIN: RET
ORG 2000H
 MOV CL, num1
 MOV CH, num2
 CALL resto
HLT
END