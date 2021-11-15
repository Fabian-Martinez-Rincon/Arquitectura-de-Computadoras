.data
        CONTROL: .word32  0x10000
        DATA:    .word32  0x10008
        MENU:    .asciiz "  Reset    (0)\n  NEGRO    (1)\n  AZUL     (2)\n  VERDE    (3)\n  CYAN     (4)\n  ROJO     (5)\n  VIOLETA  (6)\n  AMARILLO (7)\n  BLANCO   (8)\n  ACTUAL: "

        NEGRO:          .byte    0,  0,  0,  0     
        AZUL:           .byte    0,  0,  255,0     
        VERDE:          .byte    0,  255,0,  0     
        CYAN:           .byte    0,  255,255,0     
        ROJO:           .byte    255,0,  0,  0     
        VIOLETA:        .byte    255,0,  255,0   
        AMARILLO:       .byte    255,255,0,  0     
        BLANCO:         .byte    255,255,255,0     
        GRIS:           .byte    150,150,150,0    
                                
        NEGROCAR:       .asciiz  "NEGRO"          
        AZULCAR:        .asciiz  "AZUL"            
        VERDECAR:       .asciiz  "VERDE"          
        CYANCAR:        .asciiz  "CYAN"            
        ROJOCAR:        .asciiz  "ROJO"            
        VIOLETACAR:     .asciiz  "VIOLETA"         
        AMARILLOCAR:    .asciiz  "AMARILLO"         
        BLANCOCAR:      .asciiz  "BLANCO"                                     
        IMAGE:          .space   2500             
        OFF:            .space   1                

.code                      
        DADDI  $sp, $0, 0x400    
        DADDI  $v1, $0, 1         
        DADDI  $s1, $0, 5          
        DADDI  $s2, $0, 7         
        DADDI  $s3, $0, 9         
        DADDI  $s4, $0, 50       ;LIMITE     
        DADDI  $s0, $0, GRIS      
        DADDI  $s5, $0, NEGRO  

        DADDI  $s6, $0, 24         
        DADDI  $s7, $0, 24        
        DADDI  $t2, $0, 24         
        DADDI  $t3, $0, 24         

        LWU    $t8, DATA($0)       
        LWU    $t9, CONTROL($0)    

LIMPIAR: DADDI  $t0, $0, IMAGE      
         DADDI  $t1, $0, OFF        
         DADDI  $t3, $0, BLANCO      
INICIAR: SB     $t3, 0($t0)         
         DADDI  $t0, $t0, 1        
         BNE    $t0, $t1, INICIAR   

         JAL    IMPRIMIRMENU            
LEER:    JAL    DIBUJARPIXEL             
         JAL    DIBUJARESQUINA             
         SD     $s3, 0($t9)         
         LB     $t0, 0($t8)         
;____________________________________________________________
ARRIBA: DADDI  $v0, $0, 0x57                            ; W
        BNE    $t0, $v0, ARRIBA2       
        J MAXARRIBA             

ARRIBA2: DADDI  $v0, $0, 0x77                           ; w
         BNE    $t0, $v0, DERECHA       
         J MAXARRIBA             

DERECHA: DADDI  $v0, $0, 0x44                           ; D
         BNE    $t0, $v0, DERECHA2       
         J MAXDERECHA             

DERECHA2: DADDI  $v0, $0, 0x64                          ; d
          BNE $t0, $v0, IZQUIERDA       
          J MAXDERECHA             

IZQUIERDA: DADDI  $v0, $0, 0x41                         ; A
           BNE $t0, $v0, IZQUIERDA2       
           J MAXIZQUIRDA             

IZQUIERDA2: DADDI  $v0, $0, 0x61                        ; a
            BNE    $t0, $v0, ABAJO       
            J MAXIZQUIRDA             

ABAJO: DADDI  $v0, $0, 0x53                             ; S
       BNE    $t0, $v0, ABAJO2       
       J MAXABAJO              

ABAJO2: DADDI  $v0, $0, 0x73                            ; s
        BNE    $t0, $v0, ESPACIO     
        J MAXABAJO             
;____________________________________________________________
ESPACIO: DADDI  $v0, $0, 0x20                   ; ESPACIO
         BNE    $t0, $v0, REINICIAR             ; t0 <> 
         BEQ    $v1, $0, CONCEDIDO       
DENEGAR: DADDI  $v1, $0, 0          
         J LEER                
