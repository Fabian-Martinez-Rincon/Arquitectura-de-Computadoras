.data
    CONTROL: .word32  0x10000
    DATA:    .word32  0x10008
    MENU:    .asciiz "  Reset    (0)\n  Negro    (1)\n  Azul     (2)\n  Verde    (3)\n  Cyan     (4)\n  Rojo     (5)\n  Magenta  (6)\n  Amarillo (7)\n  Blanco   (8)\n  Actual: "
    ; COLORES
    NEGRO:      .byte    0,     0,   0, 0   
    BLANCO:     .byte    255, 255, 255, 0     
    ROJO:       .byte    255,  0,  0,   0  
    VERDE:      .byte    0,   255,   0, 0        
    AZUL:       .byte    0,     0, 255, 0  
    AMARILLO:   .byte    255, 255,  0,  0 

    CYAN:       .byte    0,   255, 255, 0       
    VIOLETA:    .byte    255,  0, 255,  0     
    GRIS:       .byte    150, 150, 150, 0 

    PANTALLA:   .space 2500     ; RESERVAMOS N BYTES PARA PANTALLA
    ENCENDIDO:  .space 1
    

.code
    LWU $t8, DATA($0)                          
    LWU $t9, CONTROL($0)
    daddi  $fp, $0, 0xff8

    DADDI $s0, $0, 5            ; DIBUJAR EN PANTALLA
    DADDI $s1, $0, 7            ; BORRAR PANTALLA
    DADDI $s3, $0, 9            ; LEER CARACTERES
    DADDI $s4, $0, GRIS         ; COLOR DEL MAUSE
    DADDI $s5, $0, NEGRO        ; COLOR DEL MAUSE POR DEFECTO

    DADDI $s2, $0, 0            ; DIMENSION DE LA PANTALLA


    ;______________________ INICIO EL CURSOR EN EL CENTRO DE LA PANTALLA
    DADDI $s6, $0, 24
    DADDI $s7, $0, 24
    ;______________________

    DADDI $v1, $0, 1            ; PARA ACTIVAR EL PUNTERO

    INICIO: DADDI $t0, $0, PANTALLA
            DADDI $t1, $0, ENCENDIDO
            DADDI $t2, $0, BLANCO   ; INICIA PINTANDO EN BLANCO, PARA NO HACER DESMADRE :D

    CONFIG_INICIO: SB $t2, 0($t0)
                   DADDI $t0, $t0, 1
                   BNE $t0, $t1 , CONFIG_INICIO     
    
          JAL IMPRIMIR_MENU
    LEER: JAL PINTAR
          JAL PINTARCURVA
          SD $s3, 0($t9)
          LB $t0, 0($t8)     ;miro el ascii presionado

    ;______________________HASTA ACA BIEN
    ARRIBA: DADDI $v0, $0, 0x57      ; TECLA W
            BNE $t0, $v0, ARRIBA2
            J MAXIMO_ARRIBA

    ARRIBA2: DADDI $v0, $0, 0x77     ; TECLA w
            BNE $t0, $v0, DERECHA
            J MAXIMO_ARRIBA
    ;______________________
    DERECHA: DADDI $v0, $0, 0x44     ; TECLA D
            BNE $t0, $v0, DERECHA2
            J MAXIMO_DERECHA
    DERECHA2: DADDI $v0, $0, 0x64     ; TECLA d
            BNE $t0, $v0, IZQUIERDA
            J MAXIMO_DERECHA
    ;______________________
    IZQUIERDA: DADDI $v0, $0, 0x41   ; TECLA A
            BNE $t0, $v0, IZQUIERDA2
            J MAXIMOIZQUIERDA
    IZQUIERDA2: DADDI $v0, $0, 0x61   ; TECLA a
            BNE $t0, $v0, ABAJO
            J MAXIMOIZQUIERDA
    ;______________________
    ABAJO: DADDI $v0, $0, 0x53      ; TECLA S
           BNE $t0, $v0, ABAJO2
           J MAXIMOABAJO
    ;______________________
    ABAJO2: DADDI $v0, $0, 0x73     ; TECLA s
            BNE $t0, $v0, ESPACIO
            J MAXIMOABAJO
    ;______________________
    ESPACIO: DADDI $v0, $0, 0x20    ; ESPACIO ASCII
             BNE $t0, $v0 , LIMPIAR
             BEQ $v1, $0, CONFIRMAR
    DENEGAR: DADDI $v1, $0, 0
             J LEER
    CONFIRMAR: DADDI $v1, $0, 1
               J LEER
    ;______________________
    LIMPIAR: DADDI $v0, $0, 0x30    ; 0 - LIMPIAR
             BNE $t0, $v0, COLOR_NEGRO
             DADDI $t0, $0, 7
             SD $t0, 0($t9)
             DADDI $v1, $0, 1
             J INICIO
    ;______________________COLORES
    COLOR_NEGRO: DADDI  $v0, $0, 0x31       
                 BNE    $t0, $v0, COLOR_AZUL     
                 DADDI  $s5, $0, NEGRO       
                 JAL    IMPRIMIR_MENU            
                 J      LEER 
    COLOR_AZUL: DADDI  $v0, $0, 0x32       
                 BNE    $t0, $v0, COLOR_VERDE     
                 DADDI  $s5, $0, AZUL       
                 JAL    IMPRIMIR_MENU            
                 J      LEER 
    COLOR_VERDE: DADDI  $v0, $0, 0x33       
                 BNE    $t0, $v0, COLOR_CYAN     
                 DADDI  $s5, $0, VERDE       
                 JAL    IMPRIMIR_MENU            
                 J      LEER 
    COLOR_CYAN: DADDI  $v0, $0, 0x34       
                 BNE    $t0, $v0, COLOR_ROJO     
                 DADDI  $s5, $0, CYAN       
                 JAL    IMPRIMIR_MENU            
                 J      LEER 
    COLOR_ROJO: DADDI  $v0, $0, 0x35       
                 BNE    $t0, $v0, COLOR_VIOLETA     
                 DADDI  $s5, $0, ROJO       
                 JAL    IMPRIMIR_MENU            
                 J      LEER 
    COLOR_VIOLETA: DADDI  $v0, $0, 0x36       
                 BNE    $t0, $v0, COLOR_AMARILLO     
                 DADDI  $s5, $0, VIOLETA       
                 JAL    IMPRIMIR_MENU            
                 J      LEER 
    COLOR_AMARILLO: DADDI  $v0, $0, 0x37       
                 BNE    $t0, $v0, COLOR_BLANCO 
                 DADDI  $s5, $0, AMARILLO       
                 JAL    IMPRIMIR_MENU            
                 J      LEER 
    COLOR_BLANCO: DADDI  $v0, $0, 0x38       
                 BNE    $t0, $v0, COLOR_AZUL     
                 DADDI  $s5, $0, BLANCO       
                 JAL    IMPRIMIR_MENU            
                 J      LEER 
    ;______________________
    MAXIMO_ARRIBA: BEQ $s7, $s2, LEER      
                   DADD   $t2, $s6, $0        
                   DADD   $t3, $s7, $0        
                   DADDI  $s7, $s7, 1         
                   J LEER  
    MAXIMO_DERECHA: BEQ $s6, $s2, LEER
                    DADD $t2, $s6, $0
                    DADD $t3, $s7, $0
                    DADD $t3, $s7, $0

    MAXIMOABAJO:  BEQZ $s7, LEER           
                   DADD $t2, $s6, $0        
                   DADD $t3, $s7, $0      
                   DADDI $s7, $s7, -1       
                   J LEER 

    MAXIMOIZQUIERDA: BEQZ $s6, LEER           
                      DADD $t2, $s6, $0        
                      DADD $t3, $s7, $0      
                      DADDI $s7, $s7, -1       
                      J LEER 
    ;__________________________________________
    PINTAR: BNEZ   $v1, PINCEL     
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
            DADDI  $t0, $t0, PANTALLA      
            LBU    $t0, 0($t0)         
            DADDI  $t0, $t0, -8        
            LWU    $t0, 0($t0)         
            SW     $t0, 0($t8)         
            SD     $s1, 0($t9)         
    JR     $ra  
    ;__________________________________________
    PINTARCURVA:  SB     $s6, 5($t8)        
                  SB     $s7, 4($t8)         
                  BEQZ   $v1, COLORPINCEL        
                  DADDI  $t0, $0, GRIS       
                  J COLORCURSOR             

    COLORPINCEL:  DMUL   $t1, $s6, $s2       
                  DADD   $t0, $0, $s5        
                  DADD   $t1, $t1, $s7       
                  DADDI  $t1, $t1, PANTALLA     
                  SB     $s5, 0($t1)    

    COLORCURSOR: DADDI  $t0, $t0, -8        
                  LWU    $t0, 0($t0)         
                  SW     $t0, 0($t8)        
                  SD     $s2, 0($t9)         
                  JR     $ra                 

    IMPRIMIR_MENU: DADDI  $t0, $0, 6         
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
