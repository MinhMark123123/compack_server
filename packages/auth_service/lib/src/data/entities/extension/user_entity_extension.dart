import 'package:auth_service/src/data/data.dart';

extension AccountEntityViewMapper on UserEntityView {
  User toUser() {
    return User(
      id: id,
      email: email,
      phone: phone,
      token: token,
      refreshToken: refreshToken,
      timeCreated: timeCreated?.toIso8601String(),
      lastLogonTime: lastLogonTime?.toIso8601String(),
      lastTimeUpdate: lastTimeUpdate?.toIso8601String(),
    );
  }
}

extension AccountEntityExtension on User {
  UserEntityInsertRequest toInsertRequest(String password) => UserEntityInsertRequest(
        id: id!,
        email: email,
        phone: phone,
        password: password,
        token: token,
        refreshToken: refreshToken,
        timeCreated: _getTime(timeCreated),
        lastLogonTime: _getTime(lastLogonTime),
        lastTimeUpdate: _getTime(lastTimeUpdate),
      );

  UserEntityUpdateRequest toUpdateRequest() => UserEntityUpdateRequest(
        id: id!,
        email: email,
        phone: phone,
        token: token,
        refreshToken: refreshToken,
        timeCreated: _getTime(timeCreated),
        lastLogonTime: _getTime(lastLogonTime),
        lastTimeUpdate: _getTime(lastTimeUpdate),
      );

  DateTime? _getTime(String? time) {
    return time == null ? null : DateTime.tryParse(time!);
  }
}
