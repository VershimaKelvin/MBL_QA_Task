import 'package:json_annotation/json_annotation.dart';

part 'this_user_model.g.dart';

@JsonSerializable()
class ThisUserModel {
  ThisUserModel(
      this.id,
      this.username,
      );

  final String? id;
  final String? username;

  factory ThisUserModel.fromJson(Map<String, dynamic> json) =>
      _$ThisUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThisUserModelToJson(this);
}
