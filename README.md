


<div align="center">

[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/Fabian-Martinez-Rincon/Arquitectura-de-Computadoras)
[![GitHub stars](https://img.shields.io/github/stars/Fabian-Martinez-Rincon/Arquitectura-de-Computadoras)](https://github.com/FabianMartinez1234567/Arquitectura-de-Computadoras/stargazers/)
[![GitHub repo size in bytes](https://img.shields.io/github/repo-size/Fabian-Martinez-Rincon/Arquitectura-de-Computadoras)](https://github.com/Fabian-Martinez-Rincon/Arquitectura-de-Computadoras)

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=30&duration=1200&pause=1000&color=F7F123&center=true&width=635&lines=💻 Arquitectura de Computadoras"/>

 </div>


<a title="" href="https://cafecito.app/ei-materias"><img src="/Documentos/Cafecito.png" alt="" /></a>

***Literal Estan todas las practicas resueltas y corregidas***

---

<p><img width="250" align='right' src="https://user-images.githubusercontent.com/55964635/233821142-59442bca-978d-4bf5-9708-f8ca08236327.png"></p>



- [Pila, Subrutinas y Parametros](/Documentos/Assembler.md)
- [Interrupciones](/Documentos/Interrupciones.md)
- [Risc](/Documentos/Risc.md)
- [Ejercicios_Random](/Documentos/Ejercicios_Random.md)
- [Practica 2](/Documentos/Practica1.md)
- [Practica 3](/Documentos/Practica2.md)
- [Practica 4](/Documentos/Practica3.md)
- [Practica 5](/Documentos/Practica4.md)
- [Practica 6](/Documentos/Practica5.md)
- [Teoria (Para el Primer Parcial)](/Documentos/Teoria1.md)
- [Teoria Apuntes](/Documentos/Teoria1Apuntes.md)
- [Parciales](/Documentos/Parciales.md)
- [Copiar Pegar](/Documentos/CopiarPegar.md)
- [Resumen Assembly](/Documentos/ResumenAssembly.md)

---

<h1 align="center"> 💻Practica 2</h1>


Ejercicios
=================

1 ) Implementar un programa en el lenguaje assembler que muestre en la pantalla de comandos un mensaje previamente almacenado en memoria de datos, aplicando la interrupción por software INT 7 [Resolucion](#Ejercicio_1)
 
2 ) Escribir un programa que muestre en pantalla todos los caracteres disponibles, comenzando con el caracter cuyo código es el número 01H [Resolucion](#Ejercicio_2)

3 ) Escribir un programa que muestre en pantalla las letras del abecedario, sin espacios, intercalandolo mayúsculas y minúsculas (AaBb...), sin incluir texto en la memoria de datos del programa. Tener en cuenta que el código de "A" es 41H, el de "a" es 61H y que el resto de los codigos son correlativos según el abecedario [Resolucion](#Ejercicio_3)

4 ) Escribir un programa que solicite el ingreso de un número (de un digito) por teclado e inmediatamente lo muestre en la pantalla de comandos, haciendo uso de las interrupciones por software INT 6 e INT 7. [Resolucion](#Ejercicio_4)

5 ) Modificar el programa anterior agregando una subrutina llamada ES_NUM que verifique si el caracter ingresado es realmente un número. De no serlo, el programa debe mostrar el mensaje “CARACTER NO VALIDO”. La subrutina debe recibir el código del caracter por referencia desde el programa principal y debe devolver vía registro el valor 0FFH en caso de tratarse de un número o el valor 00H en caso contrario. Tener en cuenta que el código del “0” es 30H y el del “9” es 39H. [Resolucion](#Ejercicio_5)

6 )  Escribir un programa que solicite el ingreso de un número (de un dígito) por teclado y muestre en pantalla dicho número expresado en letras. Luego que solicite el ingreso de otro y así sucesivamente. Se debe finalizar la ejecución al ingresarse en dos vueltas consecutivas el número cero. [Resolución](#Ejercicio_6)

7 )  Escribir un programa que efectúe la suma de dos números (de un dígito cada uno) ingresados por teclado y muestre el resultado en la pantalla de comandos. Recordar que el código de cada caracter ingresado no coincide con el número que representa y que el resultado puede necesitar ser expresado con 2 dígitos. [Resolución](#Ejercicio_7)

8 ) Escribir un programa que efectúe la resta de dos números (de un dígito cada uno) ingresados por teclado y muestre el resultado en la pantalla de comandos. Antes de visualizarlo el programa debe verificar si el resultado es positivo o negativo y anteponer al valor el signo correspondiente. [Resolución](#Ejercicio_8)

9 ) Escribir un programa que aguarde el ingreso de una clave de cuatro caracteres por teclado sin visualizarla en pantalla. En caso de coincidir con una clave predefinida (y guardada en memoria) que muestre el mensaje "Acceso permitido", caso contrario el mensaje "Acceso denegado". [Resolución](#Ejercicio_9)

10 ) Escribir un programa que, mientras ejecuta un lazo infinito, cuente el número de veces que se presiona la tecla F10 y acumule este valor en el registro DX. [Resolución](#Ejercicio_10)

11 ) Escribir un programa que permita seleccionar una letra del abecedario al azar. El código de la letra debe generarse en un registro que incremente su valor desde el código de A hasta el de Z continuamente. La letra debe quedar seleccionada al presionarse la tecla F10 y debe mostrarse de inmediato en la pantalla de comandos. [Resolución](#Ejercicio_11)

12 ) Implementar a través de un programa un reloj segundero que muestre en pantalla los segundos transcurridos (00-59 seg) desde el inicio de la ejecución. [Resolución](#Ejercicio_12)

15 ) Escribir un programa que implemente un conteo regresivo a partir de un valor ingresado desde el teclado. El conteo debe comenzar al presionarse la tecla F10. El tiempo transcurrido debe mostrarse en pantalla, actualizándose el valor cada segundo. [Resolución](#Ejercicio_15)

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
Ejercicio_4
===========
```Assembly
ORG 1000H
 MSJ DB "INGRESE UN NUMERO:"
 FIN DB ?
ORG 1500H
 NUM DB ?
ORG 2000H
 MOV BX, OFFSET MSJ  ;PARA IMPRIMIR SIEMPRE TIENE SER EL REGISTRO BX
 MOV AL, OFFSET FIN-OFFSET MSJ
 INT 7               ;IMPRIMO EL MENSAJE NORMAL 
 MOV BX, OFFSET NUM  ;PARA TOMAR EL VALOR PUEDE SER CUALQUIER REGISTRO
 INT 6               ;INGRESO UN VALOR POR TECLADO Y LO CARGO A NUM
 MOV AL, 1           ;AL INDICA LA CANTIDAD DE CARACTERES
 INT 7
 MOV CL, NUM
 INT 0
END
```

Responder brevemente:

a ) Con referencia a la interrupción ***INT 7***, ¿Qué se almacena en los registros BX y AL?

En BX se almacena la direccion de memoria en donde comienza el string, y en AL se almacena la cantidad de caracteres que voy a imprimir.

b ) Con referencia a la interrupción ***INT 6***, ¿Qué se almacena en BX?

En BX se tiene la dirección de memoria donde se va a guardar el carácter el caracter leido.

c ) En el programa anterior, ¿Qué hace la segunda interrupción INT 7? ¿Qué queda almacenado en el registro CL? 

Como en bx, quedo guardado la direccion del numero que ingresamos, luego a AL, mando 1 para que solo me imprima el caracter leido. En el registro CL queda el codigo ASCII del caracter leido.

Ejercicio_5
===========
```Assembly
ORG 1000H
 MENSAJE DB "INGRESE UN NUMERO: "
 FIN DB ?
 MENSAJE2 DB "CARACTER NO VALIDO"
 FIN2 DB ?
 NUEVE DB 39H
ORG 1500H    ;ESTA PUEDE SER CUALQUIER DIRECCION, LO PONEMOS POR COMODIDAD
 NUM DB ?
 
ORG 3000H
 ES_NUM:INT 6
 CMP NUM,30H
 JS NO_ES      ;SI EL VALOR ES MENOR AL 0, NO ES VALIDO
 CMP  NUM,40H  ;SI EL VALOR ES MAYOR A 9, TAMPOCO ES VALIDO
 JNS NO_ES
 
 MOV DX,0FFH   ;MANDO ESTE VALOR PARA INDICAR QUE ES CORRECTO
 MOV AL, 1     ;IMPRIMO SOLO 1 CARACTER
 INT 7
 JMP TERMINO   ;TERMINO NORMAL
 
 NO_ES: MOV DX, 00H       ;MANDO EL VALOR E IMPRIMO EL MENSAJE
 MOV BX, OFFSET MENSAJE2
 MOV AL, OFFSET FIN2-OFFSET MENSAJE2
 INT 7
 
TERMINO: RET

ORG 2000H 
 MOV BX, OFFSET MENSAJE
 MOV AL, OFFSET FIN-OFFSET MENSAJE
 INT 7
 
 MOV BX, OFFSET NUM
 CALL ES_NUM
 
 MOV CL, NUM ;MANDO EL CARACTER/NUMERO INGRESADO
 INT 0
END
```
Ejercicio_6
===========
```Assembly
ORG 1000H
 CERO DB "CERO " ; Todos los nombres tienen 6 caracteres para 
      DB "UNO " ; facilitar posicionarnos al imprimir el nombre del numero
      DB "DOS "
      DB "TRES "
      DB "CUATRO"
      DB "CINCO "
      DB "SEIS "
      DB "SIETE "
      DB "OCHO "
      DB "NUEVE "
 MSJ DB "INGRESE UN NUMERO:"
 FIN DB ?
 
ORG 1500H
 NUM DB ?
 
ORG 2000H
 MOV CL, 0                      ; CONT 0 DE FORMA CONSECUTIVA
 OTRO: MOV BX, OFFSET MSJ
 MOV AL, OFFSET FIN-OFFSET MSJ
 INT 7                          ; IMPRIMO EL MENSAJE
 
 MOV BX, OFFSET NUM
 INT 6                          ; LEO UN CARACTER
 CMP NUM, 30H                   ; COMPARO CON 0
 JNZ NO_CERO
 
 INC CL                         ; VOY A NRO 1
 JMP SEGUIR
 
 NO_CERO:MOV CL, 0              ;REINICIO EL CONTADOR DE 0 CONSECUTIVOS
 
 SEGUIR: MOV BX, OFFSET CERO 
  MOV AL, 6                     ;IMPRIMO SIEMPRE 6 CARACTERES
 
 LOOP: CMP NUM, 30H
  JZ IMPRIME                    ;SI ENCONTRE EL NOMBRE, IMPRIMO
   ADD BX, 6                    ;AVANZO DE NOMBRE
   DEC NUM                      ;AL LLEGAR AL NUMERO 0, ESTARA POSICIONADO
  JMP LOOP
  
 IMPRIME:INT 7
  CMP CL, 2
  JNZ OTRO                      ; HASTA QUE SE INGRESE DOS VECES SEGUIDAS EL "0" CERO
 INT 0 
END
```
Ejercicio_7
===========
```Assembly
ORG 1000H
 MSJ DB "INGRESE UN NUMERO:"
 FIN DB ?
 ORG 1500H
 NUM1 DB ?
 NUM2 DB ?
 RES_D DB "0"                  ; DOCENA DEL RESULTADO 
 RES_U DB ?                    ; UNIDAD DEL RESULTADO

ORG 2000H
 MOV BX, OFFSET MSJ
 MOV AL, OFFSET FIN-OFFSET MSJ
 INT 7                         ;IMPRIMO EL MENSAJE
 MOV BX, OFFSET NUM1
 INT 6                         ;LEO EL NUM1
 MOV BX, OFFSET MSJ
 INT 7                         ;PIDO OTRO NUMERO
 MOV BX, OFFSET NUM2
 INT 6                         ;LEO EL NUM2
 MOV AL, NUM2 
 SUB AL, 30H                   ; PARA QUEDARME CON EL ENTERO
 
 ADD AL, NUM1                  ; SUMO EL PRIMER NUMERO
 CMP AL, 3AH                   ; SI NO SUPERO 9, IMPRIMO
 JS NUM_OK                     ; SI ES MENOR QUE 9
 
 SUB AL, 10                    ; ME QUEDO CON LA UNIDAD
 INC RES_D                     ;PASA DE SER "0" A "1"
 
 NUM_OK: MOV RES_U, AL         ;COPIO EL VALOR EN RES U
 MOV BX, OFFSET RES_D          ; IMPRIMO 2 CARACTERES
 MOV AL, 2
 INT 7
 INT 0
END
```

Ejercicio_8
===========
```Assembly
ORG 1000H
 MSJ DB "INGRESE UN NUMERO:"
 FIN DB ?
 ORG 1500H
 NUM1 DB ?
 NUM2 DB ?
 RES_D DB "0"                  ; DOCENA DEL RESULTADO 
 RES_U DB ?                    ; UNIDAD DEL RESULTADO

ORG 2000H
 MOV BX, OFFSET MSJ
 MOV AL, OFFSET FIN-OFFSET MSJ
 INT 7                         ;IMPRIMO EL MENSAJE
 MOV BX, OFFSET NUM1
 INT 6                         ;LEO EL NUM1
 MOV BX, OFFSET MSJ
 INT 7                         ;PIDO OTRO NUMERO
 MOV BX, OFFSET NUM2
 INT 6                         ;LEO EL NUM2
 MOV AL, NUM1 
 
 CMP AL, NUM2                  ;SI EL RESULTADO DA NEGATIVO
 JS NUM_NO_OK                  
 SUB AL, NUM2                  ;SINO, ES UNA RESTA NORMAL
 JMP NUM_OK                    ;IMPRIMO EL NUMERO
 
 NUM_NO_OK: MOV AL, NUM2
 SUB AL, NUM1               
 MOV RES_D, 2DH                     ;PASA DE SER "0" A "-"
 
 NUM_OK: ADD AL, 30H
 MOV RES_U, AL         
 MOV BX, OFFSET RES_D          ; IMPRIMO 2 CARACTERES
 MOV AL, 2
 INT 7
 INT 0
END

```
Ejercicio_9
===========
```Assembly
ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?
CONTRA DB "AB"
CONTRA_PARTE2 DB "CZ"
CANT DB 4H

MENSAJE DB "CORRECTA"
FIN_MENSAJE DB ?
MENSAJE2 DB "INCORRECTA"
FIN_MENSAJE2 DB ?

ORG 3000H
 LEER_CONTRA:MOV BX, SP
 ADD BX,2
 BUCLE: MOV CL,[BX]
 MOV DX, BX
 MOV BX, OFFSET NUM
 INT 6
 MOV AL, 1
 INT 7
 
 CMP CL,NUM
 JNZ INCORRECTO
 
 MOV BX, DX
 INC BX
 DEC CANT
 JNZ BUCLE
 
 CMP CANT,0
 JZ CUMPLE
 
 INCORRECTO: MOV BX, OFFSET MENSAJE2
 MOV AL, OFFSET FIN_MENSAJE2 - OFFSET MENSAJE2
 INT 7 
 JMP TERMINAR
 
 
 CUMPLE:MOV BX, OFFSET MENSAJE
 MOV AL, OFFSET FIN_MENSAJE - OFFSET MENSAJE
 INT 7 
 JMP TERMINAR
 
TERMINAR: RET

ORG 1500H
NUM DB ?

ORG 2000H
MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN-OFFSET MSJ
INT 7
MOV BX, CONTRA_PARTE2
PUSH BX
MOV BX, CONTRA
PUSH BX
CALL LEER_CONTRA

INT 0
END
```
Ejercicio_10
============
```Assembly
PIC EQU 20H
EOI EQU 20H
N_F10 EQU 10

ORG 40
 IP_F10 DW RUT_F10
ORG 2000H
CLI
 MOV AL, 0FEH     ; 11111110
 OUT PIC+1, AL    ; PIC: IMR, ACTIVO F10
 MOV AL, N_F10    ; ELEGIMOS ID
 OUT PIC+4, AL    ; PIC: INT0, GUARDAMOS LA ID
 MOV DX, 0
STI
 LAZO: JMP LAZO

ORG 3000H
 RUT_F10: PUSH AX
 INC DX
 MOV AL, EOI
 OUT EOI, AL      ; PIC: EOI
 POP AX
 IRET
END
```

Explicar detalladamente:

a) La función de los registros del PIC: ISR, IRR, IMR, INT0-INT7, EOI. Indicar la dirección de cada uno.

