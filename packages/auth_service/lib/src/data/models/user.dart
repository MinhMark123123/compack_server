import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  User({
    this.id,
    this.email,
    this.phone,
    this.role,
    this.token,
    this.refreshToken,
    this.timeCreated,
    this.lastLogonTime,
    this.lastTimeUpdate,
  });

  /// Connect the generated function to the `fromJson` method.
  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  String? id;
  String? email;
  String? phone;
  int? role;
  String? token;
  String? refreshToken;
  String? timeCreated;
  String? lastLogonTime;
  String? lastTimeUpdate;

  /// Connect the generated function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);

}
