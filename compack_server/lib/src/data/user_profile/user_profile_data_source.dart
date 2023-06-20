import 'package:compack_server/src/data/user_profile/entities/user_profile_entity.dart';
import 'package:compack_server/src/data/user_profile/models/user_profile.dart';

abstract class UserProfileDataSource {
  Future<String> saveUserProfile({required UserProfile userProfile});

  Future<UserProfileEntityView?> findUserById({required String userId});

  Future<UserProfileEntityView?> updateUserProfile({
    required UserProfile userProfile,
  });
}
