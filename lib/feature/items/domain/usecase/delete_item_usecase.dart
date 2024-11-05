


import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';
import 'package:mbl/feature/items/domain/repository/item_repository.dart';

@lazySingleton
class DeleteItemUsecase extends UseCase<bool, DeleteParam> {
  DeleteItemUsecase({
    required this.itemRepository,
  });

  final ItemRepository itemRepository;

  @override
  Future<Either<Failure, bool>> call(
      DeleteParam params,
      ) =>
      itemRepository.deleteItem(
        id: params.id,
      );
}

class DeleteParam extends Equatable {
  const DeleteParam({
    required this.id,
  });


  final String id;


  @override
  List<Object?> get props => [
    id,
  ];
}
