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
 
 MOV AL, NUM2 ; Copio el segundo caracter leido en AL
 SUB AL, 30H ; Le resto 30H, para quedarme con el valor del numero
 ADD AL, NUM1 ; Le sumo el primer caracter leido
 CMP AL, 3AH ; Si quedo un valor entre 30H y 39H, la suma no supero 9
 ; Entonces la unidad esta lista
 ; Y la decena tambien, ya que comienza con valor "0"
JS NUM_OK
 SUB AL, 10 ; Si quedo un valor mayor a 39H
 ; entonces se le resta 10 para obtener la unidad
 INC RES_D ; Se suma 1 a la decena (pasa de ser el caracter "0" a "1"
 NUM_OK: MOV RES_U, AL ; Copio el valor de la unidad a RES_U
 MOV BX, OFFSET RES_D ; A partir de la dir. de RES_D, se imprime 2 caracteres
 MOV AL, 2
 INT 7
 INT 0
END