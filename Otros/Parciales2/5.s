#.data
#    NUMERO1: .word 5
#    NUMERO2: .word -2
#    RES: .word 0
#.code
#    LD $t1, NUMERO1 ($0)     
#    LD $t2, NUMERO2 ($0) 
#    DADDI $t3, $0,0 
#    
#
#    JUMP: DADD $t3, $t3, $t2 
#        DADDI $t1, $t1 , -1
#    BNEZ $t1, JUMP
#
#    SD $t3, RES($0)
#    
#    LD $t3, RES ($0)
#    SD $t0, 0 ($s1)         
#     ; CONTROL = 2
#    DADDI $t0, $0, 2
#    SD $t0, 0 ($s0)   
#HALT

     
         
      
.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    NUM:     .word -2

.code
    LD $s0, CONTROL ($0)    
    LD $s1, DATA ($0)      
    DADDI $s2, $0, 2


    LD $t0, NUM ($0)
    SD $t0, 0 ($s1)     

     ; CONTROL = 2
    SD $s2, 0 ($s0)     ; IMPRIMO EL NUMERO        



HALT
