import 'package:dio/dio.dart';
import 'package:todo_app/models/todo_item.dart';

class NetworkManager {
  late final Dio _dio;
  final baseUrl = 'https://03cb-103-144-175-98.ngrok-free.app';
  NetworkManager() {
    _dio = Dio();
  }

  // Function buat ambil data To Do yang udah selesai
  Future<List<ToDoItem>> getToDoIsDone(bool isDone) async {
    final result = await _dio.get(
      '$baseUrl/todos?isDone=$isDone',
    );

    return (result.data as List).map((e) => ToDoItem.fromMap(e)).toList();
  }

  // Function buat create data
  Future<ToDoItem> postData(ToDoItem item) async {
    final result = await _dio.post(
      '$baseUrl/todos',
      data: item.toMap(),
    );

    return ToDoItem.fromMap(result.data);
  }

  // Update data
  Future<ToDoItem> updateData(ToDoItem item) async {
    final result = await _dio.put(
      '$baseUrl/todos/${item.id}',
      data: item.toMap(),
    );

    return ToDoItem.fromMap(result.data);
  }

  // Delete data
  Future<void> deleteData(ToDoItem item) async {
    await _dio.delete('$baseUrl/todos/${item.id}');
  }
}
