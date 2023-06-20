import 'package:compack_server/src/data/user_profile/user_profile_data_source.dart';
import 'package:compack_server/src/data/user_profile/user_profile_postgres_data_source.dart';
import 'package:compack_server/src/services/user_profile_service.dart';
import 'package:dart_frog/dart_frog.dart';
Middleware userProfileSourceServiceMiddleware() {
  return (handler) {
    return (context) {
      return handler(
        context.provide<UserProfileDataSource>(
              () => UserProfilePostgresDataSource(databaseService: context.read()),
        ),
      );
    };
  };
}

Middleware userProfileServiceMiddleware() {
  return (handler) {
    return (context) {
      return handler(
        context.provide<UserProfileService>(
              () => UserProfileService(dataSource: context.read()),
        ),
      );
    };
  };
}
