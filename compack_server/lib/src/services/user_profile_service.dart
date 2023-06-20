import 'package:auth_service/auth_service.dart';
import 'package:compack_server/src/data/user_profile/entities/extension/user_profile_entity_extension.dart';
import 'package:compack_server/src/data/user_profile/entities/user_profile_entity.dart';
import 'package:compack_server/src/data/user_profile/models/user_profile.dart';
import 'package:compack_server/src/data/user_profile/user_profile_data_source.dart';

class UserProfileService {
  final UserProfileDataSource dataSource;

  const UserProfileService({
    required this.dataSource,
  });

  Future<String> saveUser(
    User user, {
    required UserProfile userProfile,
  }) async {
    final dataInsert = UserProfile(
      id: user.id,
      email: userProfile.email ?? user.email,
      role: 0,
      phone: userProfile.phone ?? user.phone,
      name: userProfile.name,
      birthDate: userProfile.birthDate,
      avatarUrl: userProfile.avatarUrl,
      lastTimeUpdate: DateTime.now(),
    );
    return dataSource.saveUserProfile(userProfile: dataInsert);
  }

  Future<UserProfile?> updateUserProfile({
    required UserProfile userProfile,
  }) async {
    userProfile.lastTimeUpdate = DateTime.now();
    final result = await dataSource.updateUserProfile(userProfile: userProfile);
    if (result == null) return null;
    return result.toUserProfile();
  }

  Future<UserProfile?> findUserProfile({required String userId}) async {
    final result = await dataSource.findUserById(userId: userId);
    if (result == null) return null;
    return result.toUserProfile();
  }
}