ISR: Sus bits indican si se está atendiendo la interrupción de algún dispositivo. Sólo importan los 4 bits menos significativos.

IRR: Sus bits indican qué dispositivos están solicitando una interrupción. Si el bit N vale 1, entonces el dispositivo conectado a la línea INTN está haciendo una solicitud. Sólo importan los 4 bits menos significativos.

IMR: sus bits indican qué líneas de interrupción están habilitadas. Si el bit N vale 1, las interrupciones del dispositivo conectado a la línea INTN serán ignoradas. Si vale 0, las interrupciones del dispositivo serán atendidas en algún momento. Sólo importan los 4 bits menos significativos

INT0

b) Cuáles de estos registros son programables y cómo trabaja la instrucción OUT.

c) Qué hacen y para qué se usan las instrucciones CLI y STI.

Ejercicio_11
============
```Assembly
ORG 3000H
CONTAR: INT 7
 MOV AL, 20H
 OUT 20H, AL
IRET

ORG 1000H
CARACTER DB "A"

ORG 2000H
;CONFIGURO EL VECTOR DE INTERRUPCIONES
 MOV AX, CONTAR 
 MOV BX, 40 
 MOV [BX], AX 

 
 CLI
 MOV AL, 11111110B      ;ACTIVO EL F10
 OUT 21H, AL            ;MANDO AL SMR LOS DATOS
 MOV AL, 10             ;ID 10
 OUT 24H, AL            ;MANDO LA ID A INT0
 STI
 
 MOV BX, OFFSET CARACTER
 
 REINICIAR: MOV BYTE PTR [BX],40H
 
 LOOP: INC BYTE PTR [BX];AUMENTO EL CARACTER
 MOV AL,1
 MOV AH,0
 CMP BYTE PTR [BX],5AH  ;SI LLEGO A LA Z, REINICIO
 JZ REINICIAR
 JMP LOOP 
INT 0
END
```
Ejercicio_12
============
```Assembly
ORG 1000H
 SEG DB 30H
     DB 30H
 FIN DB ?
 
ORG 3000H
 RUT_CLK: PUSH AX
 
 ;VAMOS SUMANDO DEL 00 AL 09
 MOV BX, OFFSET SEG
 INC BX
 INC BYTE PTR [BX]
 CMP BYTE PTR [BX], 3AH
 JNZ RESET
 
 ;VAMOS SUMANDO DEL 00 AL 60 (En la direccion que le sigue a segundo)
 ;COMIENZO EN EL SEGUNDO DIGITO
 MOV BYTE PTR [BX], 30H ;iniciamos en 0
 DEC BX ;SEG
 INC BYTE PTR [BX]
 CMP BYTE PTR [BX], 36H ;Hasta el 60
 JNZ RESET
 
 MOV BYTE PTR [BX], 30H
 
 RESET: MOV BX, OFFSET SEG ;REINICIAMOS EL ESTADO DE SEGUNDOS
 MOV AL, OFFSET FIN-OFFSET SEG ;PORQUE LO USAMOS MAS ARRIBA
 INT 7
 MOV AL, 0
 OUT 10H, AL
 MOV AL, 20H
 OUT 20H, AL
 POP AX
IRET
 
ORG 2000H
 ;ID 10 PARA EL TIMER
 ;CONFIGURAMOS EL VECTOR DE INTERRUPCIONES
 MOV AX, RUT_CLK
 MOV BX, 40
 MOV [BX], AX
 ;CONFIGURAMOS EL PIC
 CLI
 MOV AL, 11111101b ;Activamos el timer
 OUT 21H, AL ; PIC: registro IMR
 
 MOV AL, 10
 OUT 25H, AL ; PIC: registro INT1 (Timer)
 MOV AL, 1
 OUT 11H, AL ; TIMER: registro COMP 
 MOV AL, 0
 OUT 10H, AL ; TIMER: registro CONT
 STI
 
 LAZO: JMP LAZO
END
```
Ejercicio_15
============
```Assembly
ORG 3000H
;Subrutina que atiende a la F10
CONTAR: INT 6
 MOV AL, 1 
 MOV DX, LEIDO
 
 DECREMENTAR: INT 7
 DEC LEIDO
 CMP LEIDO, 30H
 JNZ DECREMENTAR
 
 MOV AL, 0
 
 ;AVISAR AL PIC QUE TERMINAMOS!
 OUT 10H, AL
 MOV AL, 20H
 OUT 20H, AL

 ;VOLVEMOS
IRET

ORG 1000H
 LEIDO DB ?
 FIN DB ?

ORG 2000H
 ;SELECCIONAR ID 10 PARA EL F10
  
 ;CONFIGURAMOS EL VECTOR DE INTERRUPCIONES
 MOV AX, CONTAR ;AX = Dir de CONTAR(3000H)
 MOV BX, 40 ;10 * 4 en el Vec. de Int.
 MOV [BX], AX ;EN LA POSICION 40 PONE EL 3000H

 ;CONFIGURAMOS EL PIC
 CLI
 MOV AL, 11111100B ;Configuramos solo el INT0 (F10) Y EL TIMER (F11)
 OUT 21H, AL  ;IMR
 MOV AL, 10
 OUT 24H, AL ;ID 10(PUEDE SER CUALQUIERA)
 INC AL ;MANDAMOS LA ID 11 PARA EL TIMER
 OUT 25H, AL 
 MOV AL, 10 ;ES 10, POR SI LO CAMBIO
 OUT 11H, AL ; TIMER: registro COMP 
 MOV AL, 0
 OUT 10H, AL ; TIMER: registro CONT
 STI
 
 MOV BX, OFFSET LEIDO
 LOOP: JMP LOOP ;LOOP INFINITO
 
INT 0
END
```


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

<h1 align="center"> 💻Practica 4 </h1>

<h1 align="center"> Segmentación de cauce en procesador RISC</h1>

1 ) Muchas instrucciones comunes en procesadores con arquitectura CISC no forman parte del repertorio de instrucciones del MIPS64, pero pueden implementarse haciendo uso de una única instrucción. Evaluar las siguientes instrucciones, indicar qué tarea realizan y cuál seria su equivalente en el lenguaje assembly del x86. [Resolución](#Ejercicio_1)

```s
a) dadd r1, r2, r0
b) daddi r3, r0, 5
c) dsub r4, r4, r4
d) daddi r5, r5, -1
e) xori r6, r6, 0xffffffffffffffff
```


2 ) El siguiente programa intercambia el contenido de dos palabras de la memoria de datos, etiquetadas A y B. 

```s
.data
    A: .word 1
    B: .word 2
.code
    ld r1, A(r0)
    ld r2, B(r0)
    sd r2, A(r0)
    sd r1, B(r0)
halt
```

a ) Ejecutarlo en el simulador con la opción Configure/Enable Forwarding deshabilitada. Analizar paso a paso su funcionamiento, examinar las distintas ventanas que se muestran en el simulador y responder: [Resolución](#Ejercicio_2a)

- ¿Qué instrucción está generando atascos ***(stalls)*** en el cause ***(ó pipeline)*** y por qué?
- ¿Qué tipo de ```stall``` es el que aparece?
- ¿Cuál es el promedio de Ciclor por instrucciones ***(CPI)*** en la ejecución de este programa bajo esta configuración?

b ) Una forma de solucionar los atascos por dependencia de datos es utilizando el Adelantamiento de Operandos o Forwarding. [Resolución](#Ejercicio_2b)

Ejecutar nuevamente el programa anterior con la opción Enable Forwarding habilitada y responder:

- ¿Por que no se presenta ningún atasco en este caso? Explicar la mejora.
- ¿Qué indica el color de los registros en la ventana ***Register*** durante la ejecución?
- ¿Cuál es el promedio de Ciclos Por Instruccion ***(CPI)*** en este caso? Comparar con el anterior

3 ) Analizar el siguiente programa con el simulador MIPS64:  

```s
.data
    A: .word 1
    B: .word 3
.code
    ld r1, A(r0)
    ld r2, B(r0)
    loop: dsll r1, r1, 1
        daddi r2, r2, -1
        bnez r2, loop
halt
```

