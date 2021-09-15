; Recibe el caracter a rotar en AH
; Devuelve el resultado también en AH
ORG 3000H
 ROTARIZQ: ADD AH, AH
  ADC AH, 0 ;Suma el carry
  RET
ORG 1000H

 b DB 80h ; (10000000) en binario
 
ORG 2000H
 MOV AH, b ; AH = 00100111
 ; Realizamos una rotación
 CALL ROTARIZQ ; AH = 01001110
 
HLT
END