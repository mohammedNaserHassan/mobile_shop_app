import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/Auth/CreatePassScreen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 120.h,
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
              'Profile',
              style: Theme.of(context).textTheme.headline5,
            ),
            automaticallyImplyLeading: false,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: Text('Alternate mobile number details',style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),))),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
                  child: Divider(
                    color: light,
                  )),
              ButtonWidget(
                isBorder: true,
                textColor: grey,
                  title: 'Change password',
                  color: Colors.transparent,
                  function: () {
                    AppRouter.appRouter.goToPage(CreatePassScreen());
                  }),
              ButtonWidget(title: 'Edit', color: green, function: () {})
            ],
          ),
        );
      },
    );
  }
}
