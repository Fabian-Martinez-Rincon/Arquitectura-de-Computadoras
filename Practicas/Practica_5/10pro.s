.data
VOCALES: .asciiz 'aeiouAEIOU'
CADENA: .asciiz 'RuSoGato'
RESULTADO: .word 0

.code
# Armo los parametros
daddi $a0, $0, CADENA       # $a0 = dir del string a analizar
daddi $t0, $0, RESULTADO    # $t0 = direccion de la variable 'RESULTADO'
dsub $a1, $t0, $a0          # $a1 = cantidad de caracteres que tiene el string (dir de 'RESULTADO' - dir de 'CADENA')

jal CANT_VOCALES               ; Nombre mas caracteristico!
sd $v0, RESULTADO($zero)
halt

CANT_VOCALES: daddi $v0, $0, 0 # Inicializo el valor de retorno (que es la cantidad de VOCALES). Fijate que lo inicializo aca, no en el prog. Principal!
daddi $t4, $0, 10 # Cantidad de VOCALES. Siempre es la misma, por ende esta bien que este aca y no sea un parametro
tomoCaracter: lbu $t2, 0($a0) # Tomo caracter actual. FIJATE que uso el parametro, no el nombre de la variable!!!
    daddi $t1, $0, 0 # $t1 va a servir para iterar por la lista de VOCALES
    loop: lbu $t3, VOCALES($t1) # Esta bien no recibir 'VOCALES' por parametro porque es una variable fija que se usa siempre
      beq $t3, $t2, esVocal # Chequeo si es vocal
      daddi $t1, $t1, 1 # Si no es igual a la vocal actual pruebo con la siguiente vocal
      bneq $t1, $t4, loop # Si todavia no analice todas las VOCALES, continuo iterando por ellas

    esVocal: daddi $v0, $v0, 1 # Contabilizo una vocal mas
    daddi $a0, $a0, 1 # Avanzo al siguiente caracter del string (fijate que estoy usando $a0, no $t0)
    daddi $a1, $a1, -1 # Resto la cantidad de caracteres que falta analizar
    bnez $a1, tomoCaracter # Si todavia quedan caracteres, continuo iterando
jr $ra 