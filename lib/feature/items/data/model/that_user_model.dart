import 'package:json_annotation/json_annotation.dart';

part 'that_user_model.g.dart';

@JsonSerializable()
class ThatUserModel {
  ThatUserModel(
      this.id,
      this.username,
      );

  final String? id;
  final String? username;

  factory ThatUserModel.fromJson(Map<String, dynamic> json) =>
      _$ThatUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThatUserModelToJson(this);
}
