import 'package:compack_server/src/database/database_config.dart';
import 'package:stormberry/stormberry.dart';



typedef Future<dynamic> DatabaseScope(Database database);

/// {@template database_service}
/// Database Service for other packages
/// {@endtemplate}
class DatabaseService {
  /// {@macro database_service}
  DatabaseService({required this.config});

  final DatabaseConfig config;

  Future<dynamic> execute(DatabaseScope scope) async {
    final database = _openDatabase();
    final result = await scope.call(database);
    await database.close();
    return result;
  }

  Database _openDatabase() {
    return Database(
      debugPrint: config.debugPrint,
      host: config.host,
      port: config.port,
      database: config.databaseName,
      user: config.user,
      password: config.password,
      useSSL: config.useSSL,
      timeoutInSeconds: config.timeoutInSeconds,
      queryTimeoutInSeconds: config.queryTimeoutInSeconds,
      timeZone: config.timeZone,
      isUnixSocket: config.isUnixSocket,
      allowClearTextPassword: config.allowClearTextPassword,
      replicationMode: config.replicationMode,
    );
  }
}