a ) Ejecutar el programa con Forwarding habilitado y responder: [Resolución](#Ejercicio_3a)

- ¿Por qué se presentan atascos tipo RAW?
- Branch Taken es otro tipo de atasco que aparece. ¿Qué significa? ¿Por qué se produce?
- ¿Cuántos CPI tiene la ejecución de este programa? Tomar nota del número de ciclos, cantidad de instrucciones y CPI.

b ) Ejecutar ahora el programa deshabilitando el Forwarding y responder: [Resolución](#Ejercicio_3b)

- ¿Qué instrucciones generan los atascos tipo RAW y por qué? ¿En qué etapa del cauce se produce el atasco en cada caso y durante cuántos ciclos?
- Los Branch Taken Stalls se siguen generando. ¿Qué cantidad de ciclos dura este atasco en cada vuelta del lazo ***loop***?
 
Comparar con la ejecución con Forwarding y explicar la diferencia.

- ¿Cuántos CPI tiene la ejecución del programa en este caso? Comparar número de ciclos, cantidad de instrucciones y CPI con el caso con Forwarding.

c ) Reordenar las instrucciones para que la cantidad de RAW sea „0‟ en la ejecución del programa (Forwarding habilitado) [Resolución](#Ejercicio_3c)

d ) Modificar el programa para que almacene en un arreglo en memoria de datos los contenidos parciales del registro r1 ¿Qué significado tienen los elementos de la tabla que se genera? [Resolución](#Ejercicio_3d)


4 ) Dado el siguiente programa 

```s
.data
    tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
    num: .word 7
    long: .word 10
.code
    ld R1, long(R0)         ; R1  = 10
    ld R2, num(R0)          ; R2 = 7
    dadd R3, R0, R0         ; R3 = R0 + R0 (INICIALIZO R3)
    dadd R10, R0, R0        ; R10 = R0 + R0 (INICIALIZO R10)

    loop: ld R4, tabla(R3)  ; R4 = TABLA + R3(POS) RECORRO LA TABLA
        beq R4, R2, listo   ; SI EL NRO DE LA TABLA ACTUAL ES IGUAL AL NRO QUE ESTOY BUSCANDO, TERMINO
        daddi R1, R1, -1    ; DECREMENTO EL CONTADOR DE TABLA
        daddi R3, R3, 8     ; R3 = R3 + 8 (CADA NRO EN LA TABLA OCUPA 1 BYTE QUE SON 8 BITS)
        bnez R1, loop       ; MIENTRAS NO LLEGUE AL FINAL, CONTINUO

    j fin                   ; TERMINO
    listo: daddi R10, R0, 1 ; R10 = 0 + 1 ; QUIERO ENTENDER QUE ES PARA AVISAR QUE ENCONTRE EL NRO
fin: halt
```

a ) Ejecutar en simulador con Forwarding habilitado. ¿Qué tarea realiza? ¿Cuál es el resultado y dónde queda indicado? [Resolución](#Ejercicio_4a)

b) Re-Ejecutar el programa con la opción Configure/Enable Branch Target Buffer habilitada. Explicar la ventaja de usar este método y cómo trabaja. [Resolución](#Ejercicio_4b)

c) Confeccionar una tabla que compare número de ciclos, CPI, RAWs y Branch Taken Stalls para los dos casos anteriores. [Resolución](#Ejercicio_4c)

5 ) El siguiente programa multiplica por 2 los elementos de un arreglo llamado datos y genera un nuevo arreglo llamado res. Ejecutar el programa en el simulador winmips64 con la opción Delay Slot habilitada. [Resolución](#Ejercicio_5)

```s
.data
    cant: .word 8
    datos: .word 1, 2, 3, 4, 5, 6, 7, 8
    res: .word 0
.code
    dadd R1, R0, R0         ;INICIALIZO R1
    ld R2, cant(R0)         ; R2 = 8
    loop: ld R3, datos(R1)  ; R3 = ELEMENTO DE TABLA EN X POSICION
        daddi R2, R2, -1    ; DECREMENTO EL CONTADOR DE TABLA
        dsll R3, R3, 1      ; MUEVO LOS BITS UNA POSICION A LA IZQUIERDA QUE SERIA EL EQUIVALENTE A MULTIPLICARLOS X2
        sd R3, res(R1)      ; R3 = REMPLAZO EL VALOR NUEVO EN LA TABLA
        daddi R1, R1, 8     ; ME MUEVO AL SIGUIENTE ELEMENTO DE LA TABLA
        bnez R2, loop       ; MIENTRAS NO TERMINE DE RECORRER LA TABLA, CONTINUO
    nop
halt
```

a ) ¿Qué efecto tiene habilitar la opción Delay Slot (salto retardado)?.

b ) ¿Con qué fin se incluye la instrucción NOP? ¿Qué sucedería si no estuviera?.

c ) Tomar nota de la cantidad de ciclos, la cantidad de instrucciones y los CPI luego de ejecutar el programa.

d ) Modificar el programa para aprovechar el „Delay Slot‟ ejecutando una instrucción útil. Simular y comparar número de ciclos, instrucciones y CPI obtenidos con los de la versión anterior.

