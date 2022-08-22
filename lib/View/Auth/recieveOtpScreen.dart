import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/PinputWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class recieveOtpScreen extends StatelessWidget {
  const recieveOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Consumer<MobileProvider>(
        builder: (context, provider, index) => Center(
          child: Column(
            children: [
               SizedBox(
                height: 80.h,
              ),
              CircleAvatar(
                  backgroundColor: const Color(0xffEBF5EA),
                  radius: 100.r,
                  child: Image.asset(
                    'Assets/Images/otp.png',
                  )),
               SizedBox(
                height: 44.h,
              ),
              Text(
                'Phone Verification',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Container(
                margin:  EdgeInsets.only(top: 16.h, bottom: 33.h),
                child: Text(
                  'We need to register your phone number before \ngetting srated!',
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  height: 59.h,
                  margin:  EdgeInsets.only(
                    bottom: 25.h,
                    left: 20.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PinPutWidget(hint: '4', controller:provider.phone1),
                      PinPutWidget(hint: '0',controller:provider.phone2),
                      PinPutWidget(hint: '0',controller:provider.phone3),
                      PinPutWidget(hint: '0',controller:provider.phone4),
                    ],
                  )),
              ButtonWidget(
                title: 'verify phone number',
                color: green,
                function: provider.verifyphonenumber,
              ),
               SizedBox(
                height: 32.h,
              ),
              Text(
                'Edit phone number?',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Container(
                margin:  EdgeInsets.only(top: 20.h),
                width: 106.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: const Color(0xffEBF5EA),
                ),
                child: Center(
                  child: Text(
                    'Send again',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: green, fontSize: 13.sp),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
