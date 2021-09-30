<h1 align="center"> 💻Interrupciones</h1>

Indice
======
   * [Interrupciones por Software](#Interrupciones_por_Software)
   * [Memoria E/S y PIO](#Memoria_E_S_y_PIO)
     * [PIO](#PIO) 
   * [Interrupciones por Hardware](#Interrupciones_por_Hardware)
     * [PIC](#PIC) 

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

- Cada selda (Tambien llamada registro) consta de 8 bits.
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

Es el intermediario entre los dispositivos que quieren interrumpir y la cpu. El pic avisa a la cpu que tiene que frenar

EJEMPLO : Contar las veces que se presionó la tecla F10 en DL

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
 MOV AX, CONTAR
 MOV BX, 40
 MOV [BX], AX ;EN LA PO 40 PONE EL 3000H

 ;CONFIGURAMOS EL PIC
 CLI
 MOV AL, 11111110B
 OUT 21H, AL
 MOV AL, 10
 OUT 24H, AL ;INT 0 = 10
 STI
 
 LOOP: JMP LOOP
 
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



TIMER
=====

- INT1 

HANDSHAKE
=========

- INT2 

CDMA
====

- INT3 
