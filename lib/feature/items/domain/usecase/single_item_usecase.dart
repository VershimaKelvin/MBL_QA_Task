


import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';
import 'package:mbl/feature/items/domain/repository/item_repository.dart';

@lazySingleton
class SingleItemUsecase extends UseCase<ItemEntity, SingleItemParam> {
  SingleItemUsecase({
    required this.itemRepository,
  });

  final ItemRepository itemRepository;

  @override
  Future<Either<Failure, ItemEntity>> call(
      SingleItemParam params,
      ) =>
      itemRepository.getSingleItem(
        id: params.id,
      );
}

class SingleItemParam extends Equatable {
  const SingleItemParam({
    required this.id,
  });


  final String id;


  @override
  List<Object?> get props => [
    id,
  ];
}
