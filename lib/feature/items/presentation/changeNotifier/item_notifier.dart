import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:mbl/app/view/widgets/app_loading_pop_up.dart';
import 'package:mbl/core/di/di_container.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/core/usecase/usecase.dart';
import 'package:mbl/core/utils/custom_toast.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';
import 'package:mbl/feature/items/domain/usecase/create_item_usecase.dart';
import 'package:mbl/feature/items/domain/usecase/item_usecase.dart';
import 'package:mbl/feature/items/presentation/pages/item_view.dart';

@lazySingleton
class ItemNotifier extends ChangeNotifier {
  ItemNotifier({
    required this.itemUsecase,
    required this.createItemUsecase,

  });

  final ItemUsecase itemUsecase;
  final CreateItemUsecase createItemUsecase;


  List<ItemEntity> items = [];

  bool isItemsLoading = true;


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



}
