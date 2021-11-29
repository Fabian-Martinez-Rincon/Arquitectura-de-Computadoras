Imprimir Mensaje

```s
daddi $t0, $0, msj3                 	; $t0 = dirección del mensaje a mostrar  
sd $t0, 0($s1) 			      	; DATA recibe el puntero al comienzo del mensaje 

daddi $t0, $0, 4 			; $t0 = 4 -> función 4: salida de una cadena ASCII 
sd $t0, 0($s0) 			        ; CONTROL recibe 4 y produce la salida del mensaje 
```

Imprimir Numero Entero

```s
LD $t0, NUM ($0)
SD $t0, 0 ($s1)         

DADDI $t0, $0, 2
SD $t0, 0 ($s0)      
```

Imprimir Numero Double

```s
L.D f1, NUM ($0)
S.D f1, 0 ($s1)        

DADDI $t0, $0, 3
SD $t0, 0 ($s0) 
```
Imprimir un Pixel
```s
LD $t0, PIXEL ($0)
SD $t0, 0 ($s1)      

DADDI $t0, $0, 5
SD $t0, 0 ($s0)  
```

Leo un caracter y lo guardo

```s
daddi $t0, $0, 9                          ; $t0 = 9 -> función 9: entrada de un caracter
sd $t0, 0($s1)     		            ; CONTROL recibe 9

lbu $s2, 0($s0)                         ; Leo de DATA el caracter           
sb $s2,aux($0)                            ; Lo guardo
```
