;Ejecutar en configuración 1
ORG 1000H; Memoria de datos
CARACTER db "A"
PA EQU 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h

ORG 2000H;Prog principal
MOV AL, 01h     ; strobe salida (0), busy entrada (1), resto en 0
OUT CA, AL
MOV AL, 0       ;PUERTO DE DATOS, TODO SALIDA
OUT CB, AL      

; INICIALIZO STROBE EN 0
IN AL, PA
AND AL, 0FDh    ; 1111 1101b
OUT PA, AL

; ESPERO QUE BUSY  = 0
POLL: IN AL, PA
AND AL,01h      ;0000 0001b
JNZ POLL

; se que busy es 0, mandar carácter
MOV AL, CARACTER
OUT PB, AL

;MANDAR FLANCO ASCENDENTE DE STROBE
IN AL, PA
OR AL, 02h     ; 00000010b
OUT PA, AL
INT 0
END
