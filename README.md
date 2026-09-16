# Granjavilla

## Introducción

Nuestro personaje tiene una granja y se gana la vida cultivando plantas de distintas especies.

Para ello, tiene que sembrar, regar y cosechar los cultivos de su granja. Después de la cosecha, vende lo que cultivó y obtiene ganancias en forma de monedas de oro.

Todo el oro que obtiene por sus cosechas lo acumula.

Nuestro objetivo es construir un juego en el que podamos controlar al personaje utilizando el teclado para moverlo alrededor del tablero.

Definir casos de prueba y realizar los tests correspondientes para los requerimientos dados.

## Personaje

El personaje se mueve por el tablero con las flechas.

Existen 4 variantes de imagen para mostrar al personaje:

* `f-player-normal`: el personaje femenino mirando al frente.
* `f-player-abajo`: el personaje femenino mirando hacia abajo.
* `m-player-normal`: el personaje masculino mirando al frente.
* `m-player-abajo`: el personaje masculino mirando hacia abajo.

Cuando el personaje está sobre algún elemento, usará la imagen en la que mira hacia abajo. De lo contrario, usará la imagen en la que mira al frente.

El personaje conoce su género, el cual utilizará para saber si tiene que mostrar la versión femenina o masculina.

Al apretar la tecla `G`, debe cambiar de género.

Escribir los tests que validen la imagen que devuelve el personaje en cada posible combinación.

> **Nota:** Se puede construir un objeto cualquiera adicional para probar el cambio de imagen.

## 1. Sembrar

En este juego consideramos tres plantas: *maíz*, *trigo* y *tomaco*.

El personaje siembra estas plantas en la granja mediante las siguientes acciones:

* Al apretar la `M`, siembra maíz en su posición actual.
* Al apretar la `T`, siembra trigo en su posición actual.
* Al apretar la `O`, siembra una semilla de tomaco en su posición actual.

El personaje no puede plantar en una parcela que ya está plantada. Además, para esta primera versión, si la parcela ya está plantada, la acción no se puede realizar.

| Planta     | Estado inicial                                                        |
| ---------- | --------------------------------------------------------------------- |
| **Maíz**   | Es una planta bebé y corresponde a la imagen `maiz_bebe.png`.         |
| **Trigo**  | Está en etapa de evolución 0 y corresponde a la imagen `trigo_0.png`. |
| **Tomaco** | Es una planta hecha y derecha y corresponde a la imagen `tomaco.png`. |

Se pide, además de resolver el requerimiento visualmente, saber cuáles son los cultivos plantados en la granja.

> **Nota:** Modelar la granja como un objeto separado del personaje. La granja no es un objeto visual; simplemente modela el conocimiento que tenemos sobre los cultivos.

Probar el siguiente caso de ejemplo:

* El personaje comienza en la posición `(5,5)`.
* El personaje planta el tomaco.
* Verificar que la posición del tomaco es `(5,5)`.
* Verificar que el único cultivo de la granja es el tomaco.
* El personaje intenta plantar el trigo, pero no puede porque ya hay un cultivo en esa parcela.
* El personaje se cambia a la posición `(6,6)`.
* El personaje intenta plantar el tomaco, pero no puede porque ya está plantado.
* El personaje planta el trigo.
* Verificar que la posición del trigo es `(6,6)`.
* Verificar que los cultivos de la granja son el tomaco y el trigo.

## 2. Regar

Una vez sembrado un cultivo, para que crezca debe ser regado.

Cuando presionamos la `R`, se debe regar la planta que está en la misma posición que el personaje.

Si no hay una planta, no se puede realizar la acción y debe lanzarse un error indicando `"no tengo nada para regar"`.

### ¿Qué pasa cuando se riega una planta?

| Planta     | Efecto al ser regada                                                                                                                                                                                               |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Maíz**   | Si es bebé, pasa a adulta y la imagen que se muestra es `maiz_adulto.png`. Si ya es adulta, no hace nada.                                                                                                          |
| **Trigo**  | Pasa a la etapa de evolución siguiente: de 0 a 1, de 1 a 2, de 2 a 3 y de 3 vuelve a 0. La imagen que se muestra en cada etapa es `trigo_x.png`, donde `x` corresponde al número de la etapa de evolución.         |
| **Tomaco** | Se mueve a la celda inmediatamente superior. Si estaba en la fila más alta (`y = height - 1`), pasa a la fila más baja (`y = 0`). Pero si la celda objetivo tenía otro cultivo, no se mueve y se queda donde está. |

Probar los siguientes ejemplos:

### Sin cultivo

* Intentar regar. La acción debería fallar porque no hay ningún cultivo.

### Maíz

