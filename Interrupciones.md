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

