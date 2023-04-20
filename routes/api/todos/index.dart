import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:todos_data_source/todos_data_source.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _handleGetMethod(context);
    case HttpMethod.post:
      return _handlePostMethod(context);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _handlePostMethod(RequestContext context) async {
  final dataSource = context.read<TodosDataSource>();
  final raw = await context.request.json();
  final body = Todo.fromJson(raw as Map<String, dynamic>);
  return Response.json(
    statusCode: HttpStatus.created,
    body: await dataSource.create(body),
  );
}

Future<Response> _handleGetMethod(RequestContext context) async {
  final dataSource = context.read<TodosDataSource>();
  return Response.json(body: await dataSource.readAll());
}