* Se siembra el maíz.
* Verificar que la imagen es `maiz_bebe.png`.
* Regar.
* Verificar que la imagen es `maiz_adulto.png`.
* Regar.
* Verificar que la imagen es `maiz_adulto.png`.

### Trigo

* Se siembra el trigo.
* Verificar que la imagen es `trigo_0.png`.
* Regar.
* Verificar que la imagen es `trigo_1.png`.
* Regar.
* Verificar que la imagen es `trigo_2.png`.
* Regar.
* Verificar que la imagen es `trigo_3.png`.
* Regar.
* Verificar que la imagen es `trigo_0.png`.

### Tomaco

* Definir el tamaño del tablero en `5x5`.
* Ubicar el personaje en `(3,3)`.
* Plantar el tomaco.
* Regar.
* Verificar que la posición del tomaco es `(3,4)`.
* Ubicar al personaje en `(3,4)`.
* Regar.
* Verificar que la posición del tomaco es `(3,0)`.
* Ubicar al personaje en `(3,1)`.
* Plantar el trigo.
* Ubicar al personaje en `(3,0)`.
* Regar.
* Verificar que la posición del tomaco sigue siendo `(3,0)`.

## 3. Cosecha

Las plantas que están listas se pueden cosechar.

Cuando presionamos la `C`, se espera que se coseche la planta que se encuentra en la misma posición que el personaje.

Si no hay ninguna planta, o si esta no está lista para cosechar, la acción no se puede realizar y debe lanzarse un error.

El *maíz* está listo para la cosecha si es adulto, el *trigo* si está en nivel de evolución 2 o más y el *tomaco* siempre está listo.

Si la planta está lista para la cosecha, se la cosecha. Se debe recordar qué plantas se cosecharon y, por lo tanto, se pueden vender.

El acto de cosechar una planta implica que esta desaparece visualmente del juego.

> **Nota:** En este punto no interesa qué pasa con el juego si se siembra un cultivo que ya fue cosechado, ya que la mejor manera de resolver esto es con herramientas que todavía no hemos visto en la materia.

Probar el siguiente ejemplo:

* Ubicar el personaje en `(3,3)`.
* Intentar cosechar. No se debería poder porque no hay cultivo.
* Sembrar tomaco.
* Cosechar.
* Verificar que ya no hay cultivos en la granja.
* Verificar que el tomaco figura entre los cultivos cosechados de la granja.
* Sembrar maíz.
* Intentar cosechar. No se debería poder porque no está listo.
* Regar.
* Cosechar.
* Verificar que ya no hay cultivos en la granja.
* Verificar que el tomaco y el maíz son los cultivos cosechados de la granja.
* Sembrar trigo.
* Intentar cosechar. No se debería poder porque no está listo (etapa 0).
* Regar.
* Intentar cosechar. No se debería poder porque no está listo (etapa 1).
* Regar.
* Verificar que la consulta de si el trigo está listo para cosechar devuelve verdadero (etapa 2).
* Regar.
* Cosechar.
* Verificar que ya no hay cultivos en la granja.
* Verificar que el tomaco, el maíz y el trigo son los cultivos cosechados de la granja.

## 4. Venta

Incorporar al juego un objeto `mercado` (imagen `mercado.png`).

Cuando el personaje colisiona con el mercado, vende todo lo que haya cosechado de la granja.

Al hacerlo, se obtiene oro por cada planta vendida, de acuerdo con esta especificación:

* **Maíz:** 150 monedas por planta.
* **Trigo:** 100 monedas si está en etapa 2 y 200 si está en etapa 3. La cuenta genérica es `(etapa - 1) * 100`.
* **Tomaco:** 80 monedas por planta.

La cantidad de oro acumulado debe recordarse.

Al presionar la barra espaciadora, el personaje dice cuántas plantas cosechadas hay para vender y cuanto oro ganaría en una venta.
Por ejemplo:
> "Tengo 2 plantas para vender por 180 monedas"

Además a través del método text() el personaje expresa cuanto oro acumulado hay

> **Atenti:** Una vez que vende lo que tiene para vender, obviamente deja de tenerlo.

Definir un caso de prueba para cada valor posible de venta. Combinar casos en los que haya una o más plantas para vender.


### Otro problema que se debe solucionar

¿Qué pasa si se intenta sembrar donde hay un mercado?

**Opción 1: no se puede sembrar.**

Modificar la validación al sembrar. Esto impacta también en el movimiento del tomaco, que ya no podría desplazarse a un lugar con un mercado, al igual que no puede desplazarse a un lugar donde hay otro cultivo.

**Opción 2: se puede sembrar.**

Si elegís esta opción, tenés que tener cuidado con la colisión, ya que el mercado puede colisionar con el personaje, pero también con un tomaco u otros cultivos.

