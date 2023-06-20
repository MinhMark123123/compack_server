import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserProfile {
  UserProfile({
    this.id,
    this.email,
    this.phone,
    this.avatarUrl,
    this.name,
    this.birthDate,
    this.lastTimeUpdate,
    this.role,
  });

  String? id;
  String? email;
  String? phone;
  String? avatarUrl;
  String? name;
  int? role;
  DateTime? birthDate;
  DateTime? lastTimeUpdate;

  /// Connect the generated function to the `fromJson` method.
  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  /// Connect the generated function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
