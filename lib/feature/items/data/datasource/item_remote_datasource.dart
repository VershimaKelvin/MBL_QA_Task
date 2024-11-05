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
import 'package:mbl/feature/items/data/model/item_model.dart';

abstract class ItemRemoteDatasource {
  Future<List<ItemModel>> getAllItems();

  Future<bool> createItem({
    required String name,
    required String description,
});
}


@LazySingleton(as: ItemRemoteDatasource)
class ItemRemoteDataSourceImpl implements ItemRemoteDatasource {
  ItemRemoteDataSourceImpl({
    required this.networkInfo,
    required this.localDataStorage,
    required this.apiRequester,
  });

  final NetworkInfo networkInfo;
  final LocalDataStorage localDataStorage;
  final ApiRequester apiRequester;

  @override
  Future<List<ItemModel>> getAllItems()
  async{
    if (await networkInfo.isConnected) {
      final queryParams = {
        'join': 'user',
      };
      Logger().d('Fetching items with query parameters: $queryParams');
      try {
        final token = await localDataStorage.getToken();
        Logger().d(token);
        final response = await apiRequester.get(
          endpoint: 'items?join=user',
          queryParameters: queryParams,
          token: token,
        );
        Logger().d('Fetch items response: ${response.data}');
        final responseData = response.data as List<dynamic>; // Cast to List
        return responseData
            .map((item) => ItemModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          throw Exception('Items not found');
        } else {
          Logger().e(e.toString());
          throw Exception('Failed to fetch items');
        }
      }
    } else {
      throw NoInternetException();
    }
  }


  @override
  Future<bool> createItem({
    required String name,
    required String description
  })
  async {
    if (await networkInfo.isConnected) {
      final body = {
        'name': name,
        'description': description,
      };
      final token = await localDataStorage.getToken();
      final response = await apiRequester.post(
        endpoint: 'items',
        body: body,
        token: token
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
