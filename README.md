# taskflow

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Alcance de TaskFlow

Problema: necesito organizar actividades académicas y saber cuáles faltan.
Usuario objetivo: estudiante que planifica entregas semanales.

### Historias de usuario y criterios de aceptación
1. Como estudiante, quiero listar mis tareas para ver qué debo hacer.
   Criterio: la lista muestra título, prioridad y estado de cada tarea.
2. Como estudiante, quiero abrir una tarea para leer su descripción.
   Criterio: al tocar una tarjeta aparece el detalle de la tarea elegida.
3. Como estudiante, quiero crear una tarea para registrar un pendiente.
   Criterio: el formulario guarda una tarea válida y la lista la muestra.
4. Como estudiante, quiero editar una tarea para corregir sus datos.
   Criterio: los cambios guardados aparecen en lista y detalle.
5. Como estudiante, quiero eliminar una tarea terminada para limpiar la lista.
   Criterio: después de confirmar, la tarea desaparece de la lista.

### Modelo de datos
Task: id (entero único), title (texto), description (texto),
priority (Alta, Media o Baja), isCompleted (verdadero/falso),
userId (entero que identifica al usuario de prueba).

### Tareas de ejemplo actuales
1. Configurar el entorno Flutter (Alta, completada)
2. Crear pantalla de bienvenida (Media, completada)
3. Agregar estado de tareas (Alta, completada)
4. Agregar navegación de tareas (Alta, completada)
5. Definir alcance y modelo de TaskFlow (Alta, pendiente)

### Pantallas previstas
Lista: tarjetas de tareas y acción para crear.
Detalle: información completa y futuras acciones de editar o eliminar.
Formulario: campos de título, descripción y prioridad.

### Requisitos no funcionales
La navegación debe tener textos comprensibles.
Un id inexistente debe mostrar un mensaje en vez de cerrar la app.

### Contrato de API que necesitaremos
GET /tasks        listar tareas
GET /tasks/:id    consultar detalle
POST /tasks       crear tarea
PATCH /tasks/:id  actualizar tarea
DELETE /tasks/:id eliminar tarea

La API concreta se elegirá después. Estas rutas son requisitos, no
direcciones de un servidor ya conectado.

## API de tareas

Fuente remota: JSONPlaceholder, una API pública de datos de prueba.
URL exacta: https://jsonplaceholder.typicode.com/todos?userId=2
Método: GET
Parámetro: userId=2 (valor elegido; está en la constante `userId` de `TaskApiService`)

Campos que llegan de la API: userId, id, title y completed.
`completed` se convierte al campo `isCompleted` de TaskFlow.

Campos que no llegan de la API: description y priority. TaskFlow los completa con valores de ejemplo: "Sin descripción (API)" y "Sin prioridad (API)".

Marcar una tarea como completada solo modifica la copia en memoria. JSONPlaceholder no guarda cambios permanentes, así que al reiniciar la app la tarea vuelve a su estado original.
q


## Estados de la lista de tareas

La pantalla de tareas distingue cuatro situaciones. Todas se controlan desde
TasksViewModel, que avisa a la vista con notifyListeners.

- Carga: mientras se espera la respuesta, se muestra un indicador circular.
  Se activa con isLoading = true y evita lanzar dos consultas a la vez.
- Éxito: la respuesta contiene tareas y se dibuja una tarjeta por cada Task.
- Vacío: la consulta terminó bien pero la lista tiene cero tareas. Se muestra
  "Todavía no hay tareas para mostrar." y el botón Actualizar.
- Error: la consulta falló (red, servidor o formato). Se muestra "No se
  pudieron cargar las tareas." y el botón Reintentar. La excepción técnica
  se escribe solo en la consola.

Vacío y error son distintos: una lista vacía es una respuesta válida, y un
error significa que no sabemos qué tareas hay.

### Cómo provoqué cada estado
- Carga: limité la red a "Slow 4G" en las herramientas de Chrome (F12, pestaña
  Network) y actualicé la lista.
- Éxito: con internet, la lista muestra mis ocho tareas locales y las de la
  API del usuario 1.
- Error: con la app abierta, apagué el wifi y pulsé el ícono de actualizar.
- Reintento: encendí el wifi y pulsé Reintentar; la lista volvió sin
  reiniciar la aplicación.
- Vacío: cambié temporalmente TaskApiService.userId a 9999 y usé solo
  RemoteTaskRepository, porque ese usuario no tiene tareas. Después restauré
  userId = 1 y el repositorio combinado.

Limitación: marcar una tarea como completada solo cambia la copia en memoria.
Al actualizar, la lista se vuelve a pedir y esa marca se pierde. La
persistencia de cambios se estudiará en las sesiones de CRUD.