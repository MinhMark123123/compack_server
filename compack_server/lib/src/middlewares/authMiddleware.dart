
import 'package:auth_service/auth_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:database_service/database_service.dart';

const _emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const _passwordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'; //https://stackoverflow.com/a/56256456
const _jwtSecretKey = 'cRfUjXn2r5u8x/A?D(G+KbPdSgVkYp3s';

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
