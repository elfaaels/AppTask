import 'package:animate_do/animate_do.dart';
import 'package:app_task/model/todo.dart';
import 'package:app_task/services/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _todoTitleController = TextEditingController();
  final TextEditingController _todoDescController = TextEditingController();

  @override
  void initState() {
    // To load as Initial State
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    todoProvider.loadTasksFromStorage();
    super.initState();
  }

  void _addTodo() {
    if (_todoTitleController.text.isEmpty) return;

    // Construct Todo Data
    final newTodo = Todo(
      id: const Uuid().v4(),
      title: _todoTitleController.text,
      description: _todoDescController.text,
      createdAt: DateTime.now().toString(),
    );

    Provider.of<TodoProvider>(context, listen: false).addTask(newTodo);
    _todoTitleController.clear();
    _todoDescController.clear();
    Navigator.pop(context);
  }

  void showAddTodo(BuildContext context) async {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return ElasticInUp(
              child: AlertDialog(
                insetPadding: const EdgeInsets.all(10),
                content: Row(children: [
                  SizedBox(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.5,
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextFormField(
                            controller: _todoTitleController,
                            validator: (value) {
                              return value!.isNotEmpty ? null : "Title";
                            },
                            decoration:
                                const InputDecoration(hintText: "Title"),
                          ),
                          const SizedBox(height: 30),
                          Expanded(
                            child: TextFormField(
                              controller: _todoDescController,
                              keyboardType: TextInputType.multiline,
                              expands: true,
                              maxLines: null,
                              minLines: null,
                              decoration: const InputDecoration(
                                hintText: "Description",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            DateTime.now().toUtc().toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
                title: const Text('Create Todo'),
                actions: <Widget>[
                  InkWell(
                    child: const Text(
                      'ADD',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      _addTodo();
                    },
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('App Task'),
      ),
      body: FadeInLeftBig(
        child: Column(
          children: [
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, todoProvider, child) {
                  final todos = todoProvider.todos;
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return SlideInLeft(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          title: Text(
                            todo.title ?? 'N/A',
                            style: TextStyle(
                              color:
                                  todo.isCompleted ? Colors.red : Colors.black,
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                todo.description ?? 'N/A',
                                style: TextStyle(
                                  color: todo.isCompleted
                                      ? Colors.red
                                      : Colors.black,
                                  decoration: todo.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                todo.createdAt ?? 'N/A',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: todo.isCompleted
                                      ? Colors.red
                                      : Colors.grey,
                                  decoration: todo.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              todoProvider.deleteTask(todo.id ?? '0');
                            },
                          ),
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (_) {
                              todoProvider.toggleTodoStatus(todo.id ?? '0');
                            },
                          ),
                          onLongPress: () {
                            todoProvider.deleteTask(todo.id ?? '0');
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTodo(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
