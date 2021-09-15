; Recibe el caracter a rotar en AH
; Devuelve el resultado también en AH
ORG 3000H
 ROTARIZQ: ADD AH, AH
  ADC AH, 0
  RET
ORG 1000H
 b DB 27H ; (00100111) en binario
ORG 2000H
 MOV AH, b ; AH = 00100111
 ; Realizamos una rotación
 CALL ROTARIZQ ; AH = 01001110
 ; Realizamos una segunda rotación
 CALL ROTARIZQ ; AH = 10011100
HLT
END