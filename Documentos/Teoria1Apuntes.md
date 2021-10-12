<h1 align="center"> 💻Teoria</h1>

Indice
======
   * [Subrutinas](#Subrutinas)
   * [Pasaje de parámetros](#Pasaje_de_parametros)
     * [Por valor](#Por_Valor)
     * [Por Referencia](#Por_Referencia)
     * [Donde se pasan los Parámetros](#Donde_Pasan_Los_Parametros)
   * [Funcionamiento de la pila](#Funcionamiento_de_la_pila)
   * [PUSH/POP](#Push_Pop)
   * [Interrupciones](#Interrupciones)
     * [Por Hardware](#Por_Hardware) 
     * [Por Software](#Por_Software) 
     * [Funcionamiento](#Funcionamiento)


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

Donde_Pasan_Los_Parametros
--------------------------
#### Vía Registros
- El número de registros es la principal limitación.
- Es importante documentar que registros se usan

#### Vía Memoria
- Variables definidas en el programa ("Globales")
- Se usa un área definida de memoria (RAM)
- Difícil de estandarizar (En una variable llamada cachito (Casi ni se usa))

#### Vía pila (stack) 
- Es el método más ampliamente usado.
- La pila (o stack) es una zona de memoria (RAM) destinada a este uso específico.
- Lo usa la mayoría de los lenguajes de alto nivel.
- Independientemente de memoria y registros.
- Hay que comprender bien como funciona porque la pila es usada por el usuario y por el sistema
- Aunque es más complicado, en general los registros son recursos muy preciados.

Funcionamiento_de_la_pila
=========================

#### Zona de memoria destinada a un uso específico.
- Uso del sistema: Salva la dirección de retorno cuando es llamada una subrutina o se produce una interrupción de hardware
- Uso del usuario: Pasaje de parámetros

#### Cada vez que se ejecuta un programa, el solo inicializa el registro SP apuntado por la pila.
- El simulador inicia SP = 8000H

Push_Pop
========
- PUSH: Apila datos. El SP apunta al unico dato almacenado, por lo tanto primero se decrementa y luego almacena el dato.
- POP: Desapila datos. Desapila el dato y luego incrementa el SP. Operación inversa a la anterior.
- PUSH y POP apilan y desapilan datos de 16 bits (2 bytes)

Interrupciones
==============
- La funcionalidad dentro de un sistema de cómputo es implementada por hardware que ayuda al procesador
- Cada dispositivo opera a su propio ritmo, pero hay necesidad de sincronizar la operación del procesador con estos dispositivos.
- Una solución: El procesador pregunta a cada dispositivo su estado (si hay dato disponible). Cuando el dato está disponible el procesador puede leerlo y procesarlo. (Polling)
- Desventaja:
  - El procesador malgasta tiempo preguntando contínuamente si hay algún dato disponible.
  - Hay que esperar a los dispositivos más lentos.
- Mejor solución: Cuando un dispositivo necesita la atención del procesador, envía una señal para avisarle, es decir produce una interrupción. Este mecanismo permite alterar la secuencia normal de procesamiento. Recordar otros mecanismos (jmp, call).

Por_Hardware
------------
- Son las generadas por dispositivos de E/S.
- Son las ***verdaderas*** interrupciones.
- El sistema de cómputo tiene que manejar estos eventos externos ***no planeados*** o ***asincronicos***
- No están relacionadas con el proceso en ejecución en ese momento.
- Son conocidad como ***interrupt request***

Por_Software
------------
- Muchos procesadores tienen instrucciones explícitas que afectan el estado del procesador en la misma manera que int por hardware. Generalmente usadas para hacer llamadas a funciones del SO. Esta característica permite que las subrutinas del sistema se carguen en cualquier lugar.
- No requieren conocer la dirección de la rutina en tiempo de ejecución.
- Sib más cortas que Call.
- Hay sistemas que no permiten hacer una llamada directa a una dirección de la función del SO, pues es una zona reservada.
- Se pueden reubicar fácilmente.

Que_pasa_si_no_las_tuviera?
---------------------------
- Al cargar un programa habría que ***mirar*** todas las llamadas al BIOS y SO y remplazar en el código las direcciones de todas estas funciones invocadas.
- Además es una manera de llamar a funciones cuyo código no está en el programa principal (como los procedimientos en Pascal o las subrutinas que escribimos en assembler)

Ciclo_de_Interrupción
---------------------
- Añadido al ciclo de instrucción.
- El procesador comprueba sise ha generado alguna interrupción
  - Indicada por la presencia de una señal de interrupción.
- Si no hay señales de interrupción, capta la siguiente instrucción.
- Si hay alguna interrupción pendiente:
  - Se suspende la ejecución del programa en curso.
  - Guarda su contexto (próxima instrucción a ejecutar y otros)
  - Carga el PC con la dirección de comienzo de una rutina de gestión de interrupción.
  - Finalizada la rutina de gestrión el procesador retoma la ejecución del programa del usuario en el punto de interrupción.   

Escenario_de_trabajo
--------------------
- El procesador tiene una única entrada de interrupciones.
- ¿Cómo solucionamos tener varias entradas de interrupciones?
- Existe un dispositivo: controlador de interrupciones (PIC)
- Interrupciones priorizadas.
- Interrupciones vectorizadas

Funcionamiento
--------------
#### 1) El PIC recibe un pedido de interrupción de un dispositivo externo y prioriza éste con otros pedidos que pueden llegar o estar pendientes.

#### 2) Un pedido de interrupción es enviado al procesador, por la línea INTR.

#### 3) El procesador contesta por la línea INTA y solicita un puntero de 8 bits para la tabla

#### 4) El procesador recibe el puntero y lo usa para acceder a la tabla de vectores (direcciones) donde se encuentra la dirección del servicio.

#### 5) Accede a la tabla y obtiene la dirección buscada.

#### 6) Salva en la pila la dirección actual, los flags y salta a la dirección del servicio.
