import 'package:compack_server/src/database/database_config.dart';
import 'package:compack_server/src/database/database_service.dart';
import 'package:dart_frog/dart_frog.dart';

final _dataBaseConfig = MyDatabaseConfig();

class MyDatabaseConfig extends DatabaseConfig {
  @override
  String? get databaseName => 'postgres';

  @override
  String? get host => 'localhost';

  @override
  bool? get isUnixSocket => false;

  @override
  String? get password => 'changeLater';

  @override
  int? get port => 5432;

  @override
  bool? get useSSL => false;

  @override
  String? get user => 'postgres';
}

Middleware databaseMiddleware() {
  return (handler) {
    return (context) {
      return handler(
        context.provide<DatabaseService>(
          () => DatabaseService(config: _dataBaseConfig),
        ),
      );
    };
  };
}
