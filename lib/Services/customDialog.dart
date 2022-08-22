import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog {
  CustomDialog._();

  static CustomDialog customDialog = CustomDialog._();

  showCustom(String text, [Function? function]) {
    showDialog(
        context: AppRouter.appRouter.navkey.currentContext!,
        builder: (x) {
          return AlertDialog(
            content: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                    radius: 55,
                        backgroundImage: AssetImage('Assets/Images/splash.png'),
                    ),
                    SizedBox(height: 20.h,),
                    Text(
                      text,
                      style:
                          Theme.of(AppRouter.appRouter.navkey.currentContext!)
                              .textTheme
                              .headline4?.copyWith(fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    if (function == null) {
                      AppRouter.appRouter.back();
                    } else {
                      function;
                      AppRouter.appRouter.back();
                    }
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
}
