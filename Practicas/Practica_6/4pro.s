.data 
    CONTROL:       .word32 0x10000
    DATA:          .word32 0x10008
    CONTRA:         .asciiz 'VAMOO'
    MSJ_ERROR:     .asciiz 'ERROR!'
    MSJ_WELCOME:   .asciiz 'BIENVENIDO'
.code

    LWU $s0, CONTROL($0)   
    LWU $s1, DATA($0)       
    daddi $sp, $0, 0x400     

    JAL CHAR

HALT

; T1= CONSTANTE;  T0= PUNTERO PARA RECORRER CLAVE Y CONTRA;  T5= LO USO COMO CANT PARA LOOPEAR 4 VECES
; $S1 = DATA;   $S0 = CONTROL

CHAR: daddi $sp, $sp, -8      
        sd $ra, 0($sp)          
        daddi $t1, $0, 9        #$T1 = VALOR PARA EL CONTROL
        daddi $t0, $0, 0        #$T0 = PUNTERO
        daddi $t5, $0, 4        #$T5 = CANT ELEMENTOS
        daddi $a0, $0, 0
; $T3 = LO USO DE AUX PARA ALMACENAR EL CARACTER LEIDO;
loop:   dadd $t3, $0, $t1    
        sd $t3, 0 ($s0)         # Enviamos a Control 9 para leer el Caracter
        lbu $t3, 0 ($s1)           # Tomo el caracter cargado 
        
        lbu $t0, CONTRA($a0)
        beqz $t5, fin
        
        beq $t3, $t0, son_iguales

#                         $T4 = LO USO DE AUX PARA ENVIARLE LA DIRECCION DE ERROR AL DATA

        daddi $t4, $zero, MSJ_ERROR        
        sd $t4, 0($s1)    
        
        JAL respuesta

        daddi $t5, $0, 4
        
        daddi $a0, $0, 0
        
        
        
son_iguales: daddi $t5, $t5, -1
        
             daddi $a0, $a0, 1
             
             beqz $t5, fin
        
        j loop
        
        # COMPARAMOS EL CARACTER 
        
        
        
fin:    daddi $t4, $zero, MSJ_WELCOME
        sd $t4, 0($s1)
        JAL respuesta
        ld $ra, 0($sp)             #DESAPILO LA DIR DE RETORNO
        daddi $sp, $sp, 8
        jr $ra

respuesta:     daddi $t4, $zero, 4            
            sd $t4, 0($s0)    
            jr $ra