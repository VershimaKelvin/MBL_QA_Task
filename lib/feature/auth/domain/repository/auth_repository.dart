import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/feature/auth/domain/entites/user_entity.dart';

abstract class AuthRepository {

  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, bool>> register({
    required String username,
    required String password,
  });

}
