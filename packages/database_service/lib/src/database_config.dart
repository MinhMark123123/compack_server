import 'dart:core';

import 'package:stormberry/stormberry.dart';

abstract class DatabaseConfig {
  String? get host;

  int? get port;

  String? get databaseName;

  String? get user;

  String? get password;

  bool? get useSSL;

  bool? get isUnixSocket;

  bool get debugPrint => false;

  int get timeoutInSeconds => 30;

  int get queryTimeoutInSeconds => 30;

  String get timeZone => 'UTC';

  bool get allowClearTextPassword => false;

  ReplicationMode get replicationMode => ReplicationMode.none;
}
