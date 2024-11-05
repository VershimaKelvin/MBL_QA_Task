import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:mbl/core/errors/error.dart';
import 'package:mbl/core/local_data/local_data_storage.dart';
import 'package:mbl/core/network/api_requester.dart';
import 'package:mbl/core/network/network_info.dart';
import 'package:mbl/feature/auth/data/model/user_model.dart';
import 'package:mbl/feature/auth/domain/entites/user_entity.dart';

abstract class AuthRemoteDatasource {

  Future<UserEntity> login({
    required String username,
    required String password,
  });

  Future<bool> register({
    required String username,
    required String password,
  });

}


@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  AuthRemoteDataSourceImpl({
    required this.networkInfo,
    required this.localDataStorage,
    required this.apiRequester,
  });

  final NetworkInfo networkInfo;
  final LocalDataStorage localDataStorage;
  final ApiRequester apiRequester;


  @override
  Future<UserEntity> login({
    required String username,
    required String password,
  })
  async {
    if (await networkInfo.isConnected) {
      final body = {
        "username": username,
        "password": password,
      };
      Logger().d(body);
      final dio = Dio();
      try {
        final response = await apiRequester.post(
          endpoint: 'auth/login',
          body: body,
        );
        Logger().d(response);
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['accessToken'] != null) {
          Logger().d('saving token');
          await localDataStorage.saveToken(responseData['accessToken'].toString());
          final token = await localDataStorage.getToken();
          Logger().d(token);
        }

        final _user = UserModel.fromJson(responseData);
        await localDataStorage.saveUser(_user);
        return _user;
      } on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          throw WrongCredentialException();
        } else {
          Logger().e(e.toString());
          throw Exception('Failed to login');
        }
      }
    }
    else {
      throw NoInternetException();
    }
  }


  @override
  Future<bool> register(
      {
        required String username,
        required String password,
       })
  async {
    if (await networkInfo.isConnected) {
      final body = {
        'username': username,
        'password': password,
      };
      final response = await apiRequester.post(
        endpoint: 'auth/signup',
        body: body,
      );
      Logger().d(response);
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } else {
      throw NoInternetException();
    }
  }

}
