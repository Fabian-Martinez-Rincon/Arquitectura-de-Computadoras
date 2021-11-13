.data
cadena: .asciiz "Caza"

.code
    ; La pila comienza en el tope de la memoria de datos
    DADDI $sp, $0, 0x400 ; bus 10 bits 🡪 2^10 = 1024 = 0x400

    ; Guarda como primer argumento para upcaseStr
    ; la dirección de cadena
    DADDI $a0, $0, cadena
    JAL upcaseStr
HALT

upcaseStr: DADDI $sp, $sp, -16      ; Reserva lugar en pila -> 2 x 8
    SD $ra, 0 ($sp)                 ; Guarda en pila $ra
    SD $s0, 8 ($sp)                 ; Guarda en pila $s0
    DADD $s0, $a0, $zero            ; Copia la dirección de inicio de la cadena
    LOOP: LBU $a0, 0 ($s0)	        ; Toma car. actual
        BEQ $a0, $zero, FIN         ; Si es el fin, termina
        JAL upcase
        SB $v0, 0 ($s0)             ; Guarda el caracter procesado en la cadena
        DADDI $s0, $s0, 1           ; Avanza al siguiente caracter
    J LOOP
    ; Recupera los datos salvados en la pila
    FIN: 	LD $ra, 0 ($sp)
    LD $s0, 8 ($sp)
    DADDI $sp, $sp, 16
    JR $ra


; Pasa un caracter a mayúscula.
; Parámetros: $a0 -> caracter
; Retorna $v0 -> caracter en mayúscula
; No se utiliza la pila porque no se usan registros que deban ser salvados

upcase: DADD $v0, $a0, $zero
SLTI $t0, $v0, 0x61 ; Compara con ‘a’ minúscula
	BNEZ $t0, salir ; No es un caracter en minúscula
	SLTI $t0, $v0, 0x7B ; Compara con el car sig a 'z' minúscula (z=7AH)
	BEQZ $t0, salir ; No es un caracter en minúscula
	DADDI $v0, $v0, -0x20 ; Pasa a minúscula
salir: JR $ra 	; Retorna
