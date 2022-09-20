import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/paymentBottomSheet.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/Services/customDialog.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/Payment/PaymentDetails.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'PaymentMethod'.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MobileProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        'Payment'.tr(),
                        style: Theme.of(context).textTheme.headline5,
                      ))),
              Card(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: RadioListTile<dynamic>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: PaymentMethod.A,
                    groupValue: provider.selected,
                    onChanged: (c) {
                      provider.setPayment(c);
                    },
                    title: Text('Google Pay'),
                    secondary: SvgPicture.asset('Assets/Icons/apple.svg'),
                  )),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: RadioListTile<dynamic>(
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: PaymentMethod.B,
                  groupValue: provider.selected,
                  onChanged: (c) {
                    provider.setPayment(c);
                  },
                  title: Text('Paypal'),
                  secondary: SvgPicture.asset('Assets/Icons/paypal.svg'),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: RadioListTile<dynamic>(
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: PaymentMethod.C,
                  groupValue: provider.selected,
                  onChanged: (c) {
                    provider.setPayment(c);
                  },
                  title: Text('Mastercard'),
                  secondary: SvgPicture.asset('Assets/Icons/mastercard.svg'),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: RadioListTile<dynamic>(
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: PaymentMethod.D,
                  groupValue: provider.selected,
                  onChanged: (c) {
                    provider.setPayment(c);
                  },
                  title: Text('Apple Pay'),
                  secondary: SvgPicture.asset('Assets/Icons/apple.svg'),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: RadioListTile<dynamic>(
                  activeColor: green,
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: PaymentMethod.E,
                  groupValue: provider.selected,
                  onChanged: (c) {
                    provider.setPayment(c);
                  },
                  title: Text('Cash on delivery'),
                  secondary: SvgPicture.asset('Assets/Icons/cash.svg'),
                ),
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text('Address'.tr(),
                          style: Theme.of(context).textTheme.headline5)),
                ],
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: ListTile(
                  onTap: () {
                    showModalBottomSheet(
                        context: AppRouter.appRouter.navkey.currentContext!,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        builder: (context) => PaymentBootomSheet());
                  },
                  leading: Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), color: grey),
                      child: Icon(
                        Icons.location_on_sharp,
                        color: black,
                      )),
                  subtitle: Text(provider.selectedAddress == -1
                      ? 'Addtheshippingaddress'.tr()
                      : provider.addresses[provider.selectedAddress].details ??
                          ''),
                  title: Text(provider.selectedAddress == -1
                      ? 'Home Address'.tr()
                      : provider.addresses[provider.selectedAddress].name ??
                          ''),
                  trailing: Icon(
                    Icons.add,
                    color: grey,
                  ),
                ),
              ),
              Spacer(),
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: Container(
                  color: Colors.white,
                  height: 90.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 50.w,
                        height: 45,
                        decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: IconButton(
                          onPressed: () {
                            AppRouter.appRouter.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: white,
                          ),
                        ),
                      ),
                      ButtonWidget(
                          title: 'Confirm'.tr(),
                          color: black,
                          function: () {
                            provider.selectedAddress == -1
                                ? CustomDialog.customDialog.showCustom(
                                    'select your address...  please?'.tr())
                                : AppRouter.appRouter
                                    .goToPage(PaymentDetails());
                          })
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
