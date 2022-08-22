import 'package:flutter/material.dart';
import 'package:mobile_shop_app/AppFire.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MobileProvider>(
        create: (BuildContext context) => MobileProvider(),
        child: ScreenUtilInit(
          designSize: const Size(392.7, 834.9),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              theme: themeData,
              debugShowCheckedModeBanner: false,
              home: AppFire(),
              navigatorKey: AppRouter.appRouter.navkey,
            );
          },
        ));
  }
}
