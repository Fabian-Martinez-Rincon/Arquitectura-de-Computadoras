; Recibe el caracter a rotar en AH
; Devuelve el resultado también en AH
ORG 3000H
 ROTARIZQ: ADD AH, AH
  ADC AH, 0 ;Suma el carry
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
 MOV AH, b ; AH = 00100111
 ; Realizamos una rotación
 MOV BH,5
 CALL ROTARIZQ_N ; AH = 01001110
 
HLT
END

; Recibe el caracter a rotar en AH
; Recibe la cantidad de posiciones en BH
; Devuelve el resultado también en AH


