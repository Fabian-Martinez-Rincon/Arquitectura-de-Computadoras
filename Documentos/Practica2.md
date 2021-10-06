<h1 align="center"> 💻Practica 3</h1>


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

c ) Escribir un programa que solicita el ingreso de cinco caracteres por teclado y los envía de a uno por vez a la impresora a través de la PIO a medida que se van ingresando. No es necesario mostrar los caracteres en la pantalla. [Resolución](#Ejercicio_2c)

d ) Escribir un programa que solicite ingresar caracteres por teclado y que recién al presionar la tecla F10 los envíe a la impresora a través de la PIO. No es necesario mostrar los caracteres en la pantalla. [Resolución](#Ejercicio_2d)

3 ) Uso de la impresora a través del HAND-SHAKE. Ejecutar los programas en configuración P1 C2

a ) Escribir un programa que imprime “INGENIERIA E INFORMATICA” en la impresora a través del HAND-SHAKE. La comunicación se establece por consulta de estado (polling). ¿Qué diferencias encuentra con el ejercicio 2b? [Resolución](#Ejercicio_3a)

b ) ¿Cuál es la ventaja en utilizar el HAND-SHAKE con respecto al PIO para comunicarse con la impresora? Sacando eso de lado, ¿Qué ventajas tiene el PIO, en general, con respecto al HANDSHAKE? [Resolución](#Ejercicio_3b)

c ) Escribir un programa que imprime “UNIVERSIDAD NACIONAL DE LA PLATA” en la impresora a través del HAND-SHAKE. La comunicación se establece por interrupciones emitidas desde el HANDSHAKE cada vez que la impresora se desocupa. [Resolución](#Ejercicio_3c)

d) Escribir un programa que solicite el ingreso de cinco caracteres por teclado y los almacene en memoria. Una vez ingresados, que los envíe a la impresora a través del HAND-SHAKE, en primer lugar tal cual fueron ingresados y a continuación en sentido inverso. Utilizar el HAND-SHAKE en modo consulta de estado. ¿Qué diferencias encuentra con el ejercicio 2c? [Resolución](#Ejercicio_3d)

e ) Idem d ) , pero ahora utilizar el HAND-SHAKE en modo interrupciones. [Resolución](#Ejercicio_3e)

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
Ejercicio_2c
============
```Assembly
PIO EQU 30H

ORG 1000H
 NUM_CAR DB 5
 CAR DB  ?
; SUBRUTINA DE INICIALIZACION
; PIO PARA IMPRESORA

ORG 3000H
 INI_IMP: MOV AL, 0FDH
 OUT PIO+2, AL         ;CA TROBE DE SALIDA, BUSY DE ENTRADA
 MOV AL, 0
 OUT PIO+3, AL         ;CB TODOS DE SALIDA
 IN AL, PIO            ; PONEMOS EL STROBE EN 0 PARA EMPEZAR
 AND AL, 0FDH          
 OUT PIO, AL
RET

; SUBRUTINA DE GENERACIÓN DE PULSO "STROBE"
ORG 4000H
 PULSO: IN AL, PIO 
 OR AL, 02H          ; PONGO EL STROBE EN 1
 OUT PIO, AL
 IN AL, PIO
 AND AL, 0FDH        ; PONGO EL STROBE EN 0
 OUT PIO, AL
RET


; PROGRAMA PRINCIPAL
ORG 2000H
 PUSH AX
 CALL INI_IMP
 POP AX
 MOV BX, OFFSET CAR
 MOV CL, NUM_CAR
 
 LAZO: INT 6        ; INGRESO UN CARACTER
 POLL: IN AL, PIO   ; CHEQUEAMOS EL ULTIMO BIT DE PA
 AND AL, 1
 JNZ POLL           ; MIENTRAS NO ESTE LIBRE, SIGO EJECUTANDO
 
 MOV AL, [BX]       ; MANDO EL DIGITO QUE LEI
 OUT PIO+1, AL
 
 PUSH AX
 CALL PULSO        ; LO IMPRIMO
 POP AX
 DEC CL
 JNZ LAZO          ; ASI CON LOS 5 CARACTERES
INT 0
END
```
Ejercicio_2d
============
```Assembly
EOI EQU 20h
IMR EQU 21h
INT0 EQU 24h
IDINT0 EQU 10
PA EQU 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h

ORG 1000H
 FLAG db 0
 LONGITUD db 0
 CADENA db ?

ORG 40
 dir_rut dw rut_f10

ORG 3000h
; cancelar interrupciones futuras (DESACTIVAR)
rut_f10: MOV AL,0FFH
OUT IMR, AL
;indicamos al programa que no lea más
MOV FLAG, 1
MOV AL, 24h
OUT EOI, AL
IRET

ORG 2000H
 cli
 ; INICIALIZACION PIO PARA IMPRESORA
 MOV AL, 0FDH     ; EL STROBE COMO SALIDA Y EL STROBE COMO SALIDA
 OUT CA, AL
 MOV AL, 0
 OUT CB, AL       ; TODOS COMO SALIDA
 IN AL, PA
 AND AL, 0FDH     ;PONEMOS EL STROBE EN 0
 OUT PA, AL
 
 ;INICIALIZACIÓN DEL PIC
 MOV AL, 0FEh    ; FE = 1111 1110
 OUT IMR, AL     ; ACTIVAMOS EL F10
 MOV AL, IDINT0
 OUT INT0, AL    ; MANDAMOS LA ID AL F10
 STI
 
 ; LECTURA DE CADENA
 MOV BX, OFFSET CADENA
 LOOP: INT 6     ; leer char
 INC BX
 INC LONGITUD
 CMP FLAG, 0     ; verifico si presionaron f10
 JZ LOOP

 ; IMPRESIÓN DE LOS CARACTERES LEIDOS
 MOV BX, OFFSET CADENA  ; VAMOS AL INICIO DE LA CADENA
 POLL: NOP              ; NOP: LITERALMENTE NO HACE NADA
  IN AL, PA             ; VERIFICAMOS QUE LA IMPRESORA ESTE LIBRE PARA IMPRIMIR
  AND AL, 1
 JNZ POLL
 
 ; ENVIAMOS EL CARACTER
 MOV AL, [BX]
 OUT PB, AL
 
 ; Pulso STROBE PARA IMPRIMIR
 IN AL, PA
 OR AL, 02H
 OUT PA, AL
 
 ; Reiniciar STROBE 
 IN AL, PA
 AND AL, 0FDH
 OUT PA, AL
 
 ; pasar al siguiente char
 INC BX
 DEC LONGITUD
 JNZ POLL
INT 0
END
```
Ejercicio_3a
============
```Assembly
HAND EQU 40H

ORG 1000H
 MSJ DB "INGENIERIA E "
 DB "INFORMATICA"
 FIN DB ?
 
ORG 2000H
 IN AL, HAND+1
 AND AL, 7FH
 OUT HAND+1, AL
 MOV BX, OFFSET MSJ
 MOV CL, OFFSET FIN-OFFSET MSJ
 POLL: IN AL, HAND+1
 AND AL, 1
 JNZ POLL
 MOV AL, [BX]
 OUT HAND, AL
 INC BX
 DEC CL
 JNZ POLL
 INT 0
END
```
Ejercicio_3b
============
El handshake con respecto al pio:

El hanshake sabe hacer algunas funciones que no sabe hacer el pio (La cpu no necesita realizar algunas tareas). Con el hanshake puedo trabajar por interrupciones tambien, cosa que no puedo con el pio.

El pio con respecto al handshake:

El pio sirve para varios dispositivos (No con la impresora nada mas), es como un modulo general, en cambio en el handshake solo puedo usar la impresora, es como un modulo dedicado a la impresora. La pio es mas general. Si solo pienso en la impresora, no tengo ventajas con respecto al handshake, ya que este tiene funciones extras.

Ejercicio_3c
============
```Assembly
PIC EQU 20H
HAND EQU 40H
N_HND EQU 10

ORG 1000H
 MENSAJE DB "UNIVERSIDAD         "
         DB "NACIONAL DE LA PLATA"
 FIN DB ?

ORG 40
 IP_HND DW RUT_HND

ORG 3000H
 RUT_HND: PUSH AX
 MOV AL, [BX]
 OUT HAND, AL
 INC BX
 DEC CL
 JNZ FINAL
 MOV AL, 0FFH
 OUT PIC+1, AL
 
 FINAL: MOV AL, 20H
 OUT PIC, AL
 POP AX
IRET

ORG 2000H
 MOV BX, OFFSET MENSAJE
 MOV CL, OFFSET FIN - OFFSET MENSAJE
 CLI
 MOV AL, 0FBH
 OUT PIC+1, AL
 MOV AL, N_HND
 OUT PIC+6, AL
 MOV AL, 80H
 OUT HAND+1, AL
 STI
 
 LAZO: CMP CL, 0
 JNZ LAZO
 
 IN AL, HAND+1
 AND AL, 7FH
 OUT HAND+1, AL
 
INT 0
END
```
Ejercicio_3d
============
```Assembly
HAND_DATO EQU 40H
HAND_ESTADO EQU 41H

ORG 1000H
 FIN DB 5
 MENSAJE DB ""
 

ORG 2000H
;CONFIGURO EL HANDSHAKE PARA EL POOLING
IN AL, HAND_ESTADO
AND AL, 01111111B        ;7FH MODIFICO SOLO EL ULTIMO BIT
OUT HAND_ESTADO, AL      ;ESTADO = 0XXXXXXX

;RECORREMOS EL MENSAJE Y LO ENVIAMOS POR CARACTER A LA IMPRESORA
MOV BX, OFFSET MENSAJE   ;PARA RECORRER EL MENSAJE
MOV DL, FIN
LAZO: INT 6    ; INGRESO UN CARACTER
 INC BX
 DEC DL
 CMP DL, 0
 JNZ LAZO
 ;CONTADOR
 MOV BX, OFFSET MENSAJE ;PARA COMENZAR EL CONTEO
 MOV DL, FIN


;DESOCUPO LA IMPRESORA
POLL: IN AL, HAND_ESTADO ;TOMO EL ESTADO ACTUAL
AND AL, 1                ;CHEQUEO EL PRIMER BIT
JNZ POLL                 ;MIENTRAS SEA 1 SIGO EN EL LOOP

; IMPRIMO 
MOV AL, [BX]             ;TOMO EL CARACTER
OUT HAND_DATO, AL        ;LO ENVIO AL REGISTRO DE DATOS

; AVANZO
INC BX                   ;AVANZO A LA SIGUIENTE POSICION
DEC DL
CMP DL, 0       ;CHEQUEO SI LLEGUE AL FINAL
JNZ POLL

INT 0
END
```
Ejercicio_3e
============
```Assembly
ORG 1000H
 FIN DB 5
 MENSAJE DB ?
 
 
ORG 3000H
;RECORREMOS EL MENSAJE Y LO ENVIAMOS POR CARACTER
IMPRIMIR: PUSH AX
 MOV AL, [BX] 
 OUT 40H, AL
;AVISO AL PIC Y VUELVO
INC BX
DEC DL
JNZ CONTINUAR
;DESACTIVO HANDSHAKE POR INTERRUPCION
MOV AL, 01111111B
OUT 21H, AL
;___________________________________
CONTINUAR: MOV AL, 20H
OUT 20H, AL
POP AX
IRET


ORG 2000H
 ;CONFIGURO EL VECTOR DE INTERRUPCIONES. ID = 9
 MOV AX, IMPRIMIR
 MOV BX, 36       ;9*4 = 36
 MOV [BX], AX
 
 ;CONTADOR
 MOV BX, OFFSET MENSAJE ;PARA COMENZAR EL CONTEO
 MOV DL, FIN
 
 LAZO: INT 6    ; INGRESO UN CARACTER
 INC BX
 DEC DL
 CMP DL, 0
 JNZ LAZO
 ;CONTADOR
 MOV BX, OFFSET MENSAJE ;PARA COMENZAR EL CONTEO
 MOV DL, FIN
 
 ;CONFIGURO PIC
 CLI
 MOV AL, 11111011B ;SOLO HANDSHAKE HABILITADO (0FBH)
 OUT 21H, AL ; IRM
 MOV AL, 9   ; ID = 9
 OUT 26H, AL ; MANDO LA ID AL INT2 (HANDSHAKE)
 
 ;CONFIGURO EL HANDSHAKE PARA LA INTERRUPCION
 OR AL, 10000000B    ; MANDO UN 1 AL MENOS SIGNIFICATIVO 
 OUT 41H, AL         ; ACTIVO EL HANDSHAKE COMO INTERRUPCION
 STI
 
 ;SIMULAMOS UN PROGRAMA EN EJECUCION
 POLL: CMP DL, 0    ; CHEQUEO QUE SE TERMINO EL CONTADOR
 JNZ POLL   
 
 IN AL, 41H                
 AND AL, 7FH         ; 0111 1111
 OUT 41H, AL         ; DESACTIVO EL HANSHAKE COMO INTERRUPCION

INT 0
END
```