6 ) Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D. [Resolución](#Ejercicio_6)

7 ) Escribir un programa que recorra una TABLA de diez números enteros y determine cuántos elementos son mayores que X. [Resolución](#Ejercicio_7)

El resultado debe almacenarse en una dirección etiquetada CANT. El programa debe generar además otro arreglo llamado RES cuyos elementos sean ceros y unos. Un „1‟ indicará que el entero correspondiente en el arreglo TABLA es mayor que X, mientras que un „0‟ indicará que es menor o igual.

8 ) Escribir un programa que multiplique dos números enteros utilizando sumas repetidas (similar a Ejercicio 6 o 7 de la Práctica 1). El programa debe estar optimizado para su ejecución con la opción Delay Slot habilitada. [Resolución](#Ejercicio_8)


Ejercicio_1
===========
```s
# dadd r1, r2, r0   R1 = R2 + R0
# daddi r3, r0, 5   R3 = R0 + 5
# dsub r4, r4, r4   R4 = R4 - R4
# daddi r5, r5, -1  R5 = R5 + -1
# xori r6, r6, 0xffffffffffffffff  R6 = R6 XOR 0xffffffffffffffff
```

Ejercicio_2a
============

- ¿Qué instrucción está generando atascos ***(stalls)*** en el cause ***(ó pipeline)*** y por qué?

La instrucción ```SD R2, A(r0)``` almacena en la dirección de memoria ***A*** el valor contenido en el registro ***R2***, mientras que la instrucción  anterior ```LD R2, B(r0)``` carga desde la dirección de memoria ***B*** el contenido de esa posición en el registro ***R2***.

Cuando fordwarding no está habilitado la instrucción ```SD R2, A(r0)``` que en la etapa ***ID*** trata de leer el contenido de ***R2***, pero dicho contenido no estará disponible hasta que la instrucción anterior ```LD R2, B(r0)``` llegue a la etapa ***WB***.

Y debido a esto se genera un atasco en la etapa ***ID*** donde se procesa la instrucción ```SD R2, A(r0)``` retrasando la salida de la etapa ***(con RAWs)*** a la espera del contenido del registro. Esto además genera que la instrucción posterior ```SD R1, B(r0)``` deba permanecer en la etapa ***IF*** sin poder avanzar a la etapa ***ID*** (el pipeline se detuvo) como se puede ver en la imagen.

Tener en cuenta que en la primera mitad de la etapa ***WB*** se escribe el contenido en ***R2*** y en el segundo ***RAW*** se lee el contenido de dicho registro.

![image](https://user-images.githubusercontent.com/55964635/140976382-6b7297b5-732f-42e8-ad5b-c9b1ee52a9ea.png)

- Branch Taken es otro tipo de atasco que aparece. ¿Qué significa? ¿Por qué se produce?

Aparecen atascos de tipo ***RAW (Read After Write)*** causado por una dependencia de datos, en este caso intenta leer un dato antes que esté guardado en el registro. Serán dos atascos, equivalentes a dos ciclos hasta que ```LD R2, B(r0)``` salga de la estapa ***WB***.

- ¿Cuántos CPI tiene la ejecución de este programa? Tomar nota del número de ciclos, cantidad de instrucciones y CPI.

El ***CPI*** de la ejecución de este programa es de 2.2

<table>
<tr>
<td> Ejecución </td> <td> Funciones </td>
</tr>
<tr>
<td>
 
![image](https://user-images.githubusercontent.com/55964635/140979278-78e2e908-83cc-4ee5-9544-b9d857686baa.png)
    
</td>
<td>
 

Ciclos por instrucción (CPI) = 2,2
    
Espera por dependencia de datos (RAW) = 2
 
</td>
</tr>
 
</table>

Ejercicio_2b
============

Con la opción forwarding habilitada el dato contenido en el registro R2 podrá ser leído por la instrucción ```SD R2, A(r0)``` cuando la instrucción ```LD R2, B(r0)``` se encuentra finalizando la etapa ***MEM***. La instrucción ```SD R2, A(r0)``` no tiene que esperar a que la instrucción ```LD R2, B(r0)``` salga de la etapa ***WB***. De esta manera no aparecen atascos del tipo ***RAW***.

![image](https://user-images.githubusercontent.com/55964635/140980974-2d170779-38ae-4b28-8594-03465e485b71.png)


Ejercicio_3a
============

- ¿Por qué se presentan atascos tipo RAW?

Se presentan atasco por dependencia de datos de tipo ***RAW*** causado por la instrucción ***BNEZ R2***, loop al procesarse en la etapa ***ID***. Esta instrucción necesita del contenido del registro ***R2*** que está siendo utilizado por la instrucción ***DADDI R2,R2, -1*** en la etapa EX sin salir aún de esta.

- Branch Taken es otro tipo de atasco que aparece. ¿Qué significa? ¿Por qué se produce?

El atasco de tipo ***Branch Taken Stalls (BTS)***, ocurre como concecuencia de la ejecución incorrecta de la instrucción siguiente a una instrucción condicional. Esto se debe a que la condición a evaluar tarda algunos ciclos en ser ejecutada, mientras que durante esos ciclos siguen entrando nuevas instrucciones al pipeline. Luego de evaluada la condición si la instrucción posterior a ésta que se ejecutó no es la que debía ser ejecutada, su ejecución se trunca y se ejecuta la que está en el lugar de memoria indicada por la etiqueta en la instrucción condicional.

![image](https://user-images.githubusercontent.com/55964635/141157733-1ba69e9c-8889-46fa-9460-868e51ecf04e.png)

- ¿Cuántos CPI tiene la ejecución de este programa? Tomar nota del número de ciclos, cantidad de instrucciones y CPI.

Se ejecutan 12 instrucciones en 21 ciclos dando un ***CPI*** de 1.750

![image](https://user-images.githubusercontent.com/55964635/141158306-30d4fc0a-dd46-4e7c-a4c2-dc8f2a6d438a.png)


Ejercicio_3b
============

- ¿Qué instrucciones generan los atascos tipo RAW y por qué? ¿En qué etapa del cauce se produce el atasco en cada caso y durante cuántos ciclos?

Las instrucciones que generan atascos ***RAW*** son:

la instrucción ```DSLL R1,R1,1``` (ver registro ***R1*** coloreado en gris), que trata de leer el contenido del registro ***R1***, mientras que la instrucción ```LD R1,A(r0)``` todavía no copio el contenido de la dirección de memoria A en R1 y permanece aún en la etapa WB (RAW durante 1 ciclo).

Y la instrucción ```BNEZ R2,loop``` (ver registro ***R2*** coloreado en gris), que trata de leer el contenido del registro ***R2***, mientras que ```DADDI R2,R2,-1``` está buscando copiar el resultado de la operación en dicho registro, permaneciendo en la etapa ***MEM*** y posteriormente en la etapa ***WB*** (***RAW*** durante 2 ciclos).

![image](https://user-images.githubusercontent.com/55964635/141158925-d29f52e4-74ad-4ad9-a2e0-ddbcf5484e4e.png)

- Los Branch Taken Stalls se siguen generando. ¿Qué cantidad de ciclos dura este atasco en cada vuelta del lazo ***‘loop’***? Comparar con la ejecución con Forwarding y explicar la diferencia.

Con forwarding deshabilitada, Los atascos por Branch Taken Stalls duran 2 ciclos en cada vuelta del lazo loop, mientras que con dicha opción habilitada se reducen a 1 ciclo por vuelta de lazo.

Esta diferencia tiene su causa en la instrucción condicional que es la que está generando los atascos ***RAW;*** entonces al disminuir la cantidad de ***RAWs*** producidos por esta, también disminuyen los ciclos de espera de la instrucción siguiente, que además se dejara de ejecutar si la condicional así se lo indica al procesador.

- ¿Cuántos CPI tiene la ejecución del programa en este caso? Comparar número de ciclos, cantidad de instrucciones y CPI con el caso con Forwarding.

```a completar```

Ejercicio_3c
============

Con la opción forwarding habilitada aún siguen apareciendo atascos RAW. Existe la posibilidad de tratar de eliminarlos reordenando las instrucciones en el programa y Dicho reordenamiento no debe afectar la lógica de este. El resultado de este método puede observarse en la imagen siguiente.

![image](https://user-images.githubusercontent.com/55964635/141161278-22c3d010-d133-4bd9-b8c7-17a1666bfb93.png)

![image](https://user-images.githubusercontent.com/55964635/141164804-dad4f7ab-d78f-4c22-974f-b16fe14e7c6b.png)


Ejercicio_3d
============

```Completar```

Ejercicio_4a
============

![image](https://user-images.githubusercontent.com/55964635/141165757-05440f46-6fb1-4c37-8c53-7952e3fdbfb6.png)

Ejercicio_4b
============

Ejercicio_4c
============

El programa busca en TABLA un elemento igual al contenido en la dirección de memoria NUM. En este caso dicha coincidencia se produce cuando el contenido del registro R4 es igual al contenido del registro R2 (R4=R2), razón por la cual luego de evaluada esta condición y de resultar verdadera se salta a la posición de memoria indicada por la etiqueta “listo”. Cuando hay coincidencia la línea de programa en listo suma al registro R10 un 1, caso contrario el contenido del registro R10 queda en 0. Este es el resultado y queda almacenado en el registro R10. El registro R3 se utiliza como índice para recorrer la TABLA. El contenido del registro R3 se incrementa de a 8 porque cada elemento de tabla es del tamaño word, es decir de 64 bits (8 bytes).

Habilitando la opción Branch Target Buffer (BTB) logramos reducir los atascos Branch Taken stalls a la mitad.

Tener en cuenta que esta opción es útil cuando aumenta la cantidad de iteraciones de un lazo. Como vemos también esta opción no actúa sobre los atascos por dependencia de datos (RAW en este caso) que no se modifican. 


Ejercicio_5
===========

Ejercicio_6
===========

```s
.data
    NROA: .word 1
    NROB: .word 2
    NROC: .word 1
    NROD: .word 0

.code
    ld R1, NROA(R0) 
    ld R2, NROB(R0) 
    ld R3, NROC(R0)
    ld R4, NROD(R0)

    
    bne R1, R2, continuar
    DADDI R4, R4, 2
    bne R1, R3, continuar2
    DADDI R4, R4, 1
    j TERMINAR

    continuar: bne R1, R3, TERMINAR
    DADDI R4, R4, 2
    bne R3, R2, TERMINAR
    DADDI R4, R4, 1
    j TERMINAR

    continuar2: bne R2, R3, TERMINAR
    DADDI R4, R4, 2

    TERMINAR: sd R4, NROD(R0)


    FIN: HALT

````

Ejercicio_7
===========

```s
.data
    TABLA: .word 1,2,3,4,5,6,7,8,9,10
    X: .word 6
    CANT: .word 0
    RES: .word 0

.code
    DADDI R10, R0, -8
    DADDI R11, R0, 80
    LD R1, X(R0)
    DADDI R4, R0, 1
    LD R5, CANT(R0)

    LOOP: DADDI R10, R10, 8
        BEQ R10, R11, FIN
        LD R2, TABLA(R10)
        SLT R3, R1, R2
        BNE R3, R4, LOOP
        DADDI R5, R5, 1
        SD R4, RES(R10)
        j LOOP
    FIN: SD R5, CANT(R0)
    HALT
```

Ejercicio_8
===========

```s
.data
    NUM1: .word 3
    NUM2: .word 5
    RES: .word 0
.code
    ld R1, NUM1(r0) ; 3
    ld R2, NUM2(r0) ; 8
    dadd R3, R0, R0
    loop: dadd R3, R3, R1
        daddi R2,R2, -1
        bnez R2, loop
    sd R3, RES(r0)
halt
```
con delay slot activado

```s
.data
    num1: .word 3
    num2: .word 5
    res: .word 0
.code
    LD r1, num1(r0)
    LD r2, num2(r0)
    DADD r10, r0, r0
    LOOP: DADDI r2, r2, -1
        BNEZ r2, LOOP
        DADD r10, r10, r1
        SD r10, res(r0)
    HALT
```

<h1 align="center">💻Practica 5 </h1>

<h1 align="center">Instrucciones de Punto Flotante y pasaje de parámetros</h1>

```1)``` Simular el siguiente programa de suma de números en punto flotante y analizar minuciosamente la ejecución paso a paso. Inhabilitar Delay Slot y mantener habilitado Forwarding. [Resolución](#Ejercicio_1)

```s
.data
    n1: .double 9.13
    n2: .double 6.58
    res1: .double 0.0
    res2: .double 0.0
.code
    l.d f1, n1(r0)
    l.d f2, n2(r0)
    add.d f3, f2, f1
    mul.d f4, f2, f1
    s.d f3, res1(r0)
    s.d f4, res2(r0)
    halt
```

```a)``` Tomar nota de la cantidad de ciclos, instrucciones y CPI luego de la ejecución del programa.

```b)``` ¿Cuántos atascos por dependencia de datos se generan? Observar en cada caso cuál es el dato en conflicto y las instrucciones involucradas.

```c)``` ¿Por qué se producen los atascos estructurales? Observar cuales son las instrucciones que los generan y en qué etapas del pipeline aparecen.

```d)``` Modificar el programa agregando la instrucción ```mul.d f1, f2, f1``` entre las instrucciones ```add.d y mul.d```. Repetir la ejecución y observar los resultados. ¿Por qué aparece un atasco tipo ***WAR***?

```e)``` Explicar por qué colocando un ***NOP*** antes de la suma, se soluciona el ***RAW*** de la instrucción ***ADD*** y como consecuencia se elimina el ***WAR***. 

```2)``` Es posible convertir valores enteros almacenados en alguno de los registros ```r1-r31``` a su representación equivalente en punto flotante y viceversa. Describa la funcionalidad de las instrucciones ***mtc1, cvt.1.d, cvt.d.1 y mfc1***. [Resolución](#Ejercicio_2)

```3)``` Escribir un programa que calcule la superficie de un triángulo rectángulo de base 5,85 cm y altura 13,47 cm. [Resolución](#Ejercicio_3)

Pista: la superficie de un triángulo se calcula como: 

```Superficie = (base x altura) / 2```

```4)``` El índice de masa corporal (IMC) es una medida de asociación entre el peso y la talla de un individuo. [Resolución](#Ejercicio_4)

Se calcula a partir del peso (expresado en kilogramos, por ejemplo: 75,7 kg) y la  estatura (expresada en metros, por ejemplo 1,73 m), usando la fórmula:

```IMG = PESO / (ESTATURA)^2```

De acuerdo al valor calculado con este índice, puede clasificarse el estado nutricional de una persona en:

***Infrapeso*** (IMC < 18,5), ***Normal*** (18,5 ≤ IMC < 25), ***Sobrepeso*** (25 ≤ IMC < 30) y ***Obeso*** (IMC ≥ 30).

Escriba un programa que dado el peso y la estatura de una persona calcule su IMC y lo guarde en la dirección etiquetada ***IMC***. También deberá guardar en la dirección etiquetada ```estado``` un valor según la siguiente tabla:

| IMC | Clasificación | Valor guardado |
| :---         |     :---:      |          ---: |
| < 18,5   | Infrapeso     | 1    |
| < 25     | Normal       | 2      |
| < 30     | Sobrepeso       | 3      |
| >=30     | Obeso       | 4      |



```5)``` El procesador MIPS64 posee 32 registros, de 64 bits cada uno, llamados r0 a r31 (también conocidos como $0 a $31).  [Resolución](#Ejercicio_5)

Sin embargo, resulta más conveniente para los programadores darles nombres más significativos a esos registros.

La siguiente tabla muestra la convención empleada para nombrar a los 32 registros mencionados:

| Registros | Nombres | ¿Para que se los utiliza? | ¿Preservado? |
| :---         |     :---:      |          ---: |     ---: |
| r0   | $zero     | 1    | |
| r1     | $at       | 2      | |
| r2-r3     | $v0-$v1       | 3      | |
| r4-r7     | $a0-$a3       | 4      | |
| r8-r15     | $t0-$t7      | 4      | |
| r16-r23     | $s0-$s7       | 4      | |
| r24-r25     | $t8-$t9       | 4      | |
| r26-r27     | $k0-$k1      | 4      | |
| R28     | $gp       | 4      | |
| R29     | $sp       | 4      | |
| R30     | $fp       | 4      | |
| R31     | $ra       | 4      | |

Complete la tabla anterior explicando el uso que normalmente se le da cada uno de los registros nombrados. Marque en la columna ```“¿Preservado?”``` si el valor de cada grupo de registros debe ser preservado luego de realizada una llamada a una subrutina. Puede encontrar información útil en el apunte Programando sobre MIPS64

```6)``` Como ya se observó anteriormente, muchas instrucciones que normalmente forman parte del repertorio de un procesador con arquitectura CISC no existen en el MIPS64. En particular, el soporte para la invocación a subrutinas es mucho más simple que el provisto en la arquitectura x86 (pero no por ello menos potente). El siguiente programa muestra un ejemplo de invocación a una subrutina. [Resolución](#Ejercicio_6)

```s
.data
    valor1: .word 16
    valor2: .word 4
    result: .word 0
    
.text
    ld $a0, valor1($zero)
    ld $a1, valor2($zero)
    jal a_la_potencia
    sd $v0, result($zero)
    halt

a_la_potencia: daddi $v0, $zero, 1
    lazo: slt $t1, $a1, $zero
    bnez $t1, terminar
    daddi $a1, $a1, -1
    dmul $v0, $v0, $a0
    j lazo
    terminar: jr $ra
```

```a)``` ¿Qué hace el programa? ¿Cómo está estructurado el código del mismo?

```b)```  ¿Qué acciones produce la instrucción ***jal***? ¿Y la instrucción ***jr***?

```c)``` ¿Qué valor se almacena en el registro ***$ra***? ¿Qué función cumplen los registros ***$a0*** y ***$a1***? ¿Y el registro ***$v0***?

```d)``` ¿Qué sucedería si la subrutina a_la_potencia necesitara invocar a otra subrutina para realizar la multiplicación, por ejemplo, en lugar de usar la instrucción ***dmul***? ¿Cómo sabría cada una de las subrutinas a que dirección de memoria deben retornar?

```7)``` Escriba una subrutina que reciba como parámetros un número positivo M de 64 bits, la dirección del comienzo de una tabla que contenga valores numéricos de 64 bits sin signo y la cantidad de valores almacenados en dicha tabla. La subrutina debe retornar la cantidad de valores mayores que M contenidos en la tabla. [Resolución](#Ejercicio_7)

```8)``` Escriba una subrutina que reciba como parámetros las direcciones del comienzo de dos cadenas terminadas en cero y retorne la posición en la que las dos cadenas difieren. En caso de que las dos cadenas sean idénticas, debe retornar -1. [Resolución](#Ejercicio_8)

```9)``` Escriba la subrutina ES_VOCAL, que determina si un carácter es vocal o no, ya sea mayúscula o minúscula. La rutina debe recibir el carácter y debe retornar el valor 1 si el carácter es una vocal, o 0 en caso contrario. [Resolución](#Ejercicio_9)

```10)``` Usando la subrutina escrita en el ejercicio anterior, escribir la subrutina ***CONTAR_VOC***, que recibe una cadena terminada en cero , y devuelve la cantidad de vocales que tiene esa cadena. [Resolución](#Ejercicio_10)

```11)``` Escribir una subrutina que reciba como argumento una tabla de números terminada en 0. La subrutina debe contar la cantidad de números que son impares en la tabla, esta condición se debe verificar usando una subrutina es_impar. La subrutina es_impar debe devolver 1 si el número es impar y 0 si no lo es. [Resolución](#Ejercicio_11)

```12)``` El siguiente programa espera usar una subrutina que calcule en forma recursiva el factorial de un número entero: [Resolución](#Ejercicio_12)

```s
data
    valor: .word 10
    result: .word 0
