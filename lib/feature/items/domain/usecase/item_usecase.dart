import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/core/usecase/usecase.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';
import 'package:mbl/feature/items/domain/repository/item_repository.dart';

@lazySingleton
class ItemUsecase extends UseCase<ItemEntity,NoParams>{
  ItemUsecase({
    required this.itemRepository,
  });

  final ItemRepository itemRepository;

  @override
  Future<Either<Failure, List<ItemEntity>>> call(
      NoParams params,
      ) async {
    return itemRepository.getItems();
  }
}

