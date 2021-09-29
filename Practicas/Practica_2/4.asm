ORG 1000H
 MENSAJE DB "INGRESE UN NUMERO: "
 FIN DB ?
ORG 1500H
 NUM DB ?
ORG 2000H ;
 MOV BX, OFFSET MENSAJE
 MOV AL, OFFSET FIN-OFFSET MENSAJE
 INT 7
 MOV BX, OFFSET NUM
 INT 6
 MOV AL, 1
 INT 7
 MOV CL, NUM
 INT 0

END
;a) en BX almaceno la direccion del primer caracter del mensaje 
; y en AL indico de que tamaño es la cadena
;b)  Necesita saber la direccion de la variable que voy a leer
;c) Ponemos el al en 1 ya que solo vamos a imprimir un solo digito :D
; Y cl vale 31h que seria el numero ingresado per en hexadecimal