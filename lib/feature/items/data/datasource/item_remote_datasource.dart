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

  Future<ItemModel> getSingleItem({required String id});

  Future<bool> deleteItem({required String id});

  Future<bool> createItem({
    required String name,
    required String description,
  });

  Future<bool> updateItem({
    required String name,
    required String description,
    required String id,
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
  Future<List<ItemModel>> getAllItems() async {
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
  Future<bool> createItem(
      {required String name, required String description}) async {
    if (await networkInfo.isConnected) {
      final body = {
        'name': name,
        'description': description,
      };
      final token = await localDataStorage.getToken();
      final response =
          await apiRequester.post(endpoint: 'items', body: body, token: token);
      Logger().d(response);
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<ItemModel> getSingleItem({required String id}) async {
    if (await networkInfo.isConnected) {
      final body = {};
      try {
        final token = await localDataStorage.getToken();
        Logger().d(token);
        final response = await apiRequester.get(
          endpoint: 'items/$id',
          token: token,
        );
        Logger().d('Fetch Single items response: ${response.data}');

        // Handle the response
        final responseData = response.data as Map<String, dynamic>;

        // Convert response data to CartModel
        final singleItem = ItemModel.fromJson(responseData);

        return singleItem;
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
  Future<bool> deleteItem({required String id})
  async {
    if (!await networkInfo.isConnected) {
      throw NoInternetException();
    }

    try {
      final token = await localDataStorage.getToken();
      final response = await apiRequester.delete(
        endpoint: 'items/$id',
        token: token,
        body: null,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Handle other status codes or unexpected cases here if needed
        return false;
      }
    } catch (e) {
      // Log or handle the error
      rethrow;
    }
  }

  @override
  Future<bool> updateItem(
      {required String name, required String description, required String id})
  async {
    if (!await networkInfo.isConnected) {
      throw NoInternetException();
    }
    final body = {
      "name":name,
      "description":description,
    };
    try {
      final token = await localDataStorage.getToken();
      final response = await apiRequester.patch(
        endpoint: 'items/$id',
        token: token,
        body: body,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Handle other status codes or unexpected cases here if needed
        return false;
      }
    } catch (e) {
      // Log or handle the error
      rethrow;
    }
  }
}
