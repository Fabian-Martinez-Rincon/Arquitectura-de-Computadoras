TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
N_CLK EQU 10
N_F10 EQU 20

ORG 40
 IP_CLK DW RUT_CLK

ORG 80
 IP_F10 DW RUT_F10
 
ORG 1000H
 SEG DB 30H ; Decena
 DB 30H ; Unidad
 FIN DB ?
 
ORG 3000H
 RUT_CLK: PUSH AX ; Se guarda el valor de AX, porque se va a usar el registro
 
 MOV BX, OFFSET SEG
 INC BX
 INC WORD PTR [BX]
 CMP WORD PTR [BX], 3AH
 JNZ RESET
 
 MOV WORD PTR [BX], 30H
 DEC BX
 INC WORD PTR [BX]
 CMP WORD PTR [BX], 3AH
 JNZ RESET
 
 MOV DL, 1 ; Pongo en TRUE el flag de finalizacion
 MOV AL, 0FFH ; Deshabilito interrupciones en IMR
 OUT 21H, AL
 
 RESET: MOV BX, OFFSET SEG ; Direccion del contador
 MOV AL, 2 ; El contador tiene 2 caracteres
 INT 7 ; Se imprime el valor actual
 MOV AL, 0 ; Se vuelve a cero el contador del TIMER
 OUT 10H, AL
 MOV AL, 20H ; Se finaliza la atencion de la interrupcion
 OUT 20H, AL
 POP AX ; Se recupera el valor que contenia AX al entrar en la rutina
 IRET
 
ORG 3500H
 RUT_F10: PUSH AX ; Se guarda el valor de AX, porque se va a usar el registro
 IN AL, 21H ; Recupero el valor actual del IMR
 XOR AL, 00000010B ; Y cambio la linea correspondiente al TIMER
 OUT 21H, AL
 MOV AL, 20H ; Se finaliza la atencion de la interrupcion
 OUT 20H, AL
 POP AX ; Se recupera el valor que contenia AX al entrar en la rutina
 IRET
 
ORG 2000H
 CLI
 MOV AL, 0FEH ;11111101 TIMER
 OUT 21H, AL ; PIC: registro IMR
 MOV AL, 10 ;10
 OUT 24H, AL ; PIC: registro INT0, F10
 MOV AL, 20
 OUT 25H, AL ; PIC: registro INT1, TIMER
 MOV AL, 1
 OUT 11H, AL ; TIMER: registro COMP
 MOV AL, 0
 OUT 10H, AL ; TIMER: registro CONT
 
 MOV DL, 0
 STI
 LAZO: CMP DL, 0
 JZ LAZO
 INT 0
END