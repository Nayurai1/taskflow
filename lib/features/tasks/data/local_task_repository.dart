import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Configurar el entorno Flutter',
      description: 'Verificar flutter doctor y el emulador Android',
      priority: 'Alta',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 2,
      title: 'Crear pantalla de bienvenida',
      description: 'Mostrar saludo, mensaje y tareas pendientes',
      priority: 'Media',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 3,
      title: 'Agregar estado de tareas',
      description: 'Contador con setState y objetivo diario',
      priority: 'Alta',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 4,
      title: 'Agregar navegación de tareas',
      description: 'Usar go_router con la ruta /task/:id y el detalle',
      priority: 'Alta',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 5,
      title: 'Definir alcance y modelo de TaskFlow',
      description: 'Escribir historias, criterios y contrato de API',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
  ];

  @override
  Future<List<Task>> getTasks() async => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;
    _tasks[index] = task;
  }
}