.text
    daddi $sp, $zero, 0x400 ; Inicializa puntero al tope de la pila
    (1)
    ld $a0, valor($zero)
    jal factorial
    sd $v0, result($zero)
    halt
factorial: ...
...
```

(1) La configuración inicial de la arquitectura del WinMIPS64 establece que el procesador posee un bus de direcciones de 10 bits para la memoria de datos. Por lo tanto, la mayor dirección dentro de la memoria de datos será de 2^10 = 1024 = 400 sub 16

```a)``` Implemente la subrutina factorial definida en forma recursiva. Tenga presente que el factorial de un número entero n se calcula como el producto de los números enteros entre 1 y n inclusive:

```factorial(n) = n! = n * (n - 1) * (n - 2) * ... * 3 * 2 * 1```

```b)``` ¿Es posible escribir la subrutina factorial sin utilizar una pila? Justifique.


<h1 align="center">Ejercicios</h1>

Ejercicio_1
===========
```a)``` 16 ciclos, 7 instrucciones y 2,286 Ciclos por Instrucción (CPI)

```b)``` Se generan dos atascos por dependencia de datos

Ejercicio_2
===========

- mtc1 Rx, Fx: Copia los 64 bits del registro entero Rx al registro Fx de punto flotante
- cvt.1.d Fx, Fy: Convierte a entero el valor en punto flotante contenido en Fy, dejándolo en Fx
- cvt.d.1 Fx, Fy: Convierte a punto flotante el valor entero copiado al registro Fy, dejándolo en Fx
- mfc1 Rx, Fx: Copia los 64 bits del registro Fx de punto flotante al registro Rx entero  

Ejercicio_3
===========

Resultado ```39,39975  exa 3C 1E87```

Ejercicio_4
===========
Ejercicio_5
===========

| Registros | Nombres | ¿Para que se los utiliza? | ¿Preservado? |
| :---         |     :---:      |          ---: |     ---: |
| r0   | $zero     | Siempre tiene el valor 0 y no se puede cambiar    |      |
| r1     | $at       | Return Address- Dir. de retorno de subrutina. Debe ser salvado      | |
| r2-r3     | $v0-$v1       | Valores de retorno de la subrutina llamada      | |
| r4-r7     | $a0-$a3       | Argumentos pasados a la subrutina llamada      | |
| r8-r15     | $t0-$t7      | Registros temporarios      | |
| r16-r23     | $s0-$s7       | Registros que deben ser salvados      | |
| r24-r25     | $t8-$t9       | Registros temporarios      | |
| r26-r27     | $k0-$k1      | Para uso del kernel del sistema operativo     | |
| R28     | $gp       | Global pointer - puntero a zona de memoria estástica. Debe ser salvado      | |
| R29     | $sp       | Stack Pointer - Puntero de pila. Debe ser salvado      | |
| R30     | $fp       | Frame Pointer -  Puntero de pila. Debe ser salvado      | |
| R31     | $ra       | Return Addres - Dir. de retorno de subrutina. Debe ser salvado      | |

Ejercicio_6
===========
```s
.data
    VALOR1: .word 2
    VALOR2: .word 4
    RES:    .word 0
    
.text
    ld $a0, VALOR1($zero)   ; a = 16
    ld $a1, VALOR2($zero)   ; a1 = 4
    jal a_la_potencia       ; Salta y guarda la dir en R31
    sd $v0, RES($zero)      ; Muesto el valor de retorno de la subrutina
    halt

    a_la_potencia: daddi $v0, $zero, 1  ; Incremento v0
        lazo: slt $t1, $a1, $zero       ; si a1 < 0 deja un 1 en t1
        bnez $t1, terminar              ; cuando t1 llega a 0 termino
        daddi $a1, $a1, -1              ; decremento a1
        dmul $v0, $v0, $a0              ; v0 = v0 * a0
        j lazo

    terminar: jr $ra

    ; El programa saca la potencia de un nro, el programa hace VALOR2 ^ VALOR1

    ; jal Salta a la dirección rotulada offN y copia en r31 la dirección de retorno

    ; Salta a la dirección contenida en el registro rd
```
Ejercicio_7
===========
```s
.data
    M: .word 3
    TABLA: .word 1,2,3,4,5
    RESULTADO: .word 0
.code
    ld $a0, M(r0)           ; a0 = 14
    daddi $a1, $0, 5        ; a1 = cantidad de elementos
    daddi $a2, $0, TABLA    ; a2 = paso la direccion de TABLA
    jal VALORES             ; salto a la rutina y guardo la direccion de retorno
    nop                     ; pinto
    sd $v0, RESULTADO($0)   ; VALORES de retorno de la subrutina, lo guardo en RESULTADO
    halt

VALORES: dadd $t0, $a1, $0              ; guardo 5 en el registro temporal
    dadd $v0, $0, $0                    ; inicializo v0
    LOOP: ld $t4, 0($a2)                ; copia en el registro temporal el primer elemento de la TABLA
        slt $t2, $t4, $a0               ; si t4 es menor que a0, entonces dejo 1 en t2
        bnez $t2 ,NO_INCREMENTAR        ; si t2 <> 0 entonces salto a NO_INCREMENTAR
        beq $t4, $a0, NO_INCREMENTAR    ; Si es igual, no incremento
        daddi $v0, $v0, 1               ; aumento el contador 
    NO_INCREMENTAR: daddi $a2, $a2, 8   ; avanzo en la tabla
        daddi $t0, $t0, -1              ; decremento el contador de elementos de tabla
        bnez $t0, LOOP                  ; si t0 <> 0 salto a loop
        jr $ra                          ; vuelve al programa principal
```
Ejercicio_8
===========
```s
.data
    CADENA1: .asciiz "hola"
    CADENA2: .asciiz "holaa"
    result:  .word 0
.code
    daddi $a0, $0, CADENA1      ; a0 = CADENA1
    daddi $a1, $0, CADENA2      ; a1 = CADENA2
    jal compara                 ; Llamo a la subrutina
    sd $v0, result($zero)       ; guardo el valor
halt

compara: dadd $v0, $0, $0   ; inicializo V0
    LOOP: lbu $t0, 0($a0)   ; COPIA LA DIRECCION DE CADENA1
        lbu $t1, 0($a1)     ; COPIA LA DIRECCION DE CADENA2
        beqz $t0, FIN_CAD1  ; SI LLEGO AL FINAL DE CADENA1, SALTO
        beqz $t1, FIN       ; SI LLEGO AL FINAL DE CADENA2, SALTO
        bne $t0, $t1, FIN   ; SI EL CARACTER ACTUAL DE CADENA1 <> CARACTER ACTUAL CADENA2, TERMINO
        
        daddi $v0, $v0, 1       ; INCREMENTO
        daddi $a0, $a0, 1       ; INCREMENTO
        daddi $a1, $a1, 1       ; INCREMENTO
    j LOOP

    FIN_CAD1: bnez $t1, FIN     ; SI T1 <> 0, TERMINO
        daddi $v0, $0, -1
    FIN: jr $ra
```
Ejercicio_9
===========
```s
.data
    LETRA: .ascii '1'
    VOCALES: .asciiz 'AEIOUaeiou'
    RESULTADO: .word 0
.code
    lbu $a0, LETRA($0)          ; paso el CARACTER
    jal ES_VOCAL                ; llamo a la subrutina
    sd $v0, RESULTADO($zero)    ; guardo el resultado
halt

ES_VOCAL:   dadd $v0, $0, $0                ; inicializo v0
            daddi $t0, $0, 0                ; inicializo t0
            LOOP: lbu $t1, VOCALES($t0)     ; copia el  caracter en t1
                beqz $t1, FIN_VOCAL         ; si t1 = 0, no se encontro VOCALES
                beq $a0, $t1, ENCONTRO      ; si LETRA = caracterActual, salto
                daddi $t0, $t0, 1           ; continuo con el siguiente caracter
            j LOOP

            ENCONTRO: daddi $v0, $0, 1      ; si es vocal, retorno 1
            
            FIN_VOCAL: jr $ra               ;vuelvo al programa principal
```
Ejercicio_10
============
```s
.data
    CADENA: .asciiz "CazaAAA"
    VOCALES: .asciiz 'AEIOUaeiou'
    CANT: .word 0
.code
    ; La pila comienza en el tope de la memoria de datos
    DADDI $sp, $0, 0x400            ; bus 10 bits 🡪 2^10 = 1024 = 0x400

    ; Guarda como primer argumento para CONT_VOCALES
    ; la dirección de CADENA

    DADDI $a0, $0, CADENA
    dadd $v0, $0, $0  
    JAL CONT_VOCALES
    sd $v0, CANT($0)                  ; Cantidad de caracteres
HALT

CONT_VOCALES: DADDI $sp, $sp, -16     ; Reserva lugar en pila -> 2 x 8
    SD $ra, 0 ($sp)                   ; Guarda en pila $ra
    SD $s0, 8 ($sp)                   ; Guarda en pila $s0

    DADD $s0, $a0, $0                 ; Copia la dirección de inicio de la CADENA
    LOOP: LBU $a0, 0 ($s0)	        ; Toma car. actual
        BEQ $a0, $zero, FIN         ; Si es el fin, termina
        JAL ES_VOCAL
        DADDI $s0, $s0, 1           ; Avanza al siguiente caracter
    J LOOP

    ; Recupera los datos salvados en la pila
    FIN: LD $ra, 0 ($sp)
        LD $s0, 8 ($sp)
        DADDI $sp, $sp, 16
    JR $ra




ES_VOCAL: daddi $t0, $0, 0                    ; inicializo t0
    LOOP2: lbu $t1, VOCALES($t0)     ; copia el  caracter en t1
        beqz $t1, FINVOCAL         ; si t1 = 0, no se encontro VOCALES
        beq $a0, $t1, ENCONTRO      ; si LETRA = caracterActual, salto
        daddi $t0, $t0, 1           ; continuo con el siguiente caracter
    j LOOP2

    ENCONTRO: daddi $v0, $v0, 1      ; si es vocal, aumento 1 el contador
    FINVOCAL: jr $ra               ;vuelvo al programa principal             

```
Ejercicio_11
============
```s
.data
    TABLA: .word 1,2,3,4,5,0
    IMPARES: .word 0
    MASCARA: .byte 00000001
.code
    DADDI $sp, $0, 0x400
    DADDI $a0, $0, TABLA
    DADD $v0, $0, $0 
    
    JAL CONT_IMPAR
    sd $v0,IMPARES($0)
HALT

CONT_IMPAR: DADDI $sp, $sp, -16     
    SD $ra, 0 ($sp)                  
    SD $s0, 8 ($sp)
    DADD $s0, $a0, $0  
    
    LOOP: LD $a0, 0 ($s0)	        ; Toma nro. actual
        BEQ $a0, $0, FIN            ; Si es el fin, termina
        JAL ESIMPAR
        dadd $v0,$v0,$v1
        DADDI $s0, $s0, 8           ; Avanza al siguiente nro
    J LOOP

    FIN: LD $ra, 0 ($sp)
        LD $s0, 8 ($sp)
        DADDI $sp, $sp, 16
        JR $ra

ESIMPAR: LD $s1,MASCARA($0)      ;inicializo la mascara(como constante)
    AND $t1, $a0, $s1            ;valor actual and mascara
    BEQZ $t1 ,PAR 
    DADDI $v1,$0, 1
    J TERMINO
    PAR: DADDI $v1, $0, 0     
    TERMINO: JR $ra         
```
Ejercicio_12
============
```s
.data
    NRO: .word 10
    RESULTADO: .word 0
.code
    daddi $sp, $0, 0x400    ; Inicializa el puntero al tope de la pila
    ld $a0, NRO($0)         ; a0 = NRO
    jal FACTORIAL           ; Llamo a la subrutina
    sd $v0, RESULTADO($0)   ; Guardo el dato
