.data
    X:   .byte 24 ; X
    Y:   .byte 24 ; Y
    color:   .byte 255, 0, 255, 0 
    CONTROL: .word 0x10000
    DATA:    .word 0x10008

.code 
    ld $s0, CONTROL ($0) 		; $s0 = dir de CONTROL
    ld $s1, DATA ($0) 	   		; $s1 = dir de DATA

    ; limpia la pantalla

    daddi $t0, $0, 7			
    sd $t0, 0 ($s0) 				

    lbu $t0, X ($0) 			
    sb $t0, 5 ($s1) 				

    lbu $t1, Y ($0)			; $t1 = valor de coordenada Y
    sb $t1, 4 ($s1) 				; DATA + 4 recibe el valor de coordenada Y
    
    lwu $t2, color ($0)	; $t2 = color
    sw $t2, 0 ($s1) ; Pongo color en DATA
    daddi $t0, $0, 5
    sd $t0, 0 ($s0) ; Pinta el píxel
HALT
