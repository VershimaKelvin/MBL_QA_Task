import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/core/usecase/usecase.dart';
import 'package:mbl/core/utils/custom_toast.dart';
import 'package:mbl/feature/items/domain/entities/item_entity.dart';
import 'package:mbl/feature/items/domain/usecase/item_usecase.dart';

@lazySingleton
class ItemNotifier extends ChangeNotifier {
  ItemNotifier({
    required this.itemUsecase,

  });

  final ItemUsecase itemUsecase;


  List<ItemEntity> items = [];


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
            items = r;
        Logger().d(items);
      },
    );
  }





}