halt

 
FACTORIAL: daddi $sp, $sp, -16      ; PUSH
    sd $ra, 0($sp)
    sd $s0, 8($sp)

    beqz $a0, FIN_RECURSIVO         ; Si nro - 1 = 0, termino
    dadd $s0, $0, $a0               ; Tomo el valor actual    
    daddi $a0, $a0, -1              ; nro = nro - 1

    jal FACTORIAL                   ; RECURSIVO
    dmul $v0, $v0, $s0              ; v0 * nro actual
    j FIN                           ; termino

    FIN_RECURSIVO: daddi $v0, $0, 1

    FIN: ld $s0, 8($sp)             ; POP
        ld $ra, 0($sp)
        daddi $sp, $sp, 16
    jr $ra 
```

<h1 align="center"> 💻Practica 6</h1>

<h1 align="center"> Procesador RISC: utilizando la E/S</h1>

```1)``` El siguiente programa produce la salida de un mensaje predefinido en la ventana Terminal del simulador WinMIPS64. [Resolución](#Ejercicio_1)

Teniendo en cuenta las condiciones de control del puerto de E/S (en el resumen anterior), modifique el programa de modo que el mensaje a mostrar sea ingresado por teclado en lugar de ser un mensaje fijo.

```s
.data
    texto: .asciiz "Hola, Mundo!" ; El mensaje a mostrar
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
.text
    lwu $s0, DATA($zero)        ; $s0 = dirección de DATA
    daddi $t0, $zero, texto     ; $t0 = dirección del mensaje a mostrar
    sd $t0, 0($s0)              ; DATA recibe el puntero al comienzo del mensaje
    lwu $s1, CONTROL($zero)     ; $s1 = dirección de CONTROL
    daddi $t0, $zero, 6         ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
    sd $t0, 0($s1)              ; CONTROL recibe 6 y limpia la pantalla
    daddi $t0, $zero, 4         ; $t0 = 4 -> función 4: salida de una cadena ASCII
    sd $t0, 0($s1)              ; CONTROL recibe 4 y produce la salida del mensaje
    halt
```

```2)``` Escriba un programa que utilice sucesivamente dos subrutinas: La primera, denominada ***ingreso***, debe solicitar el ingreso por teclado de un número entero (de un dígito), verificando que el valor ingresado realmente sea un dígito. La segunda, denominada ***muestra***, deberá mostrar en la salida estándar del simulador (ventana Terminal) el valor del número ingresado expresado en letras (es decir, si se ingresa un ***‘4’***, deberá mostrar ‘CUATRO’). Establezca el pasaje de parámetros entre subrutinas respetando las convenciones para el uso de los registros y minimice las detenciones del cauce (ejercicio similar al ejercicio 6 de Práctica 2). [Resolución](#Ejercicio_2)

```3)``` Escriba un programa que realice la suma de dos números enteros (de un dígito cada uno) utilizando dos subrutinas: La denominada ***ingreso*** del ejercicio anterior (ingreso por teclado de un dígito numérico) y otra denominada ***resultado***, que muestre en la salida estándar del simulador (ventana Terminal) el resultado numérico de la suma de los dos números ingresados (ejercicio similar al ejercicio 7 de Práctica 2). [Resolución](#Ejercicio_3)

```4)``` Escriba un programa que solicite el ingreso por teclado de una clave (sucesión de cuatro caracteres) utilizando la subrutina ***char*** de ingreso de un carácter. Luego, debe comparar la secuencia ingresada con una cadena almacenada en la variable ***clave***. Si las dos cadenas son iguales entre si, la subrutina llamada ***respuesta*** mostrará el texto ***“Bienvenido”*** en la salida estándar del simulador (ventana Terminal). En cambio, si las cadenas no son iguales, la subrutina deberá mostrar ***“ERROR”*** y solicitar nuevamente el ingreso de la clave. [Resolución](#Ejercicio_4)


```5)``` Escriba un programa que calcule el resultado de elevar un valor en punto flotante a la potencia indicada por un exponente que es un número entero positivo. Para ello, en el programa principal se solicitará el ingreso de la base (un número en punto flotante) y del exponente (un número entero sin signo) y se deberá utilizar la subrutina ***a_la_potencia*** para calcular el resultado pedido (que será un valor en punto flotante). Tenga en cuenta que cualquier base elevada a la 0 da como resultado 1. Muestre el resultado numérico de la operación en la salida estándar del simulador (ventana Terminal). [Resolución](#Ejercicio_5)

```6)``` El siguiente programa produce una salida estableciendo el color de un punto de la pantalla gráfica (en la ventana Terminal del simulador WinMIPS64). Modifique el programa de modo que las coordenadas y color del punto sean ingresados por teclado. [Resolución](#Ejercicio_6)

```s
data
    coorX: .byte 24                 ; coordenada X de un punto
    coorY: .byte 24                 ; coordenada Y de un punto
    color: .byte 255, 0, 255, 0     ; color: máximo rojo + máximo azul => magenta
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
.text
    lwu $s6, CONTROL($zero)         ; $s6 = dirección de CONTROL
    lwu $s7, DATA($zero)            ; $s7 = dirección de DATA
    daddi $t0, $zero, 7             ; $t0 = 7 -> función 7: limpiar pantalla gráfica
    sd $t0, 0($s6)                  ; CONTROL recibe 7 y limpia la pantalla gráfica
    lbu $s0, coorX($zero)           ; $s0 = valor de coordenada X
    sb $s0, 5($s7)                  ; DATA+5 recibe el valor de coordenada X
    lbu $s1, coorY($zero)           ; $s1 = valor de coordenada Y
    sb $s1, 4($s7)                  ; DATA+4 recibe el valor de coordenada Y
    lwu $s2, color($zero)           ; $s2 = valor de color a pintar
    sw $s2, 0($s7)                  ; DATA recibe el valor del color a pintar
    daddi $t0, $zero, 5             ; $t0 = 5 -> función 5: salida gráfica
    sd $t0, 0($s6)                  ; CONTROL recibe 5 y produce el dibujo del punto
    halt
```

```7)``` Se desea realizar la demostración de la transformación de un carácter codificado en ASCII a su visualización en una matriz de puntos con 7 columnas y 9 filas. Escriba un programa que realice tal demostración, solicitando el ingreso por teclado de un carácter para luego mostrarlo en la pantalla gráfica de la terminal. [Resolución](#Ejercicio_7)

El "8" se representa como: 

![image](https://user-images.githubusercontent.com/55964635/141034358-d29c5f5e-4f04-480c-8885-0219aca8140a.png)

```8)``` El siguiente programa implementa una animación de una pelotita rebotando por la pantalla. Modifíquelo para que en lugar de una pelotita, se muestren simultáneamente varias pelotitas (cinco, por ejemplo), cada una con su posición, dirección y color particular. [Resolución](#Ejercicio_8)

```s
.data
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
    color_pelota: .word32 0x00FF0000        ; Azul
    color_fondo: .word32 0x00FFFFFF         ; Blanco
.text
    lwu $s6, CONTROL($zero)
    lwu $s7, DATA($zero)
    lwu $v0, color_pelota($zero)
    lwu $v1, color_fondo($zero)
    daddi $s0, $zero, 23                    ; Coordenada X de la pelota
    daddi $s1, $zero, 1                     ; Coordenada Y de la pelota
    daddi $s2, $zero, 1                     ; Dirección X de la pelota
    daddi $s3, $zero, 1                     ; Dirección Y de la pelota
    daddi $s4, $zero, 5                     ; Comando para dibujar un punto

loop: sw $v1, 0($s7) ; Borra la pelota
    sb $s0, 4($s7)
    sb $s1, 5($s7)
    sd $s4, 0($s6)
    dadd $s0, $s0, $s2                      ;Mueve la pelota en la dirección actual
    dadd $s1, $s1, $s3
    daddi $t1, $zero, 48                    ; Comprueba que la pelota no esté en la columna de más
    slt $t0, $t1, $s0                       ; a la derecha. Si es así, cambia la dirección en X.
    dsll $t0, $t0, 1
    dsub $s2, $s2, $t0
    slt $t0, $t1, $s1                       ; Comprueba que la pelota no esté en la fila de más arriba.
    dsll $t0, $t0, 1                        ; Si es así, cambia la dirección en Y.
    dsub $s3, $s3, $t0
    slti $t0, $s0, 1                        ; Comprueba que la pelota no esté en la columna de más
    dsll $t0, $t0, 1                        ; a la izquierda. Si es así, cambia la dirección en X.
    dadd $s2, $s2, $t0
    slti $t0, $s1, 1                        ; Comprueba que la pelota no esté en la fila de más abajo.
    dsll $t0, $t0, 1                        ; Si es así, cambia la dirección en Y.
    dadd $s3, $s3, $t0
    sw $v0, 0($s7)                          ; Dibuja la pelota.
    sb $s0, 4($s7)
    sb $s1, 5($s7)
    sd $s4, 0($s6)
    daddi $t0, $zero, 500                   ; Hace una demora para que el rebote no sea tan rápido.
demora: daddi $t0, $t0, -1                  ; Esto genera una infinidad de RAW y BTS pero...
    bnez $t0, demora                        ; ¡hay que hacer tiempo igualmente!
    j loop
```

```9)``` Escriba un programa que le permita dibujar en la pantalla gráfica de la terminal. Deberá mostrar un cursor (representado por un punto de un color particular) que pueda desplazarse por la pantalla usando las teclas ‘a’, ‘s’, ‘d’ y ‘w’ para ir a la izquierda, abajo, a la derecha y arriba respectivamente. Usando la barra espaciadora se alternará entre modo desplazamiento (el cursor pasa por arriba de lo dibujado sin alterarlo) y modo dibujo (cada punto por el que el cursor pasa quedará pintado del color seleccionado). Las teclas del ‘1’ al ‘8’ se usarán para elegir uno entre los ocho colores disponibles para pintar. [Resolución](#Ejercicio_9)

```Observaciones: ``` Para poder implementar este programa, se necesitará almacenar en la memoria la imagen completa de la
pantalla gráfica. 

Si cada punto está representado por un byte, se necesitarán 50x50x1 = 2500 bytes. El simulador WinMIPS64 viene configurado para usar un bus de datos de 10 bits, por lo que la memoria disponible estará acotada a 2^10=1024 bytes. Para poder almacenar la imagen, será necesario configurar el simulador para usar un bus de datos de 12 bits, ya que 2^12=4096 bytes, los que si resultarán suficientes. La configuración se logra yendo al menú “Configure -> Architecture” y poniendo “Data Address Bus” en 12 bits en lugar de los 10 bits que trae por defecto.

![image](https://user-images.githubusercontent.com/55964635/141035436-6e5567fe-2165-4925-9c18-b1481c46473c.png)

Ejercicio_1
===========
```s
.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    CARACTER: .byte 0
.code
    LWU $s0, CONTROL($0)
    LWU $s1, DATA($0)
    
    DADDI $s4, $0, 13       ; 13 el ascii del enter pá

    LOOP: DADDI $t1, $0, 9
        SD $t1,0 ($s0)      ; CONTROL = 9

        ; *PRESIONA UNA TECLA*
        ; LA CPU GUARDA EL CARACTER EN DATA

        LBU $t1,0 ($s1)

        ; COMPARO CON EL ENTER
        BEQ $t1, $s4, FIN

        ; GUARDO LA VARIABLE
        SB $t1, CARACTER($0)

        ;TOMO LA DIR DE CARACTER
        DADDI $s3, $0, CARACTER

        ; MANDO DIR DE CARACTER
        SD $s3, 0 ($s1)

        ; IMPRIMIR CARACTER
        DADDI $t1, $0, 4
        SD $t1, 0 ($s0) ; CONTROL 4

        J LOOP
FIN: HALT
```

Ejercicio_2
===========
```s
.data ;leer desde teclado
    CONTROL:      .word 0x10000
    DATA:         .word 0x10008
    MENSAJE:      .asciiz " INGRESE UN CARACTER: "
    MENSAJEMAL:  .asciiz "  EL CARACTER NO ES UN DIGITO. "
    CERO:         .asciiz " CERO  "
    UNO:          .asciiz " UNO   "
    DOS:          .asciiz " DOS   "
    TRES:         .asciiz " TRES  "
    CUATRO:       .asciiz " CUATRO"
    CINCO:        .asciiz " CINCO "
    SEIS:         .asciiz " SEIS  "
    SIETE:        .asciiz " SIETE "
    OCHO:         .asciiz " OCHO  "
    NUEVE:        .asciiz " NUEVE "
    CARACTER: .byte 0
