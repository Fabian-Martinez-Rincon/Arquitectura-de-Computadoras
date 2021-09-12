ORG 1000H
 NUM1 DW 5H
 NUM2 DW 2H
 RES DW ?

ORG 3000H
  MUL: MOV DX,0
    ;Paso el valor de num1
    MOV BX, AX
    MOV AX, [BX]
    ;Paso el valor de num2
    MOV BX, CX
    MOV CX, [BX]
    ;Comparo que CX > 0
    CMP CX, 0
    JZ FIN
  LAZO: ADD DX, AX
    DEC CX
    JNZ LAZO
  FIN: RET

ORG 2000H
  MOV AX,OFFSET NUM1
  MOV CX,OFFSET NUM2
  CALL MUL
  MOV RES,DX
  HLT
END 