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
                            style: const TextStyle(
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
                        child: Dismissible(
                          background: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              height: 85,
                              width: double.infinity,
                              // margin: EdgeInsets.symmetric(vertical: 8),
                              // padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(width: 1, color: Colors.red),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(Icons.delete, color: Colors.white),
                                    Text(
                                      " Delete",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            todoProvider.deleteTask(todo.id ?? '0');
                            setState(() {
                              // todos.removeAt(index);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 20, right: 10),
                            child: Container(
                              height: 85,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.indigo),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListTile(
                                // contentPadding: const EdgeInsets.all(6),
                                title: Text(
                                  todo.title ?? 'N/A',
                                  style: TextStyle(
                                    color: todo.isCompleted
                                        ? Colors.red
                                        : Colors.black,
                                    decoration: todo.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
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
                                    const SizedBox(height: 10),
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
                                leading: Checkbox(
                                  value: todo.isCompleted,
                                  onChanged: (_) {
                                    todoProvider
                                        .toggleTodoStatus(todo.id ?? '0');
                                  },
                                ),
                                onLongPress: () {
                                  todoProvider.deleteTask(todo.id ?? '0');
                                },
                              ),
                            ),
                          ),
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
