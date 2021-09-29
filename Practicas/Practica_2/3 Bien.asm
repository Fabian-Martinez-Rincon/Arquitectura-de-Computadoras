ORG 1000H
MAY DB 41H ; "A"
MIN DB 61H ; "a"
; La letra "Z" (mayuscula) tiene el codigo 5A
ORG 2000H
MOV AL, 2 ; Se imprime en pantalla de a 2 caracteres
MOV BX, OFFSET MAY ; a partir de la direccion de MAY
PROX: INT 7
INC MIN ; Paso al siguiente caracter
INC MAY ; Paso al siguiente caracter
CMP MAY, 5BH ; comparo con el caracter siguiente al "Z", que es el ultimo valido
JNZ PROX ; Si aun no procesamos "Z", continua con el siguiente caracter
INT 0
END