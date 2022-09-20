import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/TextFieldWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/Services/customDialog.dart';
import 'package:provider/provider.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 80.h,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Icon(
              Icons.more_vert,
              color: black,
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            AppRouter.appRouter.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Paymentdetails'.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MobileProvider>(
        builder: (context, provider, child) {
          String numb = provider.cardNumber.text;
          String promo = provider.promocode.text;
          String name = provider.holderName.text;
          return Column(
            children: [
              Stack(
                children: [
                  Image.asset('Assets/Images/BG.png'),
                  Positioned(
                      top: 0.h,
                      right: 0.w,
                      child: Image.asset('Assets/Images/ellipse.png')),
                  Positioned(
                      top: 10.h,
                      right: 20.w,
                      child: Image.asset('Assets/Images/ellipse.png')),
                  PositionedDirectional(
                      bottom: 30.h,
                      end: 30.h,
                      child: Image.asset('Assets/Images/icon.png')),
                  PositionedDirectional(
                      top: 60.h,
                      start: 30.w,
                      child: Text(name.isEmpty ? 'yourName'.tr() : name,
                          style: TextStyle(color: white))),
                  PositionedDirectional(
                      top: 120.h,
                      start: 30.w,
                      child: Text(
                          '4754 ' +
                              '${numb.isEmpty ? '****  ****' : numb}  3243',
                          style: TextStyle(color: white))),
                  PositionedDirectional(
                      bottom: 35.h,
                      start: 30.h,
                      child: Text(
                        '${promo.isEmpty ? '1234 ' : numb}' + 'AED',
                        style: TextStyle(color: white),
                      )),
                ],
              ),
              Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 15.h),
                      child: Text(
                        'CardDetails'.tr(),
                        style: Theme.of(context).textTheme.headline5,
                      ))),
              TextFieldWidget(
                  title: 'HolderName'.tr(),
                  prefix: 'Assets/Icons/Profile.svg',
                  bottom: 10,
                  controller: provider.holderName),
              TextFieldWidget(
                  title: 'CardNumber'.tr(),
                  type: TextInputType.number,
                  prefix: 'Assets/Icons/fluent_payment-24-regular.svg',
                  bottom: 10,
                  controller: provider.cardNumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      width: 160.w,
                      child: TextFieldWidget(
                          title: 'MM/YY',
                          type: TextInputType.number,
                          prefix: 'Assets/Icons/Calendar.svg',
                          bottom: 10,
                          controller: provider.date)),
                  Container(
                      width: 160.w,
                      child: TextFieldWidget(
                          title: 'CVV',
                          type: TextInputType.number,
                          prefix: 'Assets/Icons/Lock.svg',
                          bottom: 10,
                          controller: provider.lock)),
                ],
              ),
              TextFieldWidget(
                  title: 'coupon'.tr(),
                  type: TextInputType.number,
                  prefix: 'Assets/Icons/Ticket Star.svg',
                  bottom: 20,
                  controller: provider.promocode),
              Spacer(),
              provider.isOrder
                  ? CircularProgressIndicator()
                  : Container(
                margin: EdgeInsets.only(bottom: 30.h),
                    child: ButtonWidget(
                        title: 'Confirm'.tr(),
                        color: green,
                        function: provider.makeOrder),
                  )
            ],
          );
        },
      ),
    );
  }
}
