import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:todos_data_source/todos_data_source.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _handleGetMethod(context, id);
    case HttpMethod.put:
      return _handlePutMethod(context, id);
    case HttpMethod.delete:
      return _handleDeleteMethod(context, id);
    case HttpMethod.post:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _handleDeleteMethod(RequestContext context, String id) async {
  final dataSource = context.read<TodosDataSource>();
  await dataSource.delete(id);
  return Response(statusCode: HttpStatus.noContent);
}

Future<Response> _handlePutMethod(RequestContext context, String id) async {
  final dataSource = context.read<TodosDataSource>();
  final todo = await dataSource.read(id);
  if (todo == null) {
    return Response(statusCode: HttpStatus.notFound);
  }
  final dataUpdated = Todo.fromJson(
    context.request.json() as Map<String, dynamic>,
  );
  final newTodo = dataSource.update(
    id,
    todo.copyWith(
      title: dataUpdated.title,
      description: dataUpdated.description,
      isCompleted: dataUpdated.isCompleted,
    ),
  );
  return Response.json(body: newTodo);
}

Future<Response> _handleGetMethod(RequestContext context, String id) async {
  final dataSource = context.read<TodosDataSource>();
  return Response.json(body: await dataSource.read(id));
}
