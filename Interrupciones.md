<h1 align="center"> 💻Interrupciones</h1>

### Por Sofware


| Interrupcion | Funcion |
| ------------- | ------------- |
| INT 0  | Detiene el programa. Igual a HLT  |
| INT 3  | Debug. No lo vamos a utilizar  |
| INT 6  | Lee un caracter desde teclado  |
| INT 7  | Imprime un string en pantalla  |

<table>
<tr>
<td> En Orden </td> <td> Pos Orden </td><td> Pre Orden </td>
</tr>
<tr>
<td>
 
```Assembly
ORG 1000H
 LEIDO DB ?
ORG 2000H
 MOV BX, OFFSET LEIDO
 INT 6    
 INT 0
END
```
</td>
<td>
 

```pascal
Procedure preOrden ( a : arbol );
begin //Input 1,22,3,4,55,67,7,0
    if ( a<> nil ) then begin
        write (a^.dato,'|');   
        preOrden (a^.HI);
        preOrden (a^.HD);
    end;
end;//Output 1,22,3,4,7,55,67
```
</td>
 <td>
  
```pascal
Procedure posOrden ( a : arbol );
begin //Input 1,22,2,44,6,77,5,4,3,0
    if ( a<> nil ) then begin
        preOrden (a^.HI);
        preOrden (a^.HD);
        write (a^.dato);
    end;
end;//Output 22,2,6,5,4,3,44,77,1
```
</td>
</tr>
 
</table>




