<h1 align="center">💻Practica 5 Instrucciones de Punto Flotante y pasaje de parámetros</h1>

```1)``` Simular el siguiente programa de suma de números en punto flotante y analizar minuciosamente la ejecución paso a paso. Inhabilitar Delay Slot y mantener habilitado Forwarding.

```s
.data
    n1: .double 9.13
    n2: .double 6.58
    res1: .double 0.0
    res2: .double 0.0
.code
    l.d f1, n1(r0)
    l.d f2, n2(r0)
    add.d f3, f2, f1
    mul.d f4, f2, f1
    s.d f3, res1(r0)
    s.d f4, res2(r0)
    halt
```

```a)``` Tomar nota de la cantidad de ciclos, instrucciones y CPI luego de la ejecución del programa.

```b)``` ¿Cuántos atascos por dependencia de datos se generan? Observar en cada caso cuál es el dato en conflicto y las instrucciones involucradas.

```c)``` ¿Por qué se producen los atascos estructurales? Observar cuales son las instrucciones que los generan y en qué etapas del pipeline aparecen.

```d)``` Modificar el programa agregando la instrucción ```mul.d f1, f2, f1``` entre las instrucciones ```add.d y mul.d```. Repetir la ejecución y observar los resultados. ¿Por qué aparece un atasco tipo ***WAR***?

```e)```

<h1 align="center">Ejercicios</h1>


