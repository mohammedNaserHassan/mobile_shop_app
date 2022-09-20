import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog {
  CustomDialog._();

  static CustomDialog customDialog = CustomDialog._();

  showCustom(
    String text, [
    Function? function,
  ]) {
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
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      text,
                      style:
                          Theme.of(AppRouter.appRouter.navkey.currentContext!)
                              .textTheme
                              .headline4
                              ?.copyWith(fontWeight: FontWeight.w900),
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

  ///////////////////////////////// Thanks Dialog////////////////////////////////////
  thanksCustom(String text) {
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
                      child: Icon(
                        Icons.check,
                        size: 35.sp,
                        color: white,
                      ),
                      radius: 45.r,
                      backgroundColor: green,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      text,
                      style:
                          Theme.of(AppRouter.appRouter.navkey.currentContext!)
                              .textTheme
                              .headline4
                              ?.copyWith(fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Your order is completed. Please check the delivery status at order tracking page.'
                          .tr(),
                      style: TextStyle(color: grey),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                        onTap: () {
                          AppRouter.appRouter.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 120.w,
                            height: 40.h,
                            child: Text('Ok'.tr(),style: TextStyle(fontSize: 14,color: green),),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: green.withOpacity(0.3)
                        ),
                        )
                    )
                  ],
                )),
          );
        });
  }
}
