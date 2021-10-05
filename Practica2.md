<h1 align="center"> 💻Practica 2</h1>


Ejercicios
==========
1 ) Uso de las luces y las llaves a través del PIO. Ejecutar los programas bajo la configuración P1 C0 del simulador, que conecta las llaves al puerto PA del PIO y a las luces al puerto PB.

a ) Escribir un programa que encienda las luces con el patrón 11000011, o sea, solo las primeras y las últimas dos luces deben prenderse, y el resto deben apagarse. [Resolución](#Ejercicio_1a)

b ) Escribir un programa que verifique si la llave de más a la izquierda está prendida. Si es así, mostrar en pantalla el mensaje “Llave prendida”, y de lo contrario mostrar “Llave apagada”. Solo importa el valor de la llave de más a la izquierda (bit más significativo). Recordar que las llaves se manejan con las teclas 0-7. [Resolucion](#Ejercicio_1b)

c ) Escribir un programa que permite encender y apagar las luces mediante las llaves. El programa no deberá terminar nunca, y continuamente revisar el estado de las llaves, y actualizar de forma consecuente el estado de las luces. La actualización se realiza simplemente prendiendo la luz i si la llave i correspondiente está encendida (valor 1), y apagándola en caso contrario. Por ejemplo, si solo la primera llave está encendida, entonces solo la primera luz se debe quedar encendida. [Resolución](#Ejercicio_1c)

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
