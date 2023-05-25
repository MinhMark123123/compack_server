// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as int?,
      token: json['token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      timeCreated: json['time_created'] as String?,
      lastLogonTime: json['last_logon_time'] as String?,
      lastTimeUpdate: json['last_time_update'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'role': instance.role,
      'token': instance.token,
      'refresh_token': instance.refreshToken,
      'time_created': instance.timeCreated,
      'last_logon_time': instance.lastLogonTime,
      'last_time_update': instance.lastTimeUpdate,
    };
