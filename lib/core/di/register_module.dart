
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';

@module
abstract class RegisterModule {
  Dio get dio => Dio();

  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();

  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();

  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker => InternetConnectionChecker();
  // DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();
}
