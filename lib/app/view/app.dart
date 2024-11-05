import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbl/core/constants/app_theme.dart';
import 'package:mbl/core/di/di_container.dart';
import 'package:mbl/core/navigation/route_name.dart';
import 'package:mbl/core/navigation/router.dart';
import 'package:mbl/feature/auth/presentation/changeNotifier/authNotifier.dart';
import 'package:provider/provider.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider<AuthNotifier>(create: (_) => di<AuthNotifier>()),
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        builder: (context,chld)=>MaterialApp(
          theme: AppTheme.themeData,
          debugShowCheckedModeBanner: false,
          title: 'Occupy',
          initialRoute: RouteName.login,
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }
}
