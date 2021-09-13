; Recibe el caracter a verificar por AH
; Devuelve el resultado en AL
ORG 4000H
ES_VOCAL: MOV AL, 0FFH
 CMP AH, 41H ;A
 JZ FIN
 CMP AH, 45H ;E
 JZ FIN
 CMP AH, 49H ;I
 JZ FIN
 CMP AH, 4FH ;O
 JZ FIN
 CMP AH, 55H ;U
 JZ FIN
 MOV AL, 00H
FIN: RET

ORG 1000H
CAD DB "EXCELENTE" 
CERO DB 0
resultado DW ?
; Recibe en BX la dirección de la cadena
; retorna en CX la cantidad de vocales

ORG 3000H
VOCALES: MOV CX, 0 ; cantidad de vocales
LOOP: MOV AH, BYTE PTR [BX] ; pongo en AX el caracter correspondiente a [BX]
 CMP AH, 0 ; si llegue al valor 0 (fin de cadena)
 JZ fin_vocales ; retorno
 CALL ES_VOCAL
 CMP AL, 0FFH ; si no son iguales, no es vocal
 JNZ NOES
 INC CX ; incremento vocales
NOES: INC BX ; me muevo por la cadena
 JMP LOOP ; verifico el próximo char
fin_vocales: RET

ORG 2000h
MOV BX, offset CAD
CALL VOCALES
MOV resultado, CX
HLT
END