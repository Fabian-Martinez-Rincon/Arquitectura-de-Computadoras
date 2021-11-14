.data
control: .word 0x10000
data: .word 0x10008
msj_ingreso: .asciiz "Ingrese un caracter: "
msj_mal: .asciiz "El caracter no es un digito. "
cero: .asciiz "cero  "
uno: .asciiz "uno   "
dos: .asciiz "dos   "
tres: .asciiz "tres  "
cuatro: .asciiz "cuatro"
cinco: .asciiz "cinco "
seis: .asciiz "seis  "
siete: .asciiz "siete "
ocho: .asciiz "ocho  "
nueve: .asciiz "nueve "

.code
    daddi $sp, $0,0x400
    ld $s0, control ($0) #EN $s0 CONTROL
    ld $s1, data ($0) #EN $s1 DATA
    jal ingreso
    halt


#------------------------------
ingreso: daddi $sp, $sp, -8
    sd $ra, 0($sp) 

    daddi $t0, $0, msj_ingreso #EN $t0 LA DIRECCION DEL MSJ QUE PIDE INGRESAR UN CHAR
    sd $t0, 0 ($s1) #PONGO LA ORACION EN DATA
    daddi $t1, $0, 4 
    sd $t1, 0 ($s0) #PONGO UN 4

    #PIDE UN CARACTER
    daddi $t1, $0, 9 
    sb $t1, 0($s0) #PASO EL 9 (LEER CHAR) A CONTROL
    lbu $t2, 0($s1) #CARGO EN $t2 EL VALOR

    #EL CHAR ESTA ALMACENADO EN $t2
    slti $t7, $t2, 0x30 
    bnez $t7, not_char #SI $t7=1 ENTONCES $t2 < 30H , NO ES NUMERO
    slti $t7, $t2, 0x3A 
    beqz $t7, not_char #SI $t7=0 ENTONCES $t2 >= 3AH, NO ES NUMERO
    daddi $a3, $0, cero
    jal muestra 
    j volver

    not_char: daddi $t0, $0, msj_mal #EN $t0 LA DIRECCION DEL MSJ QUE INDICA QUE  NO ES UN NUMERO
    sd $t0, 0 ($s1) #PONGO LA ORACION EN DATA 
    daddi $t1, $0, 4
    sd $t1, 0 ($s0)   

    volver: ld $ra, 0($sp) #PONGO EN $ra LA DIRECCION DE RETORNO DE ESTA SUBRUTINA (ESTABA ALMACENADA EN LA PILA)
    daddi $sp, $sp, 8 #MUEVO EL $sp A LA POSICION QUE LE CORRESPONDE
    jr $ra 

#--------------------------
muestra: daddi $t7,$0,0x30
    loop: beq $t2, $t7, imprimir 
    daddi $t2, $t2, -1 #DECREMENTO EL NUM
    daddi $a3, $a3, 8 #AUMENTO PARA ESTAR PARADO EN LA PROX FRASE
    j loop
    imprimir: sd $a3, 0($s1) #PONGO EN DATA LA ORACION
    daddi $t1, $0, 4 
    sd $t1, 0 ($s0) #PONGO 4 EN CONTROL PARA QUE ME IMPRIMA
    jr $ra