PINTAR_CURVA: sb     $s6, 5($t8)        
         sb     $s7, 4($t8)         
         beqz   $v1, COLOR_PINCEL        
         daddi  $t0, r0, gris       
         j      COLOR_CURSOR             
COLOR_PINCEL: dmul   $t1, $s6, $s4       
         dadd   $t0, r0, $s5        
         dadd   $t1, $t1, $s7       
         daddi  $t1, $t1, IMAGE     
         sb     $s5, 0($t1)        
COLOR_CURSOR: daddi  $t0, $t0, -8        
         lwu    $t0, 0($t0)         
         sw     $t0, 0($t8)        
         sd     $s1, 0($t9)         
         jr     $ra                 


IMPRIMIR_MENU: daddi  $t0, r0, 6         
         sd     $t0, 0($t9)         
         daddi  $t0, r0, MENU       
         sd     $t0, 0($t8)         
         daddi  $t0, r0, 4          
         sd     $t0, 0($t9)         
         dadd   $t0, r0, $s5        
         daddi  $t0, $t0, 64        
         sd     $t0, 0($t8)         
         daddi  $t0, r0, 4          
         sd     $t0, 0($t9)         
         jr     $ra     