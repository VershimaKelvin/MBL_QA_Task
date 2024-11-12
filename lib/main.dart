import 'package:flutter/material.dart';
import 'package:mbl/app/view/app.dart';
import 'package:mbl/bootstrap.dart';
import 'package:mbl/core/di/di_container.dart';
import 'package:flutter_driver/driver_extension.dart';

Future<void>  main() async{
  enableFlutterDriverExtension();
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await bootstrap(() => const App());
}