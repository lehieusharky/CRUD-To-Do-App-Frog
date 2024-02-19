import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:my_config/my_config.dart';
import 'package:todos_data_source/todos_data_source.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final myResponse = context.read<MyResponse>();

  final response = switch (context.request.method) {
    HttpMethod.get => _getAll(context, myResponse),
    HttpMethod.post => _create(context, myResponse),
    _ => Future.value(myResponse.getFailureResponse())
  };

  return response;
}

Future<Response> _create(RequestContext context, MyResponse myResponse) async {
  try {
    final todoDataSource = context.read<TodosDataSource>();

    final todoModel = await context.request.json() as Map<String, dynamic>;

    final createdTodo =
        await todoDataSource.create(TodoModel.fromJson(todoModel));

    return myResponse.getSuccessResponse(
      keyData: 'created_todo',
      data: createdTodo.toJson(),
      statusCode: HttpStatus.created,
    );
  } catch (e) {
    return myResponse.getFailureResponse(message: 'Create todo failded');
  }
}

Future<Response> _getAll(RequestContext context, MyResponse myResponse) async {
  try {
    final todoDataSource = context.read<TodosDataSource>();

    final todos = await todoDataSource.getAll();

    return myResponse.getSuccessResponse(
      keyData: 'todos',
      data: todos.map((e) => e.toJson()).toList(),
    );
  } catch (e) {
    return myResponse.getFailureResponse(message: 'Get all todos failded');
  }
}
