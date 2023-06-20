import 'package:compack_server/src/data/user_profile/entities/extension/user_profile_entity_extension.dart';
import 'package:compack_server/src/data/user_profile/entities/user_profile_entity.dart';
import 'package:compack_server/src/data/user_profile/models/user_profile.dart';
import 'package:compack_server/src/data/user_profile/user_profile_data_source.dart';
import 'package:database_service/database_service.dart';

class UserProfilePostgresDataSource extends UserProfileDataSource {
  UserProfilePostgresDataSource({
    required this.databaseService,
  });

  final DatabaseService databaseService;

  @override
  Future<UserProfileEntityView?> findUserById({required String userId}) async {
    final result = await databaseService.execute(
      (database) => database.userProfileEntities.queryUserProfileEntity(userId),
    );
    if (result == null) {
      return null;
    }
    return result as UserProfileEntityView;
  }

  @override
  Future<String> saveUserProfile({required UserProfile userProfile}) async {
    final currentTime = DateTime.now();
    userProfile.lastTimeUpdate = currentTime;
    final insertRequest = userProfile.toInserRequest();
    await databaseService.execute(
      (database) => database.userProfileEntities.insertOne(insertRequest),
    );
    return userProfile.id!;
  }

  @override
  Future<UserProfileEntityView?> updateUserProfile({
    required UserProfile userProfile,
  }) async {
    final userProfileRaw = await findUserById(userId: userProfile.id!);
    if (userProfileRaw == null) return null;
    final userUpdateRequest = userProfile.toUpdateRequest();
    await databaseService.execute(
      (database) => database.userProfileEntities.updateOne(userUpdateRequest),
    );
    return findUserById(userId: userProfile.id!);
  }
}
