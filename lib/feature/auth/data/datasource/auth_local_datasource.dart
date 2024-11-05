

import 'package:injectable/injectable.dart';
import 'package:mbl/core/local_data/local_data_storage.dart';

abstract class AuthLocalDatasource {
  Future<void> logout();

}

@LazySingleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  AuthLocalDatasourceImpl({
    required this.localDataStorage,
  });

  final LocalDataStorage localDataStorage;

  @override
  Future<void> logout() async {
    await localDataStorage.clear();
  }


}
