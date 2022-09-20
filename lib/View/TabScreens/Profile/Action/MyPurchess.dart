import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/services/Constants.dart';
import 'package:provider/provider.dart';

class MyPurchess extends StatelessWidget {
  const MyPurchess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80.h,
            title: Text(
              'Mypurches'.tr(),
              style: Theme.of(context).textTheme.headline5,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                AppRouter.appRouter.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: black,
              ),
            ),
            actions: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: IconButton(
                      onPressed: () {
                        AppRouter.appRouter.back();
                        provider.setIndex(1);
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: black,
                      )))
            ],
          ),
          body: Column(
            children: [
              Center(
                child: Text('No purchases yet'.tr()),
              ),
            ],
          ),
        );
      },
    );
  }
}
