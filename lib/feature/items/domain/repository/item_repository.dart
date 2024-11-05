import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/feature/auth/domain/entites/user_entity.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';

abstract class ItemRepository {
  Future<Either<Failure, List<ItemEntity>>> getItems();

  Future<Either<Failure, ItemEntity>> getSingleItem({required String id});

  Future<Either<Failure, bool>> deleteItem({required String id});

  Future<Either<Failure, bool>> createItems(
      {required String name, required String description});

  Future<Either<Failure, bool>> updateItem(
      {required String name, required String description, required String id});
}
