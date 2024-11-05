import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:mbl/feature/auth/data/model/user_model.dart';

abstract class LocalDataStorage {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<UserModel> getUser();
  Future<void> saveUser(UserModel user);
  Future<void> saveUserData(String userJson);
  Future<void> clear();
}

@LazySingleton(as: LocalDataStorage)
class LocalDataStorageImpl implements LocalDataStorage {
  LocalDataStorageImpl(this.storage);

  final FlutterSecureStorage storage;
  @override
  Future<void> clear() async {
    await storage.deleteAll();
  }

  @override
  Future<String?> getToken() async {
    return storage.read(key: accessToken);
  }

  @override
  Future<void> saveToken(String token) {
    return storage.write(key: accessToken, value: token);
  }


  @override
  Future<void> saveUserData(String userJson) {
    return storage.write(key: userData, value: userJson);
  }

  @override
  Future<UserModel> getUser() async {
    final _data = await storage.read(key: userData);
    return userFromJson(_data!);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    return storage.write(key: userData, value: userToJson(user));
  }
}

const String accessToken = 'token';
const String userData = 'userData';
