import 'dart:io';

import 'package:auth_service/auth_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:database_service/database_service.dart';

const _emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const _passwordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'; //https://stackoverflow.com/a/56256456
const _jwtSecretKey = 'cRfUjXn2r5u8x/A?D(G+KbPdSgVkYp3s';
const _authPaths = [
  "api/auth/register",
  "api/auth/login",
  "api/auth/refresh_token",
];
final _authConfig = AuthConfig(
  patternEmail: _emailPattern,
  patternPassword: _passwordPattern,
  tokenExpiredDuration: const Duration(days: 30),
  refreshTokenExpiredDuration: const Duration(days: 120),
  jwtSecretKey: _jwtSecretKey,
);

Middleware authConfigMiddleware() {
  return (handler) {
    return (context) {
      return handler(context.provide<AuthConfig>(() => _authConfig));
    };
  };
}

Middleware authDataSourceMiddleware() {
  return (handler) {
    return (context) {
      return handler(
        context.provide<AuthDataSource>(
          () => AuthPostgresDataSource(
            databaseService: context.read<DatabaseService>(),
          ),
        ),
      );
    };
  };
}

Middleware authServiceMiddleware() {
  return (handler) {
    return (context) {
      return handler(
        context.provide<AuthService>(
          () => AuthService(
            authDataSource: context.read(),
            authConfig: context.read(),
          ),
        ),
      );
    };
  };
}

Middleware verifyJwtMiddleware() {
  return (handler) {
    return (context) async {
      final url = context.request.url.toString();
      final isAuthPaths = _authPaths.any(url.startsWith);
      if (isAuthPaths) {
        // Forward the request to the respective handler.
        return handler(context);
      }
      final authService = context.read<AuthService>();
      try {
        final headers = context.request.headers;
        final authInfo = headers['Authorization'];
        // Header: key = Authorization - value:  Bearer {token}
        // authInfo = Bearer {token}
        if (authInfo == null || !authInfo.contains('Bearer')) {
          return Response(
            statusCode: HttpStatus.unauthorized,
            body: AppException.tokenInvalid.message,
          );
        }
        final token = authInfo.split(' ')[1];
        final user = await authService.verifyToken(token: token);
        return handler(context.provide<User>(() => user));
      } catch (e) {
        return Response(
          statusCode: HttpStatus.unauthorized,
          body: AppException.messageFromException(e),
        );
      }
    };
  };
}
