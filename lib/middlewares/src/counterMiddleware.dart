import 'package:dart_frog/dart_frog.dart';
int _count = 0;

Middleware counterMiddleware() {
  return(handler){
    return(context){
      return handler(context.provide<int>(() => ++_count));
    };
  };
}
