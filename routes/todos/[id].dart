import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:my_config/my_config.dart';
import 'package:todos_data_source/todos_data_source.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String id,
) async {
  final myResponse = context.read<MyResponse>();
  try {
    final todoDataSource = context.read<TodosDataSource>();

    final currentTodo = await todoDataSource.get(id);

    return _handlerResponse(context, currentTodo, myResponse, id);
  } catch (e) {
    return Future.value(myResponse.getFailureResponse());
  }
}

Future<Response> _handlerResponse(
  RequestContext context,
  TodoModel? currentTodo,
  MyResponse myResponse,
  String id,
) {
  if (currentTodo == null) {
    return Future.value(
      myResponse.getFailureResponse(message: 'Get todo detail failded'),
    );
  }

  final response = switch (context.request.method) {
    HttpMethod.get => _getDetail(context, myResponse, currentTodo),
    HttpMethod.put => _update(context, id, myResponse, currentTodo),
    HttpMethod.delete => _delete(context, id, myResponse),
    _ => Future.value(myResponse.getFailureResponse())
  };

  return response;
}

Future<Response> _getDetail(
  RequestContext context,
  MyResponse myResponse,
  TodoModel currentTodo,
) async {
  try {
    return myResponse.getSuccessResponse(
      keyData: 'todo',
      data: currentTodo.toJson(),
    );
  } catch (e) {
    return myResponse.getFailureResponse(message: 'Get detail of todo failed');
  }
}

Future<Response> _update(
  RequestContext context,
  String id,
  MyResponse myResponse,
  TodoModel currentTodo,
) async {
  try {
    final todoDataSource = context.read<TodosDataSource>();

    final updatedTodoJson =
        await context.request.json() as Map<String, dynamic>;

    final updatedTodoModel = TodoModel.fromJson(updatedTodoJson);

    final updatedTodo = await todoDataSource.update(
      id,
      currentTodo.copyWith(
        description: updatedTodoModel.description ?? currentTodo.description,
        title: updatedTodoModel.title ?? currentTodo.title,
        isCompleted: updatedTodoModel.isCompleted ?? currentTodo.isCompleted,
      ),
    );

    return myResponse.getSuccessResponse(
      keyData: 'updated_todo',
      data: updatedTodo.toJson(),
    );
  } catch (e) {
    return myResponse.getFailureResponse(message: 'Updated todo failed');
  }
}

Future<Response> _delete(
  RequestContext context,
  String id,
  MyResponse myResponse,
) async {
  try {
    final todoDataSource = context.read<TodosDataSource>();
    await todoDataSource.delete(id);

    return myResponse.getSuccessResponse();
  } catch (e) {
    return myResponse.getFailureResponse(message: 'Delete todo failed');
  }
}
