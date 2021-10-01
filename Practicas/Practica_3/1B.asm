ORG 1000H; Memoria de datos
 MENSAJE db "PRENDIDA"
 MENSAJE2 db "APAGADA"
 FIN db ?
 CA EQU 32h
 PA EQU 30h

ORG 2000H;Prog principal
 MOV AL, 0ffh
 OUT CA, AL
 IN AL, PA
 ; poner en 0 todos los bits menos el más sig
 AND AL, 10000000B;
 ; si es 0
 CMP AL, 0
 JZ APAGADA
 ; esta prendida
 mov BX, OFFSET MENSAJE
 mov AL, OFFSET MENSAJE2 - OFFSET MENSAJE
 JMP FIN2
 
 APAGADA: MOV BX, OFFSET MENSAJE2
 mov AL,OFFSET FIN - OFFSET MENSAJE2
 FIN2: int 7 ; imprimir
 HLT
END