.code
    LWU $s0, CONTROL ($0) 	; $s0 = CONTROL
    LWU $s1, DATA ($0) 	   	; $s1 = DATA
    ;_______________________________    IMPRIME MENSAJE
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)          
    ;_______________________________
    DADDI $sp, $0, 0x400        ; INICIALIZO EL PUNTERO A TOPE DE PILA
    JAL INGRESO
    LD $t0, CARACTER($0) 
    SLTI $t1, $t0, 0x30         ; un 1 si es menor
    DADDI $t3, $t3, 0x39
    SLT $t1, $t3,  $t0         ; un 1 si me paso
    DADDI $t4, $t4 ,1
    BEQ $t1, $t4 , MALO
    
    DADDI $a1, $0, CERO
    JAL MUESTRA
    J TERMINO
    
    
    
    MALO: DADDI $t0, $0, MENSAJEMAL  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)   

    TERMINO: HALT


INGRESO: DADDI $sp, $sp, -8 
    SD $t7, 0 ($sp)
    ;______________________________
    DADDI $t1, $0, 9   ; LEE UN CARACTER
    SD $t1,0 ($s0)
    LBU $t1,0 ($s1)
    SB $t1, CARACTER($0)
    ; IMPRIME
    DADDI $s3, $0, CARACTER
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 
    ;_______________________________  LEE E IMPRIME EL CARACTER
    LD $t7, 0 ($sp)
    DADDI $sp, $sp, 8  
    JR $ra

MUESTRA:  daddi $t7,$0,0x30
    LOOP: BEQ $t0, $t7, IMPRIMIR
        DADDI $t0, $t0, -1
        DADDI $a1, $a1, 8
        J LOOP

    IMPRIMIR:  SD $a1, 0($s1)        
    DADDI $t1, $0, 4        
    SD $t1, 0($s0)    
JR $ra
```
Ejercicio_3
===========
```s
.data ;leer desde teclado
    CONTROL:      .word 0x10000
    DATA:         .word 0x10008
    MENSAJE:      .asciiz "INGRESE UN NRO: "
    MENSAJE2:     .asciiz "EL RESULTADO ES: "
    RES: .word 0
    NRO: .byte 0
.code
    LWU $s0, CONTROL ($0) 	; $s0 = CONTROL
    LWU $s1, DATA ($0) 	   	; $s1 = DATA
    ;_______________________________    IMPRIME MENSAJE
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)          
    ;_______________________________
    DADDI $sp, $0, 0x400        ; INICIALIZO EL PUNTERO A TOPE DE PILA

    JAL INGRESO   

    LD $t6, NRO($0)
    

    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0) 
    
    JAL INGRESO   
    LD $t7, NRO($0)
    
    DADD $t6, $t6, $t7
    

    JAL RESULTADO
    HALT


INGRESO: DADDI $sp, $sp, -8 
    SD $t7, 0 ($sp)
    ;______________________________
    DADDI $t1, $0, 8   ; LEE UN NRO
    SD $t1,0 ($s0)
    LBU $t1,0 ($s1)
    SB $t1, NRO($0)
    ; IMPRIME
    DADDI $s3, $0, NRO
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 
    ;_______________________________  LEE E IMPRIME EL NRO
    LD $t7, 0 ($sp)
    DADDI $sp, $sp, 8  
    JR $ra

RESULTADO: DADDI $t0, $0, MENSAJE2  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)    

    DADDI $t6, $t6 , 0x30   ; PARA IMPRIMIR EL ASCII DEL NRO
    SD $t6, RES ($0)  

    DADDI $s3, $0, RES
    SD $s3, 0 ($s1)
    DADDI $t1, $0, 4
    SD $t1, 0 ($s0) 

    JR $ra
```


Ejercicio_4
===========
```s
.data 
    CONTROL:       .word 0x10000
    DATA:          .word 0x10008
    CONTRA:        .asciiz 'VAMOO'
    ERROR:         .asciiz ' ERROR!'
    CORRECTO:      .asciiz ' BIENVENIDO'
    MENSAJE:       .asciiz 'INGRESE UNA CONTRA: '
    CARACTER:      .byte 0
.code
    LWU $s0, CONTROL($0)
    LWU $s1, DATA($0)
    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0) 
    
    DADDI $sp, $0, 0x400
    JAL CHAR
HALT


CHAR: daddi $t6, $0, 0           ;CONTADOR PARA CARACTERES
    LOOP: DADDI $t1, $0, 9
        SD $t1,0 ($s0)      ; CONTROL = 9

        
        ; *PRESIONA UNA TECLA*
        ; LA CPU GUARDA EL CARACTER EN DATA

        LBU $t1,0 ($s1)

        DADD $t7, $0, $t1       ;MANDO MI CARACTER A UN REGISTRO PARA COMPARAR
        ; GUARDO LA VARIABLE
        SB $t1, CARACTER($0)

        ;TOMO LA DIR DE CARACTER
        DADDI $s3, $0, CARACTER

        ; MANDO DIR DE CARACTER
        SD $s3, 0 ($s1)

        lbu $t5, CONTRA($t6)    ;GUARDO EN T5 EL CARACTER ACTUAL DE CONTRA
        beqz $t5, FIN_BIEN           ; INDICA QUE TERMINO LA CONTRA (QUE TERMINO BIEN)
        BNE $t1, $t5, FIN_MAL

        ; IMPRIMIR CARACTER
        DADDI $t1, $0, 4
        SD $t1, 0 ($s0) ; CONTROL 4
        daddi $t6, $t6, 1           ;AVANZO AL SIGUIENTE CARACTER DE MI CONTRA
        J LOOP

        FIN_BIEN: DADDI $t0, $0, CORRECTO  ;IMPRIMO CORRECTO
            SD $t0, 0($s1)        
            DADDI $t0, $0, 4        
            SD $t0, 0($s0)   
            J FIN
        FIN_MAL: DADDI $t0, $0, ERROR  ;IMPRIMO CORRECTO
            SD $t0, 0($s1)        
            DADDI $t0, $0, 4        
            SD $t0, 0($s0)   
            J FIN

    FIN: JR $ra
```
Ejercicio_5
===========
```s
.data ;leer desde teclado
    CONTROL:    .word 0x10000
    DATA:       .word 0x10008
    BASE:       .double 0.0
    EXPONENTE:       .word 0
    MENSAJE:    .asciiz "BASE (FLOTANTE): "
    MENSAJE2:    .asciiz "EXPONENTE (ENTERO): "
    RES: .double 0
    UNO: .double 1.0

.code
    LWU $s0, CONTROL ($zero) 	; $s0 = CONTROL
    LWU $s1, DATA ($zero) 	   	; $s1 = DATA

    DADDI $t0, $0, MENSAJE  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)   

    DADDI $t0, $zero, 8
    SD $t0, 0 ($s0)             ; CONTROL = 8
    L.D f1, 0 ($s1)             ; Tomo número en f1
    S.D f1, BASE ($zero)        ; Guardo en variable

    DADDI $t0, $0, MENSAJE2  
    SD $t0, 0($s1)        
    DADDI $t0, $0, 4        
    SD $t0, 0($s0)   

    DADDI $t0, $zero, 8
    SD $t0, 0 ($s0)                 ; CONTROL = 8
    LD $t1, 0 ($s1)                 ; Tomo número en t0
    SD $t1, EXPONENTE ($zero)       ; Guardo en variable

    JAL POTENCIA
    S.D f2, RES($0)
  
    S.D f2, 0 ($s1)
    ; Control 3
    DADDI $t0, $0, 3
    SD $t0, 0 ($s0)               
HALT

POTENCIA: L.D f2, UNO($0)
    LOOP: BEQZ $t1, FIN
        mul.d f2, f2, f1
        DADDI $t1, $t1, -1    
    J LOOP

    FIN: jr $ra
```

Ejercicio_6
===========
```s
.data
    coorX:      .byte 0
    coorY:      .byte 0
    color:      .byte 0, 0, 0, 0; 
    CONTROL:    .word32 0x10000
    DATA:       .word32 0x10008
    MENSAJE1:   .asciiz "INGRESE X: "
    MENSAJE2:   .asciiz "INGRESE Y: "
    MENSAJE3:   .asciiz "INGRESE (R,G,B,TRANSPARENCIA) : "

.code
    LWU $s6, CONTROL($zero)
    LWU $s7, DATA($zero)
    ;__________________________________
    DADDI $t0, $0, MENSAJE1 
    SD $t0, 0 ($s7) 
    DADDI $t1, $0, 4 
    SD $t1, 0 ($s6) 

    DADDI $t1, $0, 8
    SB $t1, 0($s6) 
    LBU $t2, 0($s7) 
    SB $t2, coorX($0)
    ;__________________________________    
    DADDI $t0, $0, MENSAJE2 
    SD $t0, 0 ($s7) 
    DADDI $t1, $0, 4 
    SD $t1, 0 ($s6) 
    
    DADDI $t1, $0, 8
    SB $t1, 0($s6) 
    LBU $t3, 0($s7) 
    SB $t3, coorY($0)
    ;__________________________________
    DADDI $t0, $0, MENSAJE3
    SD $t0, 0 ($s7)
    DADDI $t1, $0, 4 
    SD $t1, 0 ($s6)

    DADDI $a0, $0, 0    ;CONTADORES PARA LEER
    DADDI $a1, $0, 3
    
    LOOP: DADDI $t1, $0, 8
        SB $t1, 0($s6) 
        LBU $t3, 0($s7) 
        SB $t3, color($a0)
        DADDI $a0, $a0, 1   ;AVANZO AL SIGUIENTE BYTE
    bne $a0, $a1 ,LOOP
    ;__________________________________
    DADDI $t0, $zero, 7
    SD $t0, 0($s6)
    
    LBU $s0, coorX($zero)
    SB $s0, 5($s7)

    LBU $s1, coorY($zero)
    SB $s1, 4($s7)

    LWU $s2, color($zero)
    sw $s2, 0($s7)
    
    DADDI $t0, $zero, 5
    SD $t0, 0($s6)         
HALT
```
Ejercicio_7
===========

Ejercicio_8
===========
```s
.data
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
    fondo: .word32 0x00FFFFFF   ; Blanco

    pelota1: .word32 0x00FF0000 ; Azul
             .byte 23           ; Pos X
             .byte 1            ; Pos Y
             .word 1            ; Direccion X
             .word 1            ; Direccion Y
    pelota2: .word32 0x0000FF00
             .byte 27           ; Pos X
             .byte 21           ; Pos Y
             .word -1           ; Direccion X
             .word -1           ; Direccion Y
    pelota3: .word32 0x000000FF
             .byte 1            ; Pos X
             .byte 5            ; Pos Y
             .word 1            ; Direccion X
             .word 1            ; Direccion Y
    pelota4: .word32 0x00FF00FF
             .byte 35           ; Pos X
             .byte 35           ; Pos Y
             .word -1           ; Direccion X
             .word 1            ; Direccion Y
    pelota5: .word32 0x00FFFF00
             .byte 1            ; Pos X
             .byte 35           ; Pos Y
             .word 1            ; Direccion X
             .word 1            ; Direccion Y
    pelota6: .word32 0x0000FFFF
             .byte 35           ; Pos X
             .byte 1            ; Pos Y
             .word -1           ; Direccion X
             .word 1            ; Direccion Y
 .code
    daddi $sp, $0, 0x400
    loop: daddi $a0, $zero, pelota1
        jal mostrar
        daddi $a0, $zero, pelota2
        jal mostrar
        daddi $a0, $zero, pelota3
        jal mostrar
        daddi $a0, $zero, pelota4
        jal mostrar
        daddi $a0, $zero, pelota5
        jal mostrar
        daddi $a0, $zero, pelota6
        jal mostrar
        daddi $t0, $0, 500              ; Hace una demora para que el rebote no sea tan rápido.
        demora: daddi $t0, $t0, -1      ; Esto genera una infinidad de RAW y BTS pero...
        bnez $t0, demora                ; hay que hacer tiempo igualmente!
 j loop

