import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todo_app/models/todo.dart';

class ToDoProvider with ChangeNotifier {
  List<ToDo> _todos = [];
  final String apiUrl = "http://localhost:8000/todos";

  List<ToDo> get todos => _todos;

  Future<void> fetchToDos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _todos = data.map((item) => ToDo.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception("Failed to load To-Dos");
    }
  }

  Future<void> addToDo(String title, String description) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'title': title,
        'description': description,
      }),
    );

    if (response.statusCode == 200) {
      fetchToDos();
    } else {
      throw Exception("Failed to add To-Do");
    }
  }

  Future<void> updateToDoStatus(int id, String status) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'status': status}),
    );

    if (response.statusCode == 200) {
      fetchToDos();
    } else {
      throw Exception("Failed to update To-Do");
    }
  }

  Future<void> deleteToDo(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      fetchToDos();
    } else {
      throw Exception("Failed to delete To-Do");
    }
  }
}
