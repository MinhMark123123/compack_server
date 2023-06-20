import 'package:compack_server/src/middlewares/middleware.dart';
import 'package:compack_server/src/middlewares/userMiddleware.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(counterMiddleware())
      .use(todoMiddleware())
      .use(verifyJwtMiddleware())
      .use(userProfileServiceMiddleware())
      .use(userProfileSourceServiceMiddleware())
      .use(authServiceMiddleware())
      .use(authDataSourceMiddleware())
      .use(authConfigMiddleware())
      .use(databaseMiddleware());
}
