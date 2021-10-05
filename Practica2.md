<h1 align="center"> 💻Practica 2</h1>


Ejercicios
==========
1 ) Uso de las luces y las llaves a través del PIO. Ejecutar los programas bajo la configuración P1 C0 del simulador, que conecta las llaves al puerto PA del PIO y a las luces al puerto PB.

a ) Escribir un programa que encienda las luces con el patrón 11000011, o sea, solo las primeras y las últimas dos luces deben prenderse, y el resto deben apagarse. [Resolución](#Ejercicio_1a)

b ) Escribir un programa que verifique si la llave de más a la izquierda está prendida. Si es así, mostrar en pantalla el mensaje “Llave prendida”, y de lo contrario mostrar “Llave apagada”. Solo importa el valor de la llave de más a la izquierda (bit más significativo). Recordar que las llaves se manejan con las teclas 0-7. [Resolucion](#Ejercicio_1b)

c ) Escribir un programa que permite encender y apagar las luces mediante las llaves. El programa no deberá terminar nunca, y continuamente revisar el estado de las llaves, y actualizar de forma consecuente el estado de las luces. La actualización se realiza simplemente prendiendo la luz i si la llave i correspondiente está encendida (valor 1), y apagándola en caso contrario. Por ejemplo, si solo la primera llave está encendida, entonces solo la primera luz se debe quedar encendida. [Resolución](#Ejercicio_1c)

d ) Escribir un programa que implemente un encendido y apagado sincronizado de las luces. Un contador, que inicializa en cero, se incrementa en uno una vez por segundo. Por cada incremento, se muestra a través de las luces, prendiendo solo aquellas luces donde el valor de las llaves es 1. Entonces, primero se enciende solo la luz de más a la derecha, correspondiente al patrón 00000001. Luego se continúa con los patrones 00000010, 00000011, y así sucesivamente. El programa termina al llegar al patrón 
11111111. [Resolución](#Ejercicio_1d)

Ejercicio_1a
============
```Assembly
CB EQU 33h
PB EQU 31h

ORG 1000H     
 PATRON db 0C3h;1100 0011b
 
ORG 2000H
 MOV AL, 0
 OUT CB, AL      ;CONFIGURO TODOS DE SALIDA
 MOV AL, PATRON
 OUT PB, AL      ;IMPRIMO PATRON
 INT 0
END
```
Ejercicio_1b
============
```Assembly
CA EQU 32h
PA EQU 30h

ORG 1000H
 PRENDIDA DB "Llave prendida"
 APAGADA DB "Llave apagada"
 FIN_APAGADA DB ?

ORG 2000H
 MOV AL, 0FFh
 OUT CA, AL     ;TODO SALIDA
 IN AL, PA
 ; poner en 0 todos los bits menos el más sig
 AND AL, 80h;1000 0000
 ; si es 0
 CMP AL, 0
 JZ ESTA_APAGADA
 ; esta prendida
 MOV BX, OFFSET PRENDIDA
 MOV AL,OFFSET APAGADA - OFFSET prendida
 JMP FIN
 
 ESTA_APAGADA: MOV BX, OFFSET APAGADA
 MOV AL, OFFSET FIN_APAGADA - OFFSET APAGADA
 FIN: INT 7 ; imprimir
 HLT
END
```
Ejercicio_1c
============
```Assembly
PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 2000H
MOV AL, 0FFH 
OUT CA, AL        ; CONFIGURO PA COMO ENTRADAS (LLAVES)
MOV AL, 0         
OUT CB, AL        ; CONFIGURO PB COMO SALIDAS (LUCES)

POLL: IN AL, PA   ; MIRO COMO ESTAN LAS LLAVES
OUT PB, AL        ; MUESTRO EL VALOR DE LAS LLAVES EN LAS LUCES
JMP POLL          ; LOOP INFINITO
END
```
Ejercicio_1d
============
```Assembly
PIC EQU 20H
TIMER EQU 10H
PIO EQU 30H
N_CLK EQU 10

ORG 40
 IP_CLK DW RUT_CLK
 
ORG 1000H
 PATRON DB 0
 FINAL DB 0
 
ORG 3000H
 RUT_CLK: INC PATRON
  CMP PATRON, 0FFH    ;COMPARO CON 11111111B
  JNZ LUCES           ;MIENTRAS NO LLEGUE AL ULTIMO, SALTO
  MOV FINAL, 1
  MOV AL, 0FFH
  OUT PIC+1, AL       ;DESHABILITO TODAS LAS INTERRUPCIONES
  JMP FIN
  
  LUCES: MOV AL, PATRON
   OUT PIO+1, AL      ; PB IMPRIME EL PATRON DE LAS LUCES
   MOV AL, 0          
   OUT TIMER, AL      ; REINICIO LOS SEGUNDOS
  FIN: MOV AL, 20H    ; VUELVO NORMAL
   OUT PIC, AL
 IRET
 
ORG 2000H
 CLI
 MOV AL, 0FDH
 OUT PIC+1, AL   ;ACTIVO EL TIMER EN ISMR
 
 MOV AL, N_CLK   ;PASO LA ID 10
 
 OUT PIC+5, AL   ;PONGO LA ID EN INT1: TIMER
 MOV AL, 1
 OUT TIMER+1, AL ;PONGO UN 1 EN EL COMP (SEGUNDOS)
 MOV AL, 0
 OUT PIO+3, AL   ;CONFIGURO PB PARA QUE SEAN TODAS DE SALIDA (LUCES)
 OUT PIO+1, AL   ;INICIO LAS LUCES EN 0
 OUT TIMER, AL   ; INICIO EL CONTADOR EN 0
 STI
 
 LAZO: CMP FINAL, 1
 JNZ LAZO
 INT 0

END

```
