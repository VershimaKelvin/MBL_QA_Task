import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:mbl/app/view/widgets/app_loading_pop_up.dart';
import 'package:mbl/core/di/di_container.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/core/navigation/route_name.dart';
import 'package:mbl/core/usecase/usecase.dart';
import 'package:mbl/core/utils/custom_toast.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';
import 'package:mbl/feature/items/domain/usecase/create_item_usecase.dart';
import 'package:mbl/feature/items/domain/usecase/delete_item_usecase.dart';
import 'package:mbl/feature/items/domain/usecase/item_usecase.dart';
import 'package:mbl/feature/items/domain/usecase/single_item_usecase.dart';
import 'package:mbl/feature/items/domain/usecase/update_item_usecase.dart';
import 'package:mbl/feature/items/presentation/pages/item_view.dart';

@lazySingleton
class ItemNotifier extends ChangeNotifier {
  ItemNotifier({
    required this.itemUsecase,
    required this.createItemUsecase,
    required this.singleItemUsecase,
    required this.deleteItemUsecase,
    required this.updateItemUsecase,
  });

  final ItemUsecase itemUsecase;
  final CreateItemUsecase createItemUsecase;
  final SingleItemUsecase singleItemUsecase;
  final DeleteItemUsecase deleteItemUsecase;
  final UpdateItemUsecase updateItemUsecase;


  List<ItemEntity> items = [];
  ItemEntity? singleItem;

  bool isItemsLoading = true;
  bool singleItemLoading = true;


  Future<void> getAllItems(
      BuildContext context,)
  async {
    final navigator = Navigator.of(context);
    final response = await itemUsecase(
      NoParams()
    );
    await response.fold(
          (l) {
        if (l == NoInternetFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'No internet Connection');
        } else if (l == UnknownFailure()) {
          MyCustomToast.displayErrorMotionToast(context, ' Try again Later');
        } else if (l == TimoutFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'Request Timeout');
        }else if (l == WrongCredentialFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'User not Found');
        }
      },
          (r) async {
            isItemsLoading=false;
            items = r;
        Logger().d(items);
        notifyListeners();
      },
    );
  }


  Future<void> getSingleItem(
      BuildContext context,{required String id, required ItemEntity item})
  async {
    final navigator = Navigator.of(context);
    final response = await singleItemUsecase(
      SingleItemParam(id: id)
    );
    await response.fold(
          (l) {
        if (l == NoInternetFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'No internet Connection');
        } else if (l == UnknownFailure()) {
          MyCustomToast.displayErrorMotionToast(context, ' Try again Later');
        } else if (l == TimoutFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'Request Timeout');
        }else if (l == WrongCredentialFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'User not Found');
        }
      },
          (r) async {
            singleItemLoading=false;
            singleItem = r;
            Navigator.pushNamed(context, RouteName.itemDetailScreen,arguments: singleItem);
        Logger().d(items);
        notifyListeners();
      },
    );
  }


  Future<void> createItem(
      BuildContext context, {
        required String name,
        required String description,
      })
  async {
    final navigator = Navigator.of(context);
    unawaited(di<AppLoadingPopup>().show(context));
    final response = await createItemUsecase(
      CreateParams(
        name: name,
        description: description,
      ),
    );
    navigator.pop();
    await response.fold(
          (l) {
        if (l == NoInternetFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'No internet Connection');
        }
        else if (l == UnknownFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'please try again later');
        }
        else{
          MyCustomToast.displayErrorMotionToast(context, 'Action Failed, try again');
        }
      },
          (r) async {
        if(r){
          await getAllItems(context);
          MyCustomToast.displaySuccessMotionToast(context, 'Item Created');
          unawaited(Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ItemView(),
              ),
                  (route) => false));
        }else{
          MyCustomToast.displayErrorMotionToast(context, 'please try again later');
        }
      },
    );
  }


  Future<void> deleteitem(
      BuildContext context, {
        required String id,
      })
  async {
    final navigator = Navigator.of(context);
    unawaited(di<AppLoadingPopup>().show(context));
    final response = await deleteItemUsecase(
      DeleteParam(
        id: id,
      ),
    );
    navigator.pop();
    await response.fold(
          (l) {
        if (l == NoInternetFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'No internet Connection');
        }
        else if (l == UnknownFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'please try again later');
        }
        else{
          MyCustomToast.displayErrorMotionToast(context, 'Action Failed, try again');
        }
      },
          (r) async {
        if(r){
          await getAllItems(context);
          items.removeWhere((item) => item.id != null && item.id == id);
          MyCustomToast.displaySuccessMotionToast(context, 'Item Deleted');
          unawaited(Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ItemView(),
              ),
                  (route) => false));
        }else{
          MyCustomToast.displayErrorMotionToast(context, 'please try again later');
        }
      },
    );
  }



  Future<void> updateItem(
      BuildContext context, {
        required String id,
        required String name,
        required String description
      })
  async {
    final navigator = Navigator.of(context);
    unawaited(di<AppLoadingPopup>().show(context));
    final response = await updateItemUsecase(
      UpdateParams(
        id: id,
        name: name,
        description: description,
      ),
    );
    navigator.pop();
    await response.fold(
          (l) {
        if (l == NoInternetFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'No internet Connection');
        }
        else if (l == UnknownFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'please try again later');
        }
        else{
          MyCustomToast.displayErrorMotionToast(context, 'Action Failed, try again');
        }
      },
          (r) async {
        if(r){
          await getAllItems(context);
          MyCustomToast.displaySuccessMotionToast(context, 'Item Updated');
          unawaited(Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ItemView(),
              ),
                  (route) => false));
        }else{
          MyCustomToast.displayErrorMotionToast(context, 'please try again later');
        }
      },
    );
  }



}
