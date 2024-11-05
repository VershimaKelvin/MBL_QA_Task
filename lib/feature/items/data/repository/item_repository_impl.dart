import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:mbl/core/errors/error.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/feature/items/data/datasource/item_remote_datasource.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';
import 'package:mbl/feature/items/domain/repository/item_repository.dart';

@LazySingleton(as: ItemRepository)
class ItemRepositoryImpl extends ItemRepository {
  ItemRepositoryImpl({
    required this.itemRemoteDatasource,
  });

  final ItemRemoteDatasource itemRemoteDatasource;

  @override
  Future<Either<Failure, List<ItemEntity>>> getItems() async {
    try {
      final response = await itemRemoteDatasource.getAllItems();
      return Right(response);
    } catch (e) {
      Logger().e(e);
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is WrongCredentialException) {
        return Left(WrongCredentialFailure());
      }
      if (e is DioError) {
        Logger().d(e.error);
        if (e.type == DioErrorType.connectionTimeout ||
            e.type == DioErrorType.receiveTimeout) {
          return Left(
            TimoutFailure(),
          );
        }
        Logger().e(e.response?.data);
        if (e.response?.data != null && e.response?.data != '') {
          Logger().d(e.response!.data);
          return const Left(
            ServerFailure(
              message: 'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      return Left(
        UnknownFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> createItems(
      {required String name, required String description}) async {
    try {
      final response = await itemRemoteDatasource.createItem(
          name: name, description: description);
      return Right(response);
    } catch (e) {
      Logger().e(e);
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is WrongCredentialException) {
        return Left(WrongCredentialFailure());
      }
      if (e is DioError) {
        Logger().d(e.error);
        if (e.type == DioErrorType.connectionTimeout ||
            e.type == DioErrorType.receiveTimeout) {
          return Left(
            TimoutFailure(),
          );
        }
        Logger().e(e.response?.data);
        if (e.response?.data != null && e.response?.data != '') {
          Logger().d(e.response!.data);
          return const Left(
            ServerFailure(
              message: 'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      return Left(
        UnknownFailure(),
      );
    }
  }
}
