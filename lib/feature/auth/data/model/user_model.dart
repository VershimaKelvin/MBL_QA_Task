import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mbl/feature/auth/data/model/this_user_model.dart';
import 'package:mbl/feature/auth/domain/entites/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    String? accessToken,
    ThisUserModel? user,
  }) : super(
    accessToken: accessToken,
    user: user,

  );


  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

UserModel userFromJson(String str) => UserModel.fromJson(
  json.decode(str) as Map<String, dynamic>, // Explicit cast to Map<String, dynamic>
);

String userToJson(UserModel user) => json.encode(
  user.toJson(),
);