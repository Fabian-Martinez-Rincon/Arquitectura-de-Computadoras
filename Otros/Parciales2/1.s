.data
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
    tabla1:  .double 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0
    tabla2:  .double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
;___________________________________________________________________
.code
    LD $s0, CONTROL($0)
    LD $s1, DATA($0)
    DADDI $s2, $0, 11       ; CANTIDAD DE ELEMENTOS
    DADDI $s3, $0, tabla1
    DADDI $s4, $0, tabla2
    DADDI $s5, $0, 3        ; IMPRIMIR UN FLOTANTE

    ;ME MUEVO EN LA TABLA
    
    LOOP: L.D F1, 0($s3)    ; ME MUEVO POR TABLA1
          L.D F2, 8($s3) 

          ; MANDO AMBOS NROS A PROMEDIAR
          JAL PROMEDIAR

          ; GUARDO EL RESULTADO DEL PROMEDIO EN TABLA2
          S.D F3, 0 ($s4)       

          ; AVANZO EN LAS TABLAS Y DISMINUYO EL CONTADOR
          DADDI $s2, $s2, -1
          DADDI $s3, $s3, 8
          DADDI $s4, $s4, 8

    BNEZ $s2, LOOP

    DADDI $a0, $0, tabla2  ; MANDO COMO PARAMETRO LA DIRECCION DE TABLA2
    JAL IMPRIMIR

HALT
;___________________________________________________________________
PROMEDIAR: ADD.D F3, F1, F2
    DADDI $t0, $0, 2
    mtc1 $t0, F4
    cvt.d.l F4, F4
    DIV.D F3,F3,F4
JR $ra
;___________________________________________________________________
IMPRIMIR: DADDI $t0, $0, 11  ; CANTIDAD DE ELEMENTOS DE tabla2

    loopImprimir: L.D F1, 0 ($a0)       ; TOMO EL ELEMENTO ACTUAL
        ; MANDO EL DATO A DATA Y EL 3 A CONTROL
        S.D F1, 0 ($s1)
        SD $s5, 0 ($s0)

        ; AVANZO A LA SIGUIENTE POSICION A IMPRIMIR
        DADDI $a0, $a0, 8
        DADDI $t0, $t0, -1
    BNEZ $t0, loopImprimir

JR $ra
;___________________________________________________________________