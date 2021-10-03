EOI EQU 20h
IMR EQU 21h
INT0 EQU 24h
IDINT0 EQU 10
PA EQU 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h

ORG 1000H
flag db 0
longitud db 0
cadena db ?
org 40
dir_rut dw rut_f10

org 3000h
; cancelar interrupciones futuras
rut_f10: mov al,0FFH
out IMR, al
;indicamos al programa que no lea más
mov flag,1
mov al,24h
out EOI, al
iret

ORG 2000H
 cli
 ; INICIALIZACION PIO PARA IMPRESORA
 MOV AL, 0FDH
 OUT CA, AL
 MOV AL, 0
 OUT CB, AL
 IN AL, PA
 AND AL, 0FDH
 OUT PA, AL
 ;Inicialización del PIC
 mov al,0FEh; FE = 1111 1110
 out IMR,al
 mov al,IDINT0
 out INT0, al
 sti
 ; Lectura de cadena
 MOV BX, OFFSET cadena
 loop: int 6 ;leer char
 inc bx
 inc longitud
 cmp flag,0 ; verifico si presionaron f10
 jz loop
 ; Impresión de los caracteres leídos
 MOV BX, OFFSET cadena ;reiniciar puntero al comienzo
 POLL: nop
 IN AL, PA
 AND AL, 1
 JNZ POLL
 ; Enviar carácter
 MOV AL, [BX]
 OUT PB, AL
 ; Pulso STROBE
 IN AL, PA
 OR AL, 02H
 OUT PA, AL
 ; Reiniciar STROBE
 IN AL, PA
 AND AL, 0FDH
 OUT PA, AL
 ; pasar al siguiente char
 INC BX
 DEC longitud
 JNZ POLL
 INT 0
END