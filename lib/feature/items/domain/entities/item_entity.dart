import 'package:equatable/equatable.dart';
import 'package:mbl/feature/auth/data/model/this_user_model.dart';
import 'package:mbl/feature/items/data/model/that_user_model.dart';

class ItemEntity extends Equatable {
  const ItemEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.description,
    required this.userId,
    required this.user,

  });

  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? name;
  final String? description;
  final String? userId;
  final ThatUserModel? user;


  @override
  List<Object?> get props => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    name,
    description,
    userId,
    user,
  ];
}
