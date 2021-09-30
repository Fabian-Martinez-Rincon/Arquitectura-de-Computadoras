<h1 align="center"> 💻Interrupciones</h1>

Indice
======
   * [Interrupciones por Software](#Interrupciones_por_Software)
   * [Memoria E/S y PIO](#Memoria_E/S_y_PIO)
   * [Interrupciones por Hardware](#Interrupciones_por_Hardware)

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


Memoria_E/S_y_PIO
=================

Interrupciones_por_Hardware
===========================
Nos vamos a manejar con 4 dispositivos externos.
1) F10
- INT0 
EJEMPLO : Contar las veces que se presionó la tecla F10 en DL
2) TIMER
- INT1 
3) HANDSHAKE
- INT2 
4) CDMA
- INT3 
