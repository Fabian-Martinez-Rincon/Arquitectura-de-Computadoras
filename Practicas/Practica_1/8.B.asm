ORG 1000H
 CAD DB "ab1sz"
 FIN_CADENA DW 00H
 CANT DW ?
 
ORG 3000H
 CONTAR_MIN: CMP WORD PTR [BX], 00H;Mientras no llegue al final
 JZ CORTE ;Cuando llego al final, termino
 
 MOV AL, [BX] ;Paso el caracter
 CMP AL, 61H ;Lo comparo con "a"
 JS SIG ;Si es mas chico que "a", salto
 CMP AL, 7BH ;Comparo con 1+ que "z"
 JNS SIG ;Si no es negativo, significa que me pase
 INC CX ;Si cumple con lo anterior, sumo en mi contador
 
 SIG: INC BX ;Recorro los caracteres
 JMP CONTAR_MIN ;Voy al principio y vuelvo a preguntar
 
 CORTE: MOV CANT, CX ;Termino y paso todo a mi variable cant
 RET ;

ORG 2000h
 ;Por referencia via registro
 MOV BX, OFFSET CAD ;1000h
 CALL CONTAR_MIN
 HLT
END