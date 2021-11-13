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