
import 'package:compack_server/src/data/user_profile/entities/user_profile_entity.dart';
import 'package:compack_server/src/data/user_profile/models/user_profile.dart';

extension UserProfileViewMapperExtension on UserProfileEntityView {
  UserProfile toUserProfile() {
    return UserProfile(
      id: id,
      role: role,
      email: email,
      phone: phone,
      name: name,
      avatarUrl: avatarUrl,
      birthDate: birthDate,
    );
  }
}

extension UserProfileExtension on UserProfile {
  UserProfileEntityInsertRequest toInserRequest() => UserProfileEntityInsertRequest(
    id: id!,
    role: role,
    email: email,
    phone: phone,
    name: name,
    avatarUrl: avatarUrl,
    birthDate: birthDate,
    lastTimeUpdate: lastTimeUpdate,
  );

  UserProfileEntityUpdateRequest toUpdateRequest() => UserProfileEntityUpdateRequest(
    id: id!,
    role: role,
    email: email,
    phone: phone,
    name: name,
    avatarUrl: avatarUrl,
    birthDate: birthDate,
    lastTimeUpdate: lastTimeUpdate,
  );
}
