import 'package:compack_server/middlewares/middleware.dart';
import 'package:dart_frog/dart_frog.dart';


Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(counterMiddleware())
      .use(todoMiddleware());
}
