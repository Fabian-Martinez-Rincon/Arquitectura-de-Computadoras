ORG 1000H
CERO DB "CERO " 
 DB "UNO " 
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
 MOV CL, 0 ; Contador de veces que ingresa el valor 0 de forma consecutiva
 OTRO: MOV BX, OFFSET MSJ
 MOV AL, OFFSET FIN-OFFSET MSJ
 INT 7 ; Imprimo mensaje en pantalla pidiendo el ingreso de un numero
 MOV BX, OFFSET NUM
 INT 6 ; Leo un caracter y queda guardado en NUM
 CMP NUM, 30H
 JNZ NO_CERO
 INC CL ; Si vino un valor 0, incremento el contador
 JMP SEGUIR
 NO_CERO:MOV CL, 0 ; Como no vino un valor 0, reinicializo CL
 SEGUIR: MOV BX, OFFSET CERO ; La direccion BASE sera la del primer mensaje ("CERO")
 ; Luego se posicionara al inicio del mensaje adecuado
 MOV AL, 6 ; Se va a imprimir 6 caracteres, todos tienen el mismo largo
 LOOP: CMP NUM, 30H
 JZ IMPRIME ; Si es el valor adecuado, imprimo en pantalla el nombre del numero
 ADD BX, 6 ; Si no es el valor adecuado, me posiciono en el siguiente nombre
 DEC NUM ; Al llegar NUM a 0 estara posicionado en el nombre que corresponde
 JMP LOOP
 IMPRIME:INT 7
 CMP CL, 2
 JNZ OTRO ; Si no se ingreso dos veces seguidas el numero 0, sigue procesando
 INT 0 ; Se ingreso dos veces seguidas 0, por lo que el programa termina
END 