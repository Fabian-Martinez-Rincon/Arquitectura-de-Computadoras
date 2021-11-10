data
    valor: .word 10
    result: .word 0
.text
    daddi $sp, $zero, 0x400 ; Inicializa puntero al tope de la pila
    (1)
    ld $a0, valor($zero)
    jal factorial
    sd $v0, result($zero)
    halt
factorial: ...
...
