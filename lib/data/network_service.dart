import 'dart:convert';

import "package:http/http.dart" as http;

class NetworkService {
  final baseUrl = "http://10.0.2.2:3000";
  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + "/todos"));
      print(response.body);
      return jsonDecode(response.body) as List;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObject, int id) async {
    try {
      await http.patch(Uri.parse(baseUrl + "/todos/$id"), body: patchObject);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map?> addTodo(Map<String, String> todoObj) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + "/todos"),
        body: todoObj,
      );
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTodo(int? id) async {
    try {
      http.delete(Uri.parse(baseUrl + "/todos/$id"));
      return true;
    } catch (e) {
      return false;
    }
  }
}
