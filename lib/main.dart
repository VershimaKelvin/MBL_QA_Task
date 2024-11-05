import 'package:flutter/material.dart';
import 'package:mbl/app/view/app.dart';
import 'package:mbl/bootstrap.dart';
import 'package:mbl/core/di/di_container.dart';

Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await bootstrap(() => const App());
}