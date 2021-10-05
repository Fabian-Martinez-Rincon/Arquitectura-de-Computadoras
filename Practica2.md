<h1 align="center"> 💻Practica 2</h1>


Ejercicios
==========
1 ) Uso de las luces y las llaves a través del PIO. Ejecutar los programas bajo la configuración P1 C0 del simulador, que conecta las llaves al puerto PA del PIO y a las luces al puerto PB.

a ) Escribir un programa que encienda las luces con el patrón 11000011, o sea, solo las primeras y las últimas dos luces deben prenderse, y el resto deben apagarse. [Resolución](#Ejercicio_1a)

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
