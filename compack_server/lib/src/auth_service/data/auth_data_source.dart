import 'package:compack_server/src/auth_service/data/entities/user_entity.dart';
import 'package:compack_server/src/auth_service/data/models/models.dart';

/// {@template auth_data_source}
/// Desctiption.
/// {@endtemplate}
abstract class AuthDataSource {
  Future<String> saveUser({required User user, required String password});

  Future<UserEntityView?> findUserByEmail({required String email});

  Future<UserEntityView?> findUserById({required String userId});

  Future<UserEntityView> updateUser({required User user});

  Future<UserEntityView?> updateUserPassword({
    required String userId,
    required String userPassword,
  });
}
