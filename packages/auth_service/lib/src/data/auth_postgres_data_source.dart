
import 'package:auth_service/src/data/auth_data_source.dart';
import 'package:auth_service/src/data/entities/user_entity.dart';
import 'package:auth_service/src/data/models/models.dart';
import 'package:database_service/database_service.dart';
import 'package:stormberry/stormberry.dart';

/// {@template auth_postgres_data_source}
/// Desctiption.
/// {@endtemplate}
class AuthPostgresDataSource implements AuthDataSource {

  /// {@macro auth_postgres_data_source}
  const AuthPostgresDataSource({required this.databaseService});
  final DatabaseService databaseService;

  @override
  Future<UserEntityView?> findUserByEmail({required String email}) async {
    final query = QueryParams(where: 'email=@email', values: {'email': email});
    final rawResult = await databaseService.execute((database) {
      return database.userEntities.queryUserEntitys(query);
    });
    if (rawResult == null) {
      return null;
    }
    final accountList = rawResult as List<UserEntityView>;
    if (accountList.isEmpty) {
      return null;
    }
    return accountList.first;
  }

  @override
  Future<UserEntityView?> findUserById({required String userId}) async {
    final rawResult = await databaseService.execute(
      (database) => database.userEntities.queryUserEntity(userId),
    );
    if (rawResult == null) {
      return null;
    }
    return rawResult as UserEntityView;
  }

  @override
  Future<String> saveUser({
    required User user,
    required String password,
  }) async {
    final currentTime = DateTime.now();
    user
      ..timeCreated = currentTime.toIso8601String()
      ..lastLogonTime = currentTime.toIso8601String()
      ..lastTimeUpdate = currentTime.toIso8601String();
    final insertRequest = user.toInsertRequest(password);
    await databaseService.execute(
      (database) => database.userEntities.insertOne(insertRequest),
    );
    return user.id!;
  }

  @override
  Future<UserEntityView> updateUser({required User user}) async {
    final updateRequest = user.toUpdateRequest();
    await databaseService.execute(
      (database) => database.userEntities.updateOne(updateRequest),
    );
    final userUpdated = await findUserById(userId: user.id!);
    return userUpdated!;
  }

  @override
  Future<UserEntityView?> updateUserPassword({
    required String userId,
    required String userPassword,
  }) async {
    final rawResult = await databaseService.execute(
      (database) => database.userEntities.queryUserEntity(userId),
    );
    if (rawResult == null) {
      return null;
    }
    final userEntityView = rawResult as UserEntityView;
    await databaseService.execute(
      (database) => database.userEntities.updateOne(
        UserEntityUpdateRequest(
          id: userEntityView.id,
          password: userPassword,
          lastTimeUpdate: DateTime.now(),
        ),
      ),
    );
    return userEntityView;
  }
}
