<h1 align="center"> 💻Interrupciones</h1>

Indice
======
   * [Interrupciones por Software](#Interrupciones_por_Software)
   * [Memoria E/S y PIO](#Memoria_E_S_y_PIO)
     * [PIO](#PIO) 
   * [Interrupciones por Hardware](#Interrupciones_por_Hardware)
     * [PIC](#PIC) 
     * [EOI (20H)](#EOI_20H)
     * [IMR (21H)](#IMR_21H)
     * [Vector de Interrupciones](#VECTOR_DE_INTERRUCIONES)
     * [TIMER](#TIMER)
     * [F10](#F10)
   * [Handshake](#HANDSHAKE)
     * [Por Consulta de Estado](#IMPRIMIR_POR_CONSULTA_DE_ESTADO)
     * [Por interrupción](#IMPRIMIR_POR_INTERRUPCION)
   * [Impresora por PIO](#Impresora_Por_Pio)

Interrupciones_por_Software
===========================


| Interrupcion | Funcion |
| ------------- | ------------- |
| INT 0  | Detiene el programa. Igual a HLT  |
| INT 3  | Debug. No lo vamos a utilizar  |
| INT 6  | Lee un caracter desde teclado  |
| INT 7  | Imprime un string en pantalla  |

<table>
<tr>
<td> INT 6 </td> <td> INT 7 </td>
</tr>
<tr>
<td>
 
```Assembly
ORG 1000H
 LEIDO DB ?
ORG 2000H
 MOV BX, OFFSET LEIDO
 INT 6    
 INT 0
END
```
</td>
<td>
 
```Assembly
ORG 1000H
 MENSAJE DB "ARQUITECTURA DE COMPUTADORAS"
 FIN DB ?
ORG 2000H
 MOV BX, OFFSET MENSAJE
 MOV AL, OFFSET FIN - OFFSET MENSAJE
 INT 7    
 INT 0
END
```
 
</td>

</tr>
 
</table>


Memoria_E_S_y_PIO
=================

La memoria E/S es igual a la memoria común!
Como son iguales, necesito de un mecanismo para distinguirlas :
- Para leer desde la memoria E/S usaremos ```IN```, para escribir en ella ```OUT```. Ambas instrucciones ***solo se pueden usar*** con el registro ```AL```
- Ej. Lectura: Leer el dato que está en la posición 40H de E/S, ```IN AL, 40H```
- Ej. Escritura: Poner el valor 30 en la posicion 50H de E/S, ```OUT 50H, AL``` 

Nos comunicamos con los dispositivos de E/S a través de dispositivos internos.

<img src="https://user-images.githubusercontent.com/55964635/135499811-5b994852-1d26-410d-9e70-3c62d2a8a27a.png" width="550"/>

Cada uno de estos dispositivos internos se configuran, a través de la E/S y tienen asignado una zona de memoria fija (de E/S)

PIO
===
Es un puerto paralelo de E/S

Contra de 2 puertos paralelos configurables.

Ocupa 4 celdas en la memoria de E/S:

- 2 de **datos** llamados ```PA Y PB```
- 2 de **configuración** llamados ```CA Y CB```

| Memoria | Dispositivos |
| ------------- | ------------- |
| ![](https://user-images.githubusercontent.com/55964635/135502435-25d9266a-5465-46aa-8934-802bfb62856e.png)  | ![](https://user-images.githubusercontent.com/55964635/135503806-465c0102-5639-454c-9c26-ceea721a70d0.png)  |

- Cada celda (Tambien llamada registro) consta de 8 bits.
- Debemos configurar cada bit de datos como entrada o salida.
- En los puertos de configuracion debemos poner un 0 para que ese bit en el puerto de datos sea de ```Salida``` y 1 para que sea de ```Entrada```

Ej. Queremos que el ```PA``` tenga todos los bits como entrada excepto el menos significativo

- Debemos configurar ```CA```
- Todos en 1 menos el menos significativo (11111110)

```Assembly
MOV AL, 11111110b
OUT 32H, AL ;CA = 11111110
```

<table>
<tr>
<td> Ej Salida. Prender todas las luces </td> <td> Ej Entrada. Leer el estado de las llaves y prender las luces de aquellas llaves que esten en 1. </td>
</tr>
<tr>
<td>
 
```Assembly
ORG 2000H
 MOV AL, 0H
 OUT 33H, AL ;CB = 00000000
 MOV AL, 11111111B ;Tambien se pueden usar hexa
 OUT 31H, AL ;PB = 11111111
 INT 0
END 
```
</td>
<td>
 
```Assembly
ORG 2000H
;CONFIGURAMOS PA (ENTRADA) Y PB (SALIDA)
MOV AL, 11111111b
OUT 32H, AL ;CA = 11111111
MOV AL, 00000000B
OUT 33H, AL ;CB = 00000000
;PASO LO QUE TENNGO EN PA (LAS LLAVES)
  
LOOP: IN AL, 30H 
;MANDAR LA INFORMACION DE LAS LLAVES A LAS LUCES (PB)
OUT 31H, AL 
JMP LOOP
  
INT 0
END
```
 
</td>

</tr>
 
</table>

Interrupciones_por_Hardware
===========================
Nos vamos a manejar con 4 dispositivos externos.

![HARDWAREOWO](https://user-images.githubusercontent.com/55964635/135530533-ba42a968-c565-410b-aa63-b1c2eb52aee3.png)

PIC
===
Los dispositivos interrumpen al cpu a través del ***PIC***.

Es el intermediario entre los dispositivos que quieren interrumpir y la cpu. Avisa a la cpu que tiene que frenar, se maneja desde la memoria de E/S así que para configurar haremos uso de ```IN``` y ```OUT```. Tambien permite configurarr el resto de cosas que nos quedaron pendientes. Las sentenicas ```CLI``` y ```STI``` bloquean y habilitan, respectivamente, las interrupciones. Cuando configuremos el ```PIC``` ***siempre*** debemos hacerlo entre ```CLI``` y ```STI```

![image](https://user-images.githubusercontent.com/55964635/135541325-4613d44f-96d3-4132-b876-6656b3008503.png)

![interrupciones](https://user-images.githubusercontent.com/55964635/135951746-8e5972a0-17c8-4dbc-a2f8-bb353370186a.png)


EOI_20H
=======
- El ***PIC*** nos avisa que un dispositivo nos quiere interrumpir. Nosotros le avisamos que ya atendimos la interrupcion.
- Antes de volver de la subrutina de la interrupcion debemos poner el valor 20H en el ***EOI***.

```Assembly
MOV AL, 20H
OUT 20H, AL ;EOI = 20H
```

IMR_21H
=======

- Nos permite definir qué interrupciones vamos a atender y cuáles ignorar.
- 1 Significa deshabilitada, 0 habilitada

![digitos](https://user-images.githubusercontent.com/55964635/135545444-4d719bb6-cced-40f8-bcc6-4ceb99ab42d9.png)

VECTOR_DE_INTERRUCIONES
=======================

Hemos visto que existen dos tipos de interrupciones, por hardware y por software, que son necesarios por
razones distintas. En las interrupciones por hardware, el que interrumpe es un dispositivo y la CPU pasa el
control a una subrutina especial llamada manejador de interrupciones para atenderlo. En las que son por software,
el que interrumpe es el mismo programa, y la CPU pasa el control al sistema operativo que lo atiende ejecutando
una subrutina de sistema.

- Va de la posición 0(0000H) a la 1023 (0400H)
- Consta de 1024 posiciones de memoria
- Lo usamos para asociar las interrupciones con una subrutina a ejecutar
- Seleccionar un ID es crucial ya que se usará para asociar una interrupción con una subrutina
- Cuando ocurre una interrupcion la máquina toma el **ID** que elegimos y busca la dirección de la subrutina a ejecutar en la posición ```ID*4``` del vector de int.
- Solo puede manejar 256 interrupciones ya que tengo 1024 casillas y cada interrupcion ocupa 4 casillas (1024 / 4 = 256)

TIMER
=====
Es otro dispositivo de E/S como el F10. Se utiliza como reloj despertador para la CPU. Se configura para contar una cantidad determinada de segundos y cuando finaliza la cuenta emite una interrupcion. Tiene dos registros ```CONT``` y ```COMP```, con direcciones de la memoria E/S ```10H``` y ```11H```, respectivamente

![regis](https://user-images.githubusercontent.com/55964635/135676832-dc98b7ef-7aec-401b-986b-de487e3d8ff3.png)

```Assembly
CLI
 MOV AL, 11111101b ;Activamos el timer
 OUT 21H, AL ; PIC: registro IMR
 MOV AL, 10
 OUT 25H, AL ; PIC: registro INT1 (Timer)
 MOV AL, 10 ;ES 10, POR SI LO CAMBIO
 OUT 11H, AL ; TIMER: registro COMP 
 MOV AL, 0
 OUT 10H, AL ; TIMER: registro CONT
STI
```

F10
===


Contar las veces que se presionó la tecla F10 en DL

Vamos a realizar los siguientes pasos:

- Escribir la subrutina que se ejecutará cuando se produzca la interrupcion (que finaliza con ```IRET```)
- Elegir un ID de interrupción (cualquiera menos 0, 3, 6 o 7)
- Poner la dirección de la subrutina en el ```Vector de Interrupciones```
- Configurar ```PIC```
  - Bloquear las interrupciones con la sentencia ```CLI```
  - Poner el ID en el PIC para la interrupción que nos interesa
  - Desenmascarar la interrupcion.
  - Desbloquear las instrucciones con la sentencia ```STI``` 




<table>
<tr>
<td> Parte 1 </td> <td> Parte 2 </td>
</tr>
<tr>
<td>
 
```Assembly
ORG 2000H
 ;SELECCIONAR ID 10 PARA EL F10
  
 ;CONFIGURAMOS EL VECTOR DE INTERRUPCIONES
 MOV AX, CONTAR ;AX = Dir de CONTAR(3000H)
 MOV BX, 40 ;10 * 4 en el Vec. de Int.
 MOV [BX], AX ;EN LA POSICION 40 PONE EL 3000H

 ;CONFIGURAMOS EL PIC
 CLI
 MOV AL, 11111110B ;Configuramos solo el INT0 (F10)
 OUT 21H, AL  ;IMR
 MOV AL, 10
 OUT 24H, AL ;ID 10(PUEDE SER CUALQUIERA)
 STI
 
 LOOP: JMP LOOP ;LOOP INFINITO
 
INT 0
END
```
</td>
<td>
 
```Assembly
ORG 3000H
;Subrutina que atiende a la F10
CONTAR: INC DL
 
 ;AVISAR AL PIC QUE TERMINAMOS!
 MOV AL, 20H
 OUT 20H, AL
 
 ;VOLVEMOS
IRET
```
 
</td>

</tr>
 
</table>

HANDSHAKE
=========
Es una abstracción de la impresora, la impresora va a generar una comunicación con este. Nos interrumpe a través del pic.

![handd](https://user-images.githubusercontent.com/55964635/135723314-5acbdad3-3f7a-4b89-b4bc-fd52c1dc2406.png)

***ESTADO***: Tiene 8 bits como todas las celdas de memoria. Estos bits tienen diferentes significados dependiendo de si los pusimos en ```ENTRADA``` o ```SALIDA```.
| ENTRADA | SALIDA |
| ------------- | ------------- |
| ![END](https://user-images.githubusercontent.com/55964635/135723748-3e604d0f-e4ef-4a28-9438-574f2b2ac7e5.png) | ![SALIDA2](https://user-images.githubusercontent.com/55964635/135723760-77c8c089-5720-419c-a9e2-ddc02008959b.png)  |



IMPRIMIR_POR_CONSULTA_DE_ESTADO
===============================

<table>
<tr>
<td> PROGRAMA PRINCIPAL </td> <td> DATOS </td> <td> FUNCIONAMIENTO </td>
</tr>
<tr>
<td>
 
```Assembly
ORG 2000H
;CONFIGURO EL HANDSHAKE PARA EL POOLING
IN AL, HAND_ESTADO
AND AL, 01111111B        ;7FH MODIFICO SOLO EL ULTIMO BIT
OUT HAND_ESTADO, AL      ;ESTADO = 0XXXXXXX

;RECORREMOS EL MENSAJE Y LO ENVIAMOS POR CARACTER A LA IMPRESORA
MOV BX, OFFSET MENSAJE   ;PARA RECORRER EL MENSAJE

;DESOCUPO LA IMPRESORA
POLL: IN AL, HAND_ESTADO ;TOMO EL ESTADO ACTUAL
AND AL, 1                ;CHEQUEO EL PRIMER BIT
JNZ POLL                 ;MIENTRAS SEA 1 SIGO EN EL LOOP

; IMPRIMO 
MOV AL, [BX]             ;TOMO EL CARACTER
OUT HAND_DATO, AL        ;LO ENVIO AL REGISTRO DE DATOS

; AVANZO
INC BX                   ;AVANZO A LA SIGUIENTE POSICION
CMP BX, OFFSET FIN       ;CHEQUEO SI LLEGUE AL FINAL
JNZ POLL

INT 0
END
```
</td>
<td>
 
```Assembly
HAND_DATO EQU 40H
HAND_ESTADO EQU 41H

ORG 1000H
 MENSAJE DB "HOLA"
 FIN DB ?
```
 
</td>
<td>
  
  ![Tiempo](https://user-images.githubusercontent.com/55964635/135734418-4ba8d65b-a24e-4796-8adf-cdf9ac7e0c4d.gif)

</td>
  
</tr>
 
</table>

IMPRIMIR_POR_INTERRUPCION
=========================

<table>
<tr>
<td> PROGRAMA PRINCIPAL </td> <td> DATOS </td> <td> FUNCIONAMIENTO </td>
</tr>
<tr>
<td>
 
```Assembly
ORG 2000H
 ;CONFIGURO EL VECTOR DE INTERRUPCIONES. ID = 9
 MOV AX, IMPRIMIR
 MOV BX, 36       ;9*4 = 36
 MOV [BX], AX
 
 ;CONTADOR
 MOV BX, OFFSET MENSAJE ;PARA COMENZAR EL CONTEO
 MOV DL, OFFSET FIN - OFFSET MENSAJE
 
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
</td>
<td>
 
```Assembly
ORG 1000H
 MENSAJE DB "HOLA"
 FIN DB ?
 
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
```
 
</td>
<td>
  
  ![Tiempo](https://user-images.githubusercontent.com/55964635/135734418-4ba8d65b-a24e-4796-8adf-cdf9ac7e0c4d.gif)
  
  </td>
</tr>
 
</table>


Impresora_Por_Pio
==================



| Memoria | Dispositivos |
| ------------- | ------------- |
| ![](https://user-images.githubusercontent.com/55964635/135502435-25d9266a-5465-46aa-8934-802bfb62856e.png)  | ![PIOOO](https://user-images.githubusercontent.com/55964635/135732891-d87e8191-ff93-4993-bbba-8c30026d8ba3.png)  |

***Registro de Estado***: Veamos cuáles bits del registro ***estado*** son de ***entrada*** y cuáles de ***salida***..

![busi2](https://user-images.githubusercontent.com/55964635/135733045-2efba02b-9c90-4c3d-bdab-540019f16e9f.png)

- ```Bit 0 (busy)```: 1 si está ocupada la impresora, 0 si está libre. (ENTRADA)
- ```Bit 1 (strobe)```: seteando el bit en 1 le avisamos a la impresora que dejamos un caracter en ***DATO*** para que lo imprima. (SALIDA)
- Cuando la impresora esta llena, manda automaticamente un 1 al ```PA```

Ejemplo: Escribir un programa que envíe datos a la impresora a través del ***PIO***.

 - ¿Cómo configuramos el ***PA*** a partir de ***CA***?                 ```Strobe en 0 (salida) y Busy en 1(entrada)```
 - ¿Cómo configuramos el ***PB*** a partir de ***CB***?                 ```Todos de salida!```
 - Consultaremos constantemente si está libre                           ```Chequear si el bit Busy = 0```
 - Cuando la impresora esté libre mandamos el caracter a ***PB*** (31H)
 - Hasta que no mandemos el bit de Strobe en 1 no se va a imprimir!
 - Después de enviar el Strobe en 1, debemos volver a ponerlo en 0. 
 - ```DEL PUNTO 3 AL 6 DEBEMOS REPETIRLO PARA CADA CARACTER```

 ```Assembly
;CONFIGURACION BASE DEL PIO
MOV AL, 11111101B ;STROBE DE SALIDA, BUSY DE ENTRADA
OUT 32H, AL       ;CA

MOV AL, 0         ;TODOS DE SALIDA
OUT 33H, AL       ;CB
 ```

```Assembly
;RECORREMOS EL STRING
MOV BX, OFFSET MENSAJE
POLL: IN AL, 30H         ; CHEQUEAMOS EL ULTIMO BIT EN PA
  AND AL, 1              ; CUANDO ESTA EN 0, SIGNIFICA QUE ESTA LIBRE LA IMPRESORA
  JNZ POLL               ; MIENTRAS NO ESTE LIBRE, SIGO CONSULTANDO
```
```Assembly
;LA IMPRESORA ESTA LIBRE
MOV AL, [BX]            ; EN PB PONGO EL DIGITO ACTUAL
OUT 31H, AL             ; MANDO A LA IMPRESORA EL DIGITO ACTUAL (AL PUERTO DE DATOS)
```

COMO ESTAMOS TRABAJANDO CON LA IMPRESORA POR PIO, TENEMOS QUE MANDAR LOS DATOS MANUALMENTE, TENEMOS QUE MANDAR LA SEÑAL DE STROBE, QUE ES LO QUE AVISA QUE DEJAMOS UN CARACTER EN PB

```Assembly
;MANDO STROBE EN 1  (ESTO SIRVE PARA IMPRIMIR EL DATO)
IN AL, 30H
OR AL, 2            ; FUERZO EL STROBE A 1
OUT 30H, AL         ; MANDAMOS EL STROBE AL PUERTO DE ESTADO (PA)

;MANDO STROBE EN 0 (ESTO SIRVE PARA VOLVER AL ESTADO Y DETECTAR SI EN EL PROXIMO CARACTER DEBE IMPRIMIRSE)
IN AL, 30H
AND AL, 0FDH      ; FUERZO EL STROBE A 0
OUT 30H, AL       ; MANDAMOS EL STROBE AL PUERTO DE ESTADO (PA)
```

```Assembly
;FIN DEL BUCLE, HASTA LLEGAR AL FIN
INC BX
CMP BX, OFFSET FIN
JNZ POLL
```

<table>
<tr>
<td> PROGRAMA PRINCIPAL </td> <td> FUNCIONAMIENTO </td>
</tr>
<tr>
<td>
 
```Assembly
ORG 1000H
 MENSAJE DB "AQUITECTURA"
 FIN DB ?

ORG 2000H
MOV AL, 11111101B ;STROBE DE SALIDA, BUSY DE ENTRADA
OUT 32H, AL       ;CA

MOV AL, 0         ;TODOS DE SALIDA
OUT 33H, AL       ;CB
  
IN AL, 30H        ;poner el strobe en 0
AND AL, 0FDH
OUT 30H, AL

;RECORREMOS EL STRING
MOV BX, OFFSET MENSAJE
POLL: IN AL, 30H
  AND AL, 1
  JNZ POLL       ;MIENTRAS NO ESTE LIBRE, SIGO CONSULTANDO
  
  ;LA IMPRESORA ESTA LIBRE
  MOV AL, [BX]
  OUT 31H, AL
  
  ;MANDO STROBE EN 1
  IN AL, 30H
  OR AL, 2      ;TOMAMOS EL ESTADO
  OUT 30H, AL
  
  ;MANDO STROBE EN 0
  IN AL, 30H
  AND AL, 0FDH
  OUT 30H, AL
  
  INC BX
  CMP BX, OFFSET FIN
  JNZ POLL
  
INT 0
END
```
</td>
<td>
 
![ARGGGG](https://user-images.githubusercontent.com/55964635/135734492-46596c0f-072d-4d64-8e5e-ada58d98e03e.gif)

 
</td>

</tr>
 
</table>
