import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/screens/todo_form_screen.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<ToDoProvider>(context, listen: false).fetchToDos(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(child: Text('An error occurred!'));
            } else {
              return Consumer<ToDoProvider>(
                builder: (ctx, todoProvider, child) {
                  if (todoProvider.todos.isEmpty) {
                    return const Center(
                        child: Text("No Todos available, yay!"));
                  } else {
                    return ListView.builder(
                      itemCount: todoProvider.todos.length,
                      itemBuilder: (ctx, i) => ListTile(
                        title: Text(todoProvider.todos[i].title),
                        subtitle: Text(todoProvider.todos[i].description),
                        trailing: Checkbox(
                          value: todoProvider.todos[i].status == 'completed',
                          onChanged: (bool? value) {
                            todoProvider.updateToDoStatus(
                              todoProvider.todos[i].id,
                              value! ? 'completed' : 'pending',
                            );
                          },
                        ),
                        onLongPress: () {
                          showDialog(
                            context: ctx,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Deletion'),
                                content: const Text(
                                    'Are you sure you want to delete this to-do item?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      todoProvider
                                          .deleteToDo(todoProvider.todos[i].id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('To-do deleted'),
                                        ),
                                      );
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const AddToDoScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
