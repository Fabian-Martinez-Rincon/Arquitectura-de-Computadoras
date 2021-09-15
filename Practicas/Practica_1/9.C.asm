; Recibe el caracter a rotar en AH
; Devuelve el resultado también en AH


ORG 3000H
 ROTARIZQ: ADD AH, AH
  ADC AH, 0 ;Suma el carry
  RET

ORG 5000H
ROTARDER_N: MOV CH, 8
 SUB CH, BH ; cantidad de bytes que debo rotar hacia la izq. (8-N)
 MOV BH, CH ; vuelvo a copiar en BH (8-N)
 ; ROTARIZQ usará el valor almacenado en BH para rotar.
 CALL ROTARIZQ_N
 RET

ORG 4000H
 ROTARIZQ_N: CMP BH, 0 ; mientras BH>0
 JZ FIN ; si BH=0, entonces finalizar la subrut.
 CALL ROTARIZQ
 DEC BH
 JMP ROTARIZQ_N ; aprovecho la etiqueta de la subrutina
; para hacer el salto
FIN: RET

ORG 1000H
 b DB 80h ; (10000000) en binario
 
ORG 2000H
 MOV AH, b ; AH = 10000000
 ; Realizamos una rotación
 MOV BH,2
 CALL ROTARDER_N ; AH = 00100000
 
HLT
END

