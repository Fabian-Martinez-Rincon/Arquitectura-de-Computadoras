; Recibe el caracter a rotar en AH
; Recibe la cantidad de posiciones en BH
; Devuelve el resultado también en AH

ORG 4000H
 ROTARIZQ_N: CMP BH, 0 ; mientras BH>0
 JZ FIN ; si BH=0, entonces finalizar la subrut.
 CALL ROTARIZQ
 DEC BH
 JMP ROTARIZQ_N ; aprovecho la etiqueta de la subrutina
; para hacer el salto
FIN: RET
ORG 1000H
 b DB 27H ; (00100111) en binario
ORG 2000H
 MOV AH, b
 ; Realizamos una rotación de 2 posiciones a la izquierda
 MOV BH, 2
 CALL ROTARIZQ_N ; AH = 10011100 (C9H)
 HLT
END 