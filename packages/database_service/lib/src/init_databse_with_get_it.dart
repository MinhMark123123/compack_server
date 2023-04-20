import 'package:database_service/database_service.dart';
import 'package:database_service/src/database_config.dart';
import 'package:database_service/src/database_service.dart';

///init database with get it please register [DatabaseConfig] before call
///this method
void initDatabase() =>
    GetIt.instance.registerSingletonWithDependencies<Database>(
      () {
        return DatabaseService(config: GetIt.instance.get<DatabaseConfig>())
            .database;
      },
      dependsOn: [DatabaseConfig],
    );
