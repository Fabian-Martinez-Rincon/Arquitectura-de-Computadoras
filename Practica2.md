<h1 align="center"> 💻Practica 2</h1>


Ejercicios
==========
1 ) Uso de las luces y las llaves a través del PIO. Ejecutar los programas bajo la configuración P1 C0 del simulador, que conecta las llaves al puerto PA del PIO y a las luces al puerto PB.

a ) Escribir un programa que encienda las luces con el patrón 11000011, o sea, solo las primeras y las últimas dos luces deben prenderse, y el resto deben apagarse. [Resolución](#Ejercicio_1a)

b ) Escribir un programa que verifique si la llave de más a la izquierda está prendida. Si es así, mostrar en pantalla el mensaje “Llave prendida”, y de lo contrario mostrar “Llave apagada”. Solo importa el valor de la llave de más a la izquierda (bit más significativo). Recordar que las llaves se manejan con las teclas 0-7. [Resolucion](#Ejercicio_1b)

c ) Escribir un programa que permite encender y apagar las luces mediante las llaves. El programa no deberá terminar nunca, y continuamente revisar el estado de las llaves, y actualizar de forma consecuente el estado de las luces. La actualización se realiza simplemente prendiendo la luz i si la llave i correspondiente está encendida (valor 1), y apagándola en caso contrario. Por ejemplo, si solo la primera llave está encendida, entonces solo la primera luz se debe quedar encendida. [Resolución](#Ejercicio_1c)

d ) Escribir un programa que implemente un encendido y apagado sincronizado de las luces. Un contador, que inicializa en cero, se incrementa en uno una vez por segundo. Por cada incremento, se muestra a través de las luces, prendiendo solo aquellas luces donde el valor de las llaves es 1. Entonces, primero se enciende solo la luz de más a la derecha, correspondiente al patrón 00000001. Luego se continúa con los patrones 00000010, 00000011, y así sucesivamente. El programa termina al llegar al patrón 
11111111. [Resolución](#Ejercicio_1d)

e ) Escribir un programa que encienda una luz a la vez, de las ocho conectadas al puerto paralelo del microprocesador a través de la PIO, en el siguiente orden de bits: 0-1-2-3-4-5-6-7-6-5-4-3-2-1-0-1-2-3-4-5-6-7-6-5-4-3-2-1-0-1-..., es decir, 00000001, 00000010, 00000100, etc. Cada luz debe estar 
encendida durante un segundo. El programa nunca termina. [Resolución](#Ejercicio_1d)

2 ) Ejecutar los programas en la configuración P1 C1 del simulador. En esta configuración, el puerto de datos de la impresora se conecta al puerto PB del PIO, y los bits de busy 
y strobe de la misma se conectan a los bits 0 y 1 respectivamente del puerto PA. Presionar F5 para mostrar la salida en papel. El papel se puede blanquear ingresando el comando BI.

