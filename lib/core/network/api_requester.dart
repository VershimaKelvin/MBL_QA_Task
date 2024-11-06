import 'dart:async';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/web.dart';
import 'package:mbl/core/constants/network_client.dart';
import 'package:mbl/core/local_data/local_data_storage.dart';

@lazySingleton
class ApiRequester {
  ApiRequester({required this.dio, required this.localDataStorage});
  final Dio dio;
  final LocalDataStorage localDataStorage;

  Future<Response> _performRequest(RequestOptions requestOptions, {String? token}) async {
    try {
      Logger().d(requestOptions.path);
      final response = await dio.request(
        requestOptions.path,
        options: Options(
          method: requestOptions.method,
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
        ),
        data: requestOptions.data,

      );
      Logger().d(requestOptions);
      return response;
    } catch (error) {
      if (error is DioError && error.response?.statusCode == 401) {
        throw Exception('Unauthorized request. Please log in again.');
      } else {
        rethrow;
      }
    }
  }

  Future<Response> post({required String endpoint, required dynamic body, String? token}) async {
    final requestOptions = RequestOptions(
      path: BASE_URL + endpoint,
      headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      data: body,
      method: 'POST',
    );
    return _performRequest(requestOptions, token: token);
  }

  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters, // New parameter for query params
    String? token,
  }) async {
    final requestOptions = RequestOptions(
      path: BASE_URL + endpoint,
      headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      queryParameters: queryParameters, // Pass query parameters here
      method: 'GET',
    );

    Logger().d('GET request headers: ${requestOptions.headers}');
    Logger().d('GET request query parameters: $queryParameters');
    return _performRequest(requestOptions, token: token);
  }


  Future<Response> patch({required String endpoint, required dynamic body, String? token}) async {
    final requestOptions = RequestOptions(
      path: BASE_URL + endpoint,
      headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      data: body,
      method: 'PATCH',
    );
    Logger().d('here are the request headers ${requestOptions.headers}');
    return _performRequest(requestOptions, token: token);
  }

  Future<Response> delete({required String endpoint, required dynamic body, String? token}) async {
    final requestOptions = RequestOptions(
      path: BASE_URL + endpoint,
      headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      data: body,
      method: 'DELETE',
    );
    Logger().d('here are the request headers ${requestOptions.headers}');
    return _performRequest(requestOptions, token: token);
  }
}
