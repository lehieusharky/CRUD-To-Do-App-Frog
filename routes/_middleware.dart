import 'package:dart_frog/dart_frog.dart';
import 'package:in_memory_todos_data_source/in_memory_todos_data_source.dart';
import 'package:my_config/my_config.dart';
import 'package:todos_data_source/todos_data_source.dart';

final _todosDataSource = InMemoryTodosDataSource();

final _myResponse = MyResponse();

Handler middleware(Handler handler) {
  return handler.use(_myResponseProvider()).use(_todoDataSourceProvider());
}

Middleware _todoDataSourceProvider() =>
    provider<TodosDataSource>((context) => _todosDataSource);

Middleware _myResponseProvider() =>
    provider<MyResponse>((context) => _myResponse);
