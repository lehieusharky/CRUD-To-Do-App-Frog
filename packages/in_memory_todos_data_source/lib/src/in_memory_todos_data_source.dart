import 'package:todos_data_source/todos_data_source.dart';
import 'package:uuid/uuid.dart';

class InMemoryTodosDataSource implements TodosDataSource {
  // cache
  final _cache = <String, TodoModel>{};

  @override
  Future<TodoModel> create(TodoModel todoModel) async {
    final todoID = const Uuid().v4();

    final todoData = todoModel.copyWith(id: todoID);

    _cache[todoID] = todoData;

    return todoData;
  }

  @override
  Future<void> delete(String id) async => _cache.remove(id);

  @override
  Future<TodoModel?> get(String id) async => _cache[id];

  @override
  Future<List<TodoModel>> getAll() async => _cache.values.toList();

  @override
  Future<TodoModel> update(String id, TodoModel updateTodoModel) async =>
      _cache.update(id, (value) => updateTodoModel);
}
