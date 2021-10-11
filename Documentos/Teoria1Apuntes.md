<h1 align="center"> 💻Preguntas</h1>

## Sobre procedimientos y funciones.

#### 1) Cuáles son los métodos de pasaje de argumentos a procedimientos/funciones que conoce?

#### 2) Que es una pila?

#### 3) Que hardware utilizaremos con una pila?

#### 4) Describa el funcionamiento de la pila.

## Sobre interrupciones.

#### 1) Explique la secuencia de acciones que suceden ante un pedido de interrupción de la CPU

#### 2) Que funciones posee un PIC?

#### 3) Que son las interrupciones por software? Como se usan?

#### 4) Cuando hay múltiples interrupciones, como puedo controlarlas?

## Sobre E/S.

#### 1) Que diferencias existen entre la E/S mapeada en memoria y la E/S aislada en una computadora?

#### 2) Como es la estructura de un modo de E/S. Describa y grafique

#### 3) Que tecnicas puede utilizar una CPU para realizar operaciones de E/S

<h1 align="Preguntas random"> 💻Preguntas</h1>

#### 1) Explicar qué se transfiere al IP y desde donde al ejecutarse la instrucción ret.

#### 2) Explicar qué indican los registros ISR e IRR del controlador de interrupciones en el siguiente formato

```Assembly
                     ISR = 01H                         IRR = 02H
```

#### 3) ¿Qué significa el busy en estado lógico 0?

#### 4) ¿Qué interrupciones se encuentran habilitadas si el registro IMR del PIC tienen valor 0F5H?

#### 5) ¿Para qué se utilizan las instrucciones CLI y STI?

#### 6) ¿Qué modo de comunicación entre el handshake y el microprocesador se está utilizando si el registro de estado tiene el valor 00H?

#### 7) ¿Indicar de qué forma podrían intercambiar los contenidos de los registros CX y BC a través de la pila, utilizando solamente instrucciones PUSH y POP?

#### 8) ¿Cómo determina el microprocesador msx88 la direccion de comienzo de una rutina de interrupción?
- A - Las subrutinas de interrupción comienzan siempre en la dirección 3000H
- B - La dirección de comienzo es la que resulta de multiplicar por 4 el valor almacenado en un registro determinado del PIC.
- C - La dirección de comienzo es la dirección almacenada a partir de la celda cuya dirección resulta de multiplicar por 4 el valor de un registro determinado del PIC.

#### 9) ¿Ante qué evento el dispositivo de handshake conectado a la impresora del entorno msx88 emite una interrupción al PIC?

#### 10) Explicar brevemente en qué consiste el uso de la impresora vía handshaking por consulta de estado.

#### 11) ¿Qué información brinda el registro ISR del PIC?

#### 12) ¿Qué información se almacena en al pila al atenderse un pedido de interrupción?

#### 13) Si el registro IMR tiene el valor F0H ¿Bajo qué condición el registro ISR puede tener el valor 05H? Justifique.
