.data ;leer desde teclado
    CONTROL:      .word 0x10000
    DATA:         .word 0x10008
    ;MENSAJE1:     .asciiz "INGRESE UN CARACTER: "
    MENSAJE_MAL:  .asciiz "EL CARACTER NO ES UN DIGITO. "
    CERO:         .asciiz "CERO  "
    UNO:          .asciiz "UNO   "
    DOS:          .asciiz "DOS   "
    TRES:         .asciiz "TRES  "
    CUATRO:       .asciiz "CUATRO"
    CINCO:        .asciiz "CINCO "
    SEIS:         .asciiz "SEIS  "
    SIETE:        .asciiz "SIETE "
    OCHO:         .asciiz "OCHO  "
    NUEVE:        .asciiz "NUEVE "
    NUM:          .word 0.0
    INVALIDO:     .word 0xff

.code
    LWU $s0, CONTROL ($0) 	; $s0 = CONTROL
    LWU $s1, DATA ($0) 	   	; $s1 = DATA
    DADDI $sp, $0, 0x400
    dadd $v0, $0, $0 
    
    JAL MENSAJE1

HALT

MENSAJE1: DADDI $t0, $0, 9
    SD $t0, 0 ($s0)             ; CONTROL = 8
    LD $t2, 0 ($s1)             ; Tomo número en NRO1
    DADDI $t7, $t7,0x30
    SLT $t3, $t2 ,$t7           ; comparo con 0
    LD $t4, 1($0)               ; t4 = 1 si el nro no esta en el rango
    BNE $t3,$t4, VALIDO
    LD $t2, INVALIDO ($0) 
    J FIN
    VALIDO: SD $t2, NUM ($0)            ; Guardo en variable
    FIN: JR $ra

