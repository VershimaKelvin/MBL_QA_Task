import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mbl/feature/auth/data/model/this_user_model.dart';
import 'package:mbl/feature/auth/domain/entites/user_entity.dart';
import 'package:mbl/feature/items/data/model/that_user_model.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel extends ItemEntity {
  const ItemModel({
     String? id,
     String? createdAt,
     String? updatedAt,
     String? deletedAt,
     String? name,
     String? description,
     String? userId,
     ThatUserModel? user,
  }) : super(
    id: id,
    createdAt: createdAt,
      updatedAt:updatedAt,
      deletedAt:deletedAt,
      name:name,
      description:description,
      userId:userId,
      user:user
  );


  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