CONCEDIDO: DADDI  $v1, $0, 1          
           J LEER               

REINICIAR: DADDI  $v0, $0, 0x30                 ; 0
           BNE    $t0, $v0, CONEGRO   
           DADDI  $t0, $0, 7          
           SD     $t0, 0($t9)        
           DADDI  $v1, $0, 1          
           J LIMPIAR             
;____________________________________________________________COLORES
CONEGRO: DADDI  $v0, $0, 0x31                   ; 1
         BNE    $t0, $v0, COAZUL     
         DADDI  $s5, $0, NEGRO       
         JAL IMPRIMIRMENU            
         J LEER                

COAZUL: DADDI  $v0, $0, 0x32                    ; 2       
        BNE    $t0, $v0, COVERDE     
        DADDI  $s5, $0, AZUL       
        JAL IMPRIMIRMENU             
        J LEER                

COVERDE: DADDI  $v0, $0, 0x33                   ; 3
         BNE    $t0, $v0, COCYAN     
         DADDI  $s5, $0, VERDE       
         JAL    IMPRIMIRMENU             
         J LEER                

COCYAN: DADDI  $v0, $0, 0x34                    ; 4
        BNE    $t0, $v0, COROJO     
        DADDI  $s5, $0, CYAN       
        JAL    IMPRIMIRMENU            
        J LEER                

COROJO: DADDI  $v0, $0, 0x35                    ; 5
        BNE    $t0, $v0, COVIOLETA    
        DADDI  $s5, $0, ROJO       
        JAL    IMPRIMIRMENU             
        J LEER                

COVIOLETA: DADDI  $v0, $0, 0x36                 ; 6
           BNE    $t0, $v0, COAMARILLO     
           DADDI  $s5, $0, VIOLETA       
           JAL    IMPRIMIRMENU             
           J LEER                

COAMARILLO: DADDI  $v0, $0, 0x37                ; 7
            BNE    $t0, $v0, COBLANCO     
            DADDI  $s5, $0, AMARILLO       
            JAL    IMPRIMIRMENU             
            J LEER                

COBLANCO: DADDI  $v0, $0, 0x38                  ; 8
          BNE    $t0, $v0, LEER      
          DADDI  $s5, $0, BLANCO       
          JAL    IMPRIMIRMENU             
          J LEER               
;____________________________________________________________
MAXARRIBA: BEQ    $s7, $s4, LEER      
           DADD   $t2, $s6, $0        
           DADD   $t3, $s7, $0        
           DADDI  $s7, $s7, 1         
           J LEER                

MAXDERECHA: BEQ    $s6, $s4, LEER      
            DADD   $t2, $s6, $0        
            DADD   $t3, $s7, $0        
            DADDI  $s6, $s6, 1         
         J LEER                


MAXABAJO:  BEQZ   $s7, LEER          
         DADD   $t2, $s6, $0        
         DADD   $t3, $s7, $0        
         DADDI  $s7, $s7, -1        
         J      LEER               

MAXIZQUIRDA: BEQZ   $s6, LEER           
         DADD   $t2, $s6, $0        
         DADD   $t3, $s7, $0        
         DADDI  $s6, $s6, -1        
         J      LEER                
;____________________________________________________________
DIBUJARPIXEL: BNEZ   $v1, PINCEL  ; SI = 1 , VOY A PINCEL      
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
        DADDI  $t0, $t0, IMAGE     
        LBU    $t0, 0($t0)         
        DADDI  $t0, $t0, -8        
        LWU    $t0, 0($t0)         
        SW     $t0, 0($t8)         
        SD     $s1, 0($t9)         
        JR     $ra                

DIBUJARESQUINA: SB     $s6, 5($t8)        
                SB     $s7, 4($t8)         
                BEQZ   $v1, COPINCEL        
                DADDI  $t0, $0, CYAN            ; QUE COLOR DE TROLO
                J      COCURSOR  
                           
COPINCEL: DMUL   $t1, $s6, $s4       
          DADD   $t0, $0, $s5        
          DADD   $t1, $t1, $s7       
          DADDI  $t1, $t1, IMAGE     
          SB     $s5, 0($t1)    

COCURSOR: DADDI  $t0, $t0, -8        
          LWU    $t0, 0($t0)         
          SW     $t0, 0($t8)         
          SD     $s1, 0($t9)         
          JR     $ra                 

IMPRIMIRMENU: DADDI  $t0, $0, 6          
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