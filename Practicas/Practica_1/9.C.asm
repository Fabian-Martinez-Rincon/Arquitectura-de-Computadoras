; Utiliza los mismos registros que ROTARIZQ_N
; Recibe en BH la cantidad de posiciones
ORG 5000H
ROTARDER_N: MOV CH, 8
 SUB CH, BH ; cantidad de bytes que debo rotar hacia la izq.
 MOV BH, CH ; vuelvo a copiar en BH
 ; ROTARIZQ usará el valor almacenado en BH para rotar.
 CALL ROTARIZQ_N
 RET
ORG 1000H
b DB 27h ; (00100111) en binario
 
ORG 2000H
MOV AH, b
; Realizamos una rotación de 6 posiciones a la derecha
MOV BH, 2
CALL ROTARDER_N ; AH = 10011100 (C9H)
HLT
END