import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/core/usecase/usecase.dart';
import 'package:mbl/feature/auth/domain/repository/auth_repository.dart';
import 'package:mbl/feature/items/domain/repository/item_repository.dart';


@lazySingleton
class UpdateItemUsecase extends UseCase<bool, UpdateParams> {
  UpdateItemUsecase({
    required this.itemRepository,
  });

  final ItemRepository itemRepository;

  @override
  Future<Either<Failure, bool>> call(
      UpdateParams params,
      ) =>
      itemRepository.updateItem(
        description: params.description,
        name: params.name, id: params.id,
      );
}

class UpdateParams extends Equatable {
  const UpdateParams({
    required this.name,
    required this.description,
    required this.id,
  });

  final String name;
  final String description;
  final String id;


  @override
  List<Object?> get props => [
    name,
    description,
    id
  ];
}
