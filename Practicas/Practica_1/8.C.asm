ORG 1000H
resultado DB ? ; cambiar este valor y ver que queda en la variable resultado
CHAR DB "E"
; Recibe el caracter a verificar por AH
; Devuelve el resultado en AL
ORG 3000H
ES_VOCAL: MOV AL, 0FFH
 CMP AH, 41H ; A
 JZ FIN
 CMP AH, 45H ; E
 JZ FIN
 CMP AH, 49H ; I
 JZ FIN
 CMP AH, 4FH ; O
 JZ FIN
 CMP AH, 55H ; U
 JZ FIN
 MOV AL, 00H
FIN: RET
ORG 2000h
MOV AH, CHAR
CALL ES_VOCAL
MOV resultado, AL
HLT
END