import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:mbl/core/errors/error.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/feature/auth/data/datasource/auth_local_datasource.dart';
import 'package:mbl/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:mbl/feature/auth/domain/entites/user_entity.dart';
import 'package:mbl/feature/auth/domain/repository/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.localDatasource,
  });

  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource localDatasource;

  @override
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  })
  async {
    try {
      final response = await authRemoteDatasource.login(
        password: password, username: username,
      );
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
  Future<Either<Failure, bool>> register(
      {
        required String username,
        required String password,
      })
  async {
    try {
      final response = await authRemoteDatasource.register(
        password: password,
          username:username,
      );
      return Right(response);
    } catch (e) {
      // Logger().e(e);
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
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


