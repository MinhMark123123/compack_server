// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      id: json['id'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      name: json['name'] as String?,
      birthDate: json['birth_date'] == null
          ? null
          : DateTime.parse(json['birth_date'] as String),
      lastTimeUpdate: json['last_time_update'] == null
          ? null
          : DateTime.parse(json['last_time_update'] as String),
      role: json['role'] as int?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'avatar_url': instance.avatarUrl,
      'name': instance.name,
      'role': instance.role,
      'birth_date': instance.birthDate?.toIso8601String(),
      'last_time_update': instance.lastTimeUpdate?.toIso8601String(),
    };
