import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/core/usecase/usecase.dart';
import 'package:mbl/feature/auth/domain/repository/auth_repository.dart';


@lazySingleton
class RegisterUsecase extends UseCase<bool, RegisterParams> {
  RegisterUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, bool>> call(
    RegisterParams params,
  ) =>
      authRepository.register(
          username: params.username,
          password: params.password,

      );
}

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.password,
    required this.username,
  });

  final String password;
  final String username;


  @override
  List<Object?> get props => [
    password,
    username,
  ];
}
