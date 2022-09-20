import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class buildNoInternetWidget extends StatelessWidget {
  const buildNoInternetWidget();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                'NoInterenet'.tr(),
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.grey,
                ),
              ),
              Image.asset('Assets/Images/no_internet.png',)
            ],
          ),
        ),
      ),
    );
  }
}
