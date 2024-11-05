import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/feature/auth/domain/entites/user_entity.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';

abstract class ItemRepository {

  Future<Either<Failure, List<ItemEntity>>> getItems();

}
