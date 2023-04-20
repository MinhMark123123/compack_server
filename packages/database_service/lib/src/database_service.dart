import 'package:database_service/database_service.dart';
import 'package:database_service/src/database_config.dart';
import 'package:stormberry/stormberry.dart';

/// {@template database_service}
/// Database Service for other packages
/// {@endtemplate}

class DatabaseService {
  /// {@macro database_service}
  DatabaseService({required this.config}) {
    _database = Database(
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
  final DatabaseConfig config;
  late Database _database;

  Database get database => _database;
}
