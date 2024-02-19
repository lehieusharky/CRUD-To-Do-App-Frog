import 'package:todos_data_source/todos_data_source.dart';

abstract class TodosDataSource {
  Future<List<TodoModel>> getAll();

  Future<TodoModel?> get(String id);

  Future<TodoModel> create(TodoModel todoModel);

  Future<TodoModel> update(String id, TodoModel updateTodoModel);

  Future<void> delete(String id);
}
