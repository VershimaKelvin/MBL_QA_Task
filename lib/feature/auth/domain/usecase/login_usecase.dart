import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/core/usecase/usecase.dart';
import 'package:mbl/feature/auth/domain/entites/user_entity.dart';
import 'package:mbl/feature/auth/domain/repository/auth_repository.dart';

@lazySingleton
class LoginUsecase extends UseCase<UserEntity, LoginUseCaseParams> {
  LoginUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(
      LoginUseCaseParams params,
      ) async =>
      authRepository.login(
        password: params.password,
        username: params.username,

      );
}

class LoginUseCaseParams extends Equatable {
  const LoginUseCaseParams({
    required this.username,
    required this.password,
  });
  final String username;
  final String password;

  @override
  List<Object?> get props => [
    username,
    password,
  ];
}
