<h1 align="center"> 💻Preguntas</h1>

Indice
======
   * [Subrutinas](#Subrutinas)
   * [Pasaje de parámetros](#Pasaje_de_parametros)
     * [Por valor](#Por_Valor)
     * [Por Referencia](#Por_Referencia)
   * [Funcionamiento de la pila](#Funcionamiento_de_la_pila)
   * [PUSH/POP](#Push_Pop)


Subrutinas
==========

3000H = Ditinta a 2000H (programa principal). La subrutina no debe sobre escribir otras zonas del programa.

Pasaje_de_parametros
====================

- Procedimientos (subrutinas), en general requieren datos de entrada y proveen datos de salida.
- Parametros son estos datos pasados a y desde el procedimiento.
- Estos parámetros pueden ser pasados de dos maneras
  - Por Valor (Cuanto vale)
  - Por Referencia (La dirección)

Por_Valor
--------
- Es eso: Se pasa el valor de una variable al procedimiento
- Son sólo parámetros de entrada.
- Independientemente del uso de este valor por parte del procedimiento, éste no puede ser modificado.

Por_Referencia
--------------
- Aca es pasada la dirección de la variable y no su valor.
- Es necesario cuando hay que modificar el valor del parámetro (Retorno)
- En general menos eficiente que pasar por valor. Tenemos la dir y hay que acceder a memoria para buscar el dato.
- Pero más eficiente cuando hay que transferir un arreglo datos entre proc. Asi se pasa la dir del arreglo.

Funcionamiento_de_la_pila
=========================

Push_Pop
========