a ) Escribir un programa para imprimir la letra “A” utilizando la impresora a través de la PIO. [Resolución](#Ejercicio_2a)

b ) Escribir un programa para imprimir el mensaje “ORGANIZACION Y ARQUITECTURA DE COMPUTADORAS” utilizando la impresora a través de la PIO. [Resolución](#Ejercicio_2b)

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
 PATRON DB 1
 FINAL DB 0
 REVERSO DB 0
 VALOR DB 0

ORG 1500H
 TABLA DB 1,2,4,8,16,32,64,128
 
ORG 3000H
 RUT_CLK:  CMP REVERSO, 1
  JZ MODO_REVERSO
  MOV CL, BYTE PTR [BX]
  INC BX
  CMP BYTE PTR [BX], 128    ;COMPARO CON 10000000B
  JNZ LUCES                 ;MIENTRAS NO LLEGUE AL ULTIMO, SALTO
  MOV REVERSO, 1
  JMP LUCES
  
  MODO_REVERSO: MOV CL, BYTE PTR [BX]
  DEC BX
  CMP BYTE PTR [BX], 1 ;CUANDO LLEGO A 1, DESACTIVO EL REVERSO
  JNZ LUCES
  MOV REVERSO, 0
  
  
  
  LUCES: MOV AL, CL
   OUT PIO+1, AL      ; PB IMPRIME EL PATRON DE LAS LUCES
   MOV AL, 0          
   OUT TIMER, AL      ; REINICIO LOS SEGUNDOS
   MOV AL, 20H    ; VUELVO NORMAL
   OUT PIC, AL
 IRET
 
ORG 2000H
 MOV BX, OFFSET TABLA
 
 CLI
 MOV AL, 0FDH
 OUT PIC+1, AL   ;ACTIVO EL TIMER EN ISMR
 
 MOV AL, N_CLK   ;PASO LA ID 10
 
 OUT PIC+5, AL   ;PONGO LA ID EN INT1: TIMER
 MOV AL, 1
 OUT TIMER+1, AL ;PONGO UN 1 EN EL COMP (SEGUNDOS)
 MOV AL, 0
 OUT PIO+3, AL   ;CONFIGURO PB PARA QUE SEAN TODAS DE SALIDA (LUCES)
 OUT PIO+1, AL   ; INICIO LAS LUCES EN 0
 OUT TIMER, AL   ; INICIO EL CONTADOR EN 0
 STI
 
 LAZO: JMP LAZO
 INT 0

END
```
Ejercicio_2a
============
```Assembly
PA EQU 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h

ORG 1000H
 CHAR DB "A"

ORG 2000H
 MOV AL, 01h; ; STROBE SALIDA (0), BUSY ENTRADA (1), RESTO EN 0
 OUT CA, AL
 MOV AL, 0    ;PUERTO DE DATOS, TODO SALIDA
 OUT CB, AL

 ; inicializo strobe en 0
 IN AL, PA
 AND AL, 0FDh ; 1111 1101b
 OUT PA, AL

 ; espero que busy=0
 POLL: IN AL, PA
 AND AL, 01h ;0000 0001b
 JNZ POLL

 ; se que busy es 0, mandar carácter
 MOV AL, CHAR
 OUT PB, AL

 ; mandar flanco ascendente de strobe
 IN AL, PA
 OR AL, 02h; 00000010b
 OUT PA, AL
 INT 0
END
```
Ejercicio_2b
============
```Assembly
PIO EQU 30H

ORG 1000H
 MSJ DB "CONCEPTOS DE "
     DB "ARQUITECTURA DE "
     DB "COMPUTADORAS"
 FIN DB ?
 
ORG 2000H
 ; INICIALIZACION PIO PARA IMPRESORA
 ; CA
 MOV AL, 0FDH     ;1111 1101B
 OUT PIO+2, AL    ;STROBE DE SALIDA, BUSY DE ENTRADA
 
 ; CB
 MOV AL, 0
 OUT PIO+3, AL   ;TODOS DE SALIDA
 
 ; Strobe
 IN AL, PIO
 AND AL, 0FDH
 OUT PIO, AL    ; PONGO EN 0 EL STROBE
 
 ; FIN INICIALIZACION
 MOV BX, OFFSET MSJ
 MOV CL, OFFSET FIN-OFFSET MSJ
 POLL: IN AL, PIO
 AND AL, 1
 JNZ POLL
 
 ; Enviar carácter
 MOV AL, [BX]
 OUT PIO+1, AL
 
 ; Pulso STROBE
 IN AL, PIO
 OR AL, 02H     ;ACTIVO EL STROBE
 OUT PIO, AL    ;MUESTRO EL STROBE
 
 ; Reiniciar STROBE
 IN AL, PIO
 AND AL, 0FDH
 OUT PIO, AL
 INC BX ;Mover el puntero de la cadena
 DEC CL
 JNZ POLL ; Verificar fin de la cadena
 INT 0
END
```