;__________________________________
mostrar: daddi $sp, $sp, -16
    sd $s0, 0($sp)
    sd $s1, 8($sp)
    lwu $s0, CONTROL($0)
    lwu $s1, DATA($0)
    lwu $t0, fondo($zero)       ; Recupero fondo
    lwu $t1, 0($a0)             ; Recupero color
    lbu $t2, 8($a0)             ; Recupero Coordenada X de la pelota
    lbu $t3, 16($a0)            ; Recupero Coordenada Y de la pelota
    ld $t4, 24($a0)             ; Recupero Dirección X de la pelota
    ld $t5, 32($a0)             ; Recupero Dirección Y de la pelota
    daddi $t6, $0, 5            ; Comando para dibujar un punto
    
    ; Borra la pelota
    sw $t0, 0($s1)          ; Color de Fondo
    sb $t2, 4($s1)          ; Pos X
    sb $t3, 5($s1)          ; Pos Y
    sd $t6, 0($s0)          ; Dibujar
    dadd $t2, $t2, $t4      ; Mueve la pelota en la dirección actual
    dadd $t3, $t3, $t5
    daddi $t7, $0, 48       ; Comprueba que la pelota no está en la columna de más
    slt $t8, $t7, $t2       ; a la derecha. Si es así, cambia la dirección en X.
    dsll $t8, $t8, 1
    dsub $t4, $t4, $t8
    slt $t8, $t7, $t3       ; Comprueba que la pelota no está en la fila
    ; de más arriba.
    dsll $t8, $t8, 1        ; Si es así, cambia la dirección en Y.
    dsub $t5, $t5, $t8
    slti $t8, $t2, 1        ; Comprueba que la pelota no está en la columna de más
    dsll $t8, $t8, 1        ; a la izquierda. Si es así, cambia la dirección en X.
    dadd $t4, $t4, $t8
    slti $t8, $t3, 1        ; Comprueba que la pelota no está en la fila de más
    dsll $t8, $t8, 1        ; abajo. Si es así, cambia la dirección en Y.
    dadd $t5, $t5, $t8

    sw $t1, 0($s1)          ; Dibuja la pelota.
    sb $t2, 4($s1)
    sb $t3, 5($s1)
    sd $t6, 0($s0)

    sb $t2, 8($a0)          ; Guardo Coordenada X de la pelota
    sb $t3, 16($a0)         ; Guardo Coordenada Y de la pelota
    sd $t4, 24($a0)         ; Guardo Dirección X de la pelota
    sd $t5, 32($a0)         ; Guardo Dirección Y de la pelota
    ld $s0, 0($sp)
    ld $s1, 8($sp)
    daddi $sp, $sp, 16
    jr $ra
```

Ejercicio_9
===========
```s
.data
        CONTROL: .word32  0x10000
        DATA:    .word32  0x10008
        MENU:    .asciiz "  Reset    (0)\n  NEGRO    (1)\n  AZUL     (2)\n  VERDE    (3)\n  CYAN     (4)\n  ROJO     (5)\n  VIOLETA  (6)\n  AMARILLO (7)\n  BLANCO   (8)\n  ACTUAL: "

        NEGRO:          .byte    0,  0,  0,  0     
        AZUL:           .byte    0,  0,  255,0     
        VERDE:          .byte    0,  255,0,  0     
        CYAN:           .byte    0,  255,255,0     
        ROJO:           .byte    255,0,  0,  0     
        VIOLETA:        .byte    255,0,  255,0   
        AMARILLO:       .byte    255,255,0,  0     
        BLANCO:         .byte    255,255,255,0     
        GRIS:           .byte    150,150,150,0    
                                
        NEGROCAR:       .asciiz  "NEGRO"          
        AZULCAR:        .asciiz  "AZUL"            
        VERDECAR:       .asciiz  "VERDE"          
        CYANCAR:        .asciiz  "CYAN"            
        ROJOCAR:        .asciiz  "ROJO"            
        VIOLETACAR:     .asciiz  "VIOLETA"         
        AMARILLOCAR:    .asciiz  "AMARILLO"         
        BLANCOCAR:      .asciiz  "BLANCO"                                     
        IMAGE:          .space   2500             
        OFF:            .space   1                

.code                      
        DADDI  $sp, $0, 0x400    
        DADDI  $v1, $0, 1         
        DADDI  $s1, $0, 5          
        DADDI  $s2, $0, 7         
        DADDI  $s3, $0, 9         
        DADDI  $s4, $0, 50       ;LIMITE     
        DADDI  $s0, $0, GRIS      
        DADDI  $s5, $0, NEGRO  

        DADDI  $s6, $0, 24         
        DADDI  $s7, $0, 24        
        DADDI  $t2, $0, 24         
        DADDI  $t3, $0, 24         

        LWU    $t8, DATA($0)       
        LWU    $t9, CONTROL($0)    

LIMPIAR: DADDI  $t0, $0, IMAGE      
         DADDI  $t1, $0, OFF        
         DADDI  $t3, $0, BLANCO      
INICIAR: SB     $t3, 0($t0)         
         DADDI  $t0, $t0, 1        
         BNE    $t0, $t1, INICIAR   

         JAL    IMPRIMIRMENU            
LEER:    JAL    DIBUJARPIXEL             
         JAL    DIBUJARESQUINA             
         SD     $s3, 0($t9)         
         LB     $t0, 0($t8)         
;____________________________________________________________
ARRIBA: DADDI  $v0, $0, 0x57                            ; W
        BNE    $t0, $v0, ARRIBA2       
        J MAXARRIBA             

ARRIBA2: DADDI  $v0, $0, 0x77                           ; w
         BNE    $t0, $v0, DERECHA       
         J MAXARRIBA             

DERECHA: DADDI  $v0, $0, 0x44                           ; D
         BNE    $t0, $v0, DERECHA2       
         J MAXDERECHA             

DERECHA2: DADDI  $v0, $0, 0x64                          ; d
          BNE $t0, $v0, IZQUIERDA       
          J MAXDERECHA             

IZQUIERDA: DADDI  $v0, $0, 0x41                         ; A
           BNE $t0, $v0, IZQUIERDA2       
           J MAXIZQUIRDA             

IZQUIERDA2: DADDI  $v0, $0, 0x61                        ; a
            BNE    $t0, $v0, ABAJO       
            J MAXIZQUIRDA             

ABAJO: DADDI  $v0, $0, 0x53                             ; S
       BNE    $t0, $v0, ABAJO2       
       J MAXABAJO              

ABAJO2: DADDI  $v0, $0, 0x73                            ; s
        BNE    $t0, $v0, ESPACIO     
        J MAXABAJO             
;____________________________________________________________
ESPACIO: DADDI  $v0, $0, 0x20                   ; ESPACIO
         BNE    $t0, $v0, REINICIAR             ; t0 <> 
         BEQ    $v1, $0, CONCEDIDO       
DENEGAR: DADDI  $v1, $0, 0          
         J LEER                
CONCEDIDO: DADDI  $v1, $0, 1          
           J LEER               

REINICIAR: DADDI  $v0, $0, 0x30                 ; 0
           BNE    $t0, $v0, CONEGRO   
           DADDI  $t0, $0, 7          
           SD     $t0, 0($t9)        
           DADDI  $v1, $0, 1          
           J LIMPIAR             
;____________________________________________________________COLORES
CONEGRO: DADDI  $v0, $0, 0x31                   ; 1
         BNE    $t0, $v0, COAZUL     
         DADDI  $s5, $0, NEGRO       
         JAL IMPRIMIRMENU            
         J LEER                

COAZUL: DADDI  $v0, $0, 0x32                    ; 2       
        BNE    $t0, $v0, COVERDE     
        DADDI  $s5, $0, AZUL       
        JAL IMPRIMIRMENU             
        J LEER                

COVERDE: DADDI  $v0, $0, 0x33                   ; 3
         BNE    $t0, $v0, COCYAN     
         DADDI  $s5, $0, VERDE       
         JAL    IMPRIMIRMENU             
         J LEER                

COCYAN: DADDI  $v0, $0, 0x34                    ; 4
        BNE    $t0, $v0, COROJO     
        DADDI  $s5, $0, CYAN       
        JAL    IMPRIMIRMENU            
        J LEER                

COROJO: DADDI  $v0, $0, 0x35                    ; 5
        BNE    $t0, $v0, COVIOLETA    
        DADDI  $s5, $0, ROJO       
        JAL    IMPRIMIRMENU             
        J LEER                

COVIOLETA: DADDI  $v0, $0, 0x36                 ; 6
           BNE    $t0, $v0, COAMARILLO     
           DADDI  $s5, $0, VIOLETA       
           JAL    IMPRIMIRMENU             
           J LEER                

COAMARILLO: DADDI  $v0, $0, 0x37                ; 7
            BNE    $t0, $v0, COBLANCO     
            DADDI  $s5, $0, AMARILLO       
            JAL    IMPRIMIRMENU             
            J LEER                

COBLANCO: DADDI  $v0, $0, 0x38                  ; 8
          BNE    $t0, $v0, LEER      
          DADDI  $s5, $0, BLANCO       
          JAL    IMPRIMIRMENU             
          J LEER               
;____________________________________________________________
MAXARRIBA: BEQ    $s7, $s4, LEER      
           DADD   $t2, $s6, $0        
           DADD   $t3, $s7, $0        
           DADDI  $s7, $s7, 1         
           J LEER                

MAXDERECHA: BEQ    $s6, $s4, LEER      
            DADD   $t2, $s6, $0        
            DADD   $t3, $s7, $0        
            DADDI  $s6, $s6, 1         
         J LEER                


MAXABAJO:  BEQZ   $s7, LEER          
         DADD   $t2, $s6, $0        
         DADD   $t3, $s7, $0        
         DADDI  $s7, $s7, -1        
         J      LEER               

MAXIZQUIRDA: BEQZ   $s6, LEER           
         DADD   $t2, $s6, $0        
         DADD   $t3, $s7, $0        
         DADDI  $s6, $s6, -1        
         J      LEER                
;____________________________________________________________
DIBUJARPIXEL: BNEZ   $v1, PINCEL  ; SI = 1 , VOY A PINCEL      
              LBU    $t0, 0($s5)         
              SB     $t2, 5($t8)         
              SB     $t3, 4($t8)         
              DADDI  $t0, $t0, -8        
              LWU    $t0, 0($s0)        
              SW     $t0, 0($t8)        
              SD     $t1, 0($t9)        
              JR     $ra         
                 
PINCEL: DMUL   $t0, $t2, $s4       
        SB     $t2, 5($t8)         
        SB     $t3, 4($t8)        
        DADD   $t0, $t0, $t3       
        DADDI  $t0, $t0, IMAGE     
        LBU    $t0, 0($t0)         
        DADDI  $t0, $t0, -8        
        LWU    $t0, 0($t0)         
        SW     $t0, 0($t8)         
        SD     $s1, 0($t9)         
        JR     $ra                

DIBUJARESQUINA: SB     $s6, 5($t8)        
                SB     $s7, 4($t8)         
                BEQZ   $v1, COPINCEL        
                DADDI  $t0, $0, CYAN            ; QUE COLOR DE TROLO
                J      COCURSOR  
                           
COPINCEL: DMUL   $t1, $s6, $s4       
          DADD   $t0, $0, $s5        
          DADD   $t1, $t1, $s7       
          DADDI  $t1, $t1, IMAGE     
          SB     $s5, 0($t1)    

COCURSOR: DADDI  $t0, $t0, -8        
          LWU    $t0, 0($t0)         
          SW     $t0, 0($t8)         
          SD     $s1, 0($t9)         
          JR     $ra                 

IMPRIMIRMENU: DADDI  $t0, $0, 6          
              SD     $t0, 0($t9)         
              DADDI  $t0, $0, MENU       
              SD     $t0, 0($t8)         
              DADDI  $t0, $0, 4          
              SD     $t0, 0($t9)         
              DADD   $t0, $0, $s5        
              DADDI  $t0, $t0, 64       
              SD     $t0, 0($t8)         
              DADDI  $t0, $0, 4          
              SD     $t0, 0($t9)         
              JR     $ra                 
```
