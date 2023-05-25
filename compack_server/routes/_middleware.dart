import 'package:compack_server/src/middlewares/middleware.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(counterMiddleware())
      .use(todoMiddleware())
      .use(authServiceMiddleware())
      .use(authDataSourceMiddleware())
      .use(authConfigMiddleware())
      .use(databaseMiddleware());
}
