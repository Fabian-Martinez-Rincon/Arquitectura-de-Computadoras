ORG 1000H
 MSJ DB "INGRESE UN NUMERO "
 FIN DB ?
 
ORG 1500H
 NUM1 DB ?
 NUM2 DB ?
 RES_D DB "0" ; Decena del resultado.
 RES_U DB ? ; Unidad del resultado.
; Por ej. si se suma "6" + "7", la decena del resultado sera 
;"1" y la unidad "3"
ORG 2000H
 MOV BX, OFFSET MSJ
 MOV AL, OFFSET FIN-OFFSET MSJ
 INT 7 ; Imprimo mensaje en pantalla pidiendo el ingreso de un numero
 MOV BX, OFFSET NUM1
 INT 6 ; Leo un caracter y queda guardado en NUM1
 
 MOV BX, OFFSET MSJ
 INT 7 ; Imprimo mensaje en pantalla pidiendo el ingreso de un numero
 MOV BX, OFFSET NUM2
 INT 6 ; Leo un caracter y queda guardado en NUM2
 
 MOV AL, NUM1 ; Copio el segundo caracter leido en AL
 SUB AL, 30H ; Le resto 30H, para quedarme con el valor del numero
 MOV DL, NUM2
 SUB DL, 30H ;Lo mismo que con el primer numero
 CMP AL, DL
 JNS NUM_OK
 
 SUB DL, AL ;La resta seria como hacerla al revez solo que agregando el signo
 MOV AL, DL
 MOV RES_D, 2DH 
 JMP NO_RESTO
 
 NUM_OK: SUB AL,DL
 NO_RESTO: ADD AL, 30H 
 MOV RES_U, AL ; Copio el valor de la unidad a RES_U
 MOV BX, OFFSET RES_D ; A partir de la dir. de RES_D, se imprime 2 caracteres
 MOV AL, 2
 INT 7
 INT 0
END