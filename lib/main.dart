import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Controller/AuthProvider.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Helper/DioHelper.dart';
import 'package:mobile_shop_app/Helper/SharedPreferencesHelper.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mobile_shop_app/View/Features/SplashScreen.dart';
import 'package:mobile_shop_app/generated/codegen_loader.g.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPreferencesHelper.x.initSharedPreference();
  DioHelper.dioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => MobileProvider()),
          ChangeNotifierProvider(create: (c) => AuthProvider()),
        ],
        child: EasyLocalization(
          supportedLocales: const[
            Locale('en'),
            Locale('ar'),
          ],
          path: 'Assets/Languages',
          fallbackLocale:const Locale('en',),
          assetLoader: CodegenLoader(),
          child: ScreenUtilInit(
            designSize: const Size(392.7, 834.9),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: themeData,
                debugShowCheckedModeBanner: false,
                home: const SplashScreen(),
                navigatorKey: AppRouter.appRouter.navkey,
              );
            },
          ),
        ));
  }
}
