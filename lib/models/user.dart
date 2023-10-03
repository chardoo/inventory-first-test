import 'package:freezed_annotation/freezed_annotation.dart';

part '.generated/user.freezed.dart';
part '.generated/user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String email,
    required String password,
    required String deviceToken,
    required String token,
    required Role role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

enum Role { admin, superAdmin, user }
