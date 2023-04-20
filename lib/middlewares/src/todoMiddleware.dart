import 'package:dart_frog/dart_frog.dart';
import 'package:in_memory_todos_data_source/in_memory_todos_data_source.dart';
import 'package:todos_data_source/todos_data_source.dart';

final _dataSource = InMemoryTodosDataSource();

Middleware todoMiddleware() {
  return (handler) {
    return (context) {
      return handler(context.provide<TodosDataSource>(() => _dataSource));
    };
  };
}
