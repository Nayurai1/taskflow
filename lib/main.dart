import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TaskListScreen(),
    );
  }
}

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isCompleted,
  });

  final int id;
  final String title;
  final String description;
  final String priority;
  final bool isCompleted;
}

const demoTasks = [
  Task(
    id: 1,
    title: 'Configurar el entorno Flutter',
    description: 'Verificar flutter doctor y el emulador Android',
    priority: 'Alta',
    isCompleted: true,
  ),
  Task(
    id: 2,
    title: 'Crear pantalla de bienvenida',
    description: 'Mostrar saludo, mensaje y tareas pendientes',
    priority: 'Media',
    isCompleted: true,
  ),
  Task(
    id: 3,
    title: 'Agregar estado de tareas',
    description: 'Contador con setState y objetivo diario',
    priority: 'Alta',
    isCompleted: true,
  ),
  Task(
    id: 4,
    title: 'Mostrar listado local de tareas',
    description: 'Usar Task, TaskCard y ListView.builder',
    priority: 'Alta',
    isCompleted: false,
  ),
  Task(
    id: 5,
    title: 'Preparar evidencias de la sesión',
    description: 'Capturas del avance y commit en GitHub',
    priority: 'Baja',
    isCompleted: false,
  ),
];

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  void _showDetail(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(task.title),
          content: Text(
            '${task.description}\n\n'
            'Prioridad: ${task.priority}\n'
            'Estado: ${task.isCompleted ? 'Completada' : 'Pendiente'}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => _showDetail(context),
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : null,
        ),
        title: Text(
          task.title,
          style: task.isCompleted
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        subtitle: Text('${task.priority} · ${task.description}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis tareas')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demoTasks.length,
        itemBuilder: (context, index) {
          final task = demoTasks[index];
          return TaskCard(task: task);
        },
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String studentName = 'Sornoza Leon Isaac Arturo';
  static const dailyGoal = 5;

  int pendingTasks = 3;
  int completedTasks = 0;

  void _completeTask() {
    if (pendingTasks == 0) {
      return;
    }

    setState(() {
      pendingTasks--;
      if (completedTasks < dailyGoal) {
        completedTasks++;
      }
    });
  }

  void _addTask() {
    setState(() {
      pendingTasks++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusMessage = pendingTasks == 0
        ? '¡Excelente! No tienes tareas pendientes.'
        : 'Aún tienes tareas por organizar.';

    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskFlow'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Hola, $studentName!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(statusMessage),
            const SizedBox(height: 8),
            Text('Completadas hoy: $completedTasks de $dailyGoal'),
            const SizedBox(height: 28),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.pending_actions),
                    const SizedBox(width: 12),
                    Text('Tareas pendientes: $pendingTasks'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: _addTask,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar tarea'),
                ),
                OutlinedButton.icon(
                  onPressed: pendingTasks == 0 ? null : _completeTask,
                  icon: const Icon(Icons.done),
                  label: const Text('Completar una tarea'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}