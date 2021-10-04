<h1 align="center"> 💻Practica 2</h1>


Ejercicios
=================

1 ) Implementar un programa en el lenguaje assembler que muestre en la pantalla de comandos un mensaje previamente almacenado en memoria de datos, aplicando la interrupción por software INT 7 [Resolucion](#Ejercicio_1)
 
2 ) Escribir un programa que muestre en pantalla todos los caracteres disponibles, comenzando con el caracter cuyo código es el número 01H [Resolucion](#Ejercicio_2)

3 ) Escribir un programa que muestre en pantalla las letras del abecedario, sin espacios, intercalandolo mayúsculas y minúsculas (AaBb...), sin incluir texto en la memoria de datos del programa. Tener en cuenta que el código de "A" es 41H, el de "a" es 61H y que el resto de los codigos son correlativos según el abecedario [Resolucion](#Ejercicio_3)


Ejercicio_1
===========
```Assembly
ORG 1000H
 MENSAJE DB "ARQUITECTURA DE COMPUTADORAS-"
         DB "FACULTAD DE INFORMATICA-"
         DB 55H
         DB 4EH
         DB 4CH
         DB 50H
 FIN DB ?
ORG 2000H
 MOV BX, OFFSET MENSAJE
 MOV AL, OFFSET FIN - OFFSET MENSAJE
 INT 7    
 INT 0
END
```

Ejercicio_2
===========
```Assembly
ORG 1000H
 MENSAJE DB 01H
ORG 2000H
 MOV BX, OFFSET MENSAJE
 MOV AL, 1 ;Solo voy a imprimir un caracter
 REPETIR: INT 7    
 INC BYTE PTR [BX]
 CMP BYTE PTR [BX], 7FH
 JNZ REPETIR
 INT 0
END
```


Ejercicio_3
===========
```Assembly
ORG 1000H
MAY DB 41H ; "A"
MIN DB 61H ; "a"
; La letra "Z" (mayuscula) tiene el codigo 5A
ORG 2000H
MOV AL, 2 		       ; SE IMPRIME EN PANTALLA DE A 2 CARACTERES
MOV BX, OFFSET MAY ; A PARTIR DE LA DIRECCION MAY
PROX: INT 7
INC MIN            ;PASO AL SIGUIENTE CARACTER
INC MAY            ;PASO AL SIGUIENTE CARACTER
CMP MAY, 5BH       ;CARACTER SIGUIENTE A LA Z (ASI TOMO LA Z)
JNZ PROX           ;MIENTRAS NO LLEGUE AL CARACTER, AVANZO
INT 0
END
```
