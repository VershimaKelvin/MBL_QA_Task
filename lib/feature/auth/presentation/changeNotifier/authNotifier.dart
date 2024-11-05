import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:mbl/app/view/widgets/app_loading_pop_up.dart';
import 'package:mbl/core/di/di_container.dart';
import 'package:mbl/core/errors/failure.dart';
import 'package:mbl/core/navigation/route_name.dart';
import 'package:mbl/core/utils/custom_toast.dart';
import 'package:mbl/feature/auth/domain/entites/user_entity.dart';
import 'package:mbl/feature/auth/domain/usecase/login_usecase.dart';
import 'package:mbl/feature/auth/domain/usecase/register_usecase.dart';
import 'package:mbl/feature/auth/presentation/pages/login.dart';
import 'package:mbl/feature/items/presentation/changeNotifier/item_notifier.dart';

@lazySingleton
class AuthNotifier extends ChangeNotifier {
  AuthNotifier({
    required this.loginUsecase,
    required this.registerUsecase,

  });

  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;


  UserEntity? user;


  Future<void> login(
    BuildContext context, {
    required String username,
    required String password,
  })
  async {
    final navigator = Navigator.of(context);
    unawaited(di<AppLoadingPopup>().show(context));
    final response = await loginUsecase(
      LoginUseCaseParams(
        username: username,
        password: password,
      ),
    );
    navigator.pop();
    await response.fold(
      (l) {
        print(l);
        if (l == NoInternetFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'No internet Connection');
        } else if (l == UnknownFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'Login Failed, Try again Later');
        } else if (l == TimoutFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'Login Failed, Request Timeout');
        }else if (l == WrongCredentialFailure()) {
          MyCustomToast.displayErrorMotionToast(context, 'User not Found');
        }
      },
      (r) async {
        user = r;
        Logger().d(user);
        await di<ItemNotifier>().getAllItems(context);
        await Navigator.pushNamedAndRemoveUntil(
            context, RouteName.itemView, (route) => false);

      },
    );
  }



  Future<void> register(
    BuildContext context, {
        required String username,
        required String password,
  })
  async {
    final navigator = Navigator.of(context);
    unawaited(di<AppLoadingPopup>().show(context));
    final response = await registerUsecase(
      RegisterParams(
        username: username,
        password: password,
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
          MyCustomToast.displayErrorMotionToast(context, 'username already in use');
        }
      },
      (r) async {
        if(r){
          MyCustomToast.displaySuccessMotionToast(context, 'Account Created');
          unawaited(Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
                  (route) => false));
        }else{
          MyCustomToast.displayErrorMotionToast(context, 'please try again later');
        }
      },
    );
  }


}
