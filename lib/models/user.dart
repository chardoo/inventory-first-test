import 'package:freezed_annotation/freezed_annotation.dart';

part '.generated/user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
     required String email,
    required String pasword,
    required String deviceToken,
    required String token,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}



