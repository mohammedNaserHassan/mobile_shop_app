import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/profileTile.dart';
import 'package:mobile_shop_app/Controller/AuthProvider.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/ProfileScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/SettingsScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTab extends StatelessWidget {
   ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Profile'.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer2<MobileProvider,AuthProvider>(
  builder: (context, provider,auth, child) {
  return Column(
          children: [
            GestureDetector(
              onTap: (){
                AppRouter.appRouter.goToPage(ProfileScreen());
              },
              child: Container(
                width: double.infinity,
                height: 80.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 2.w,right: 15.w,top: 1.h),
                      height: 70.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child:  FadeInImage.assetNetwork(
                        placeholder: 'Assets/Images/profile.png',
                        image: provider.profileModel.data?.image?? 'Assets/Images/profile.png',
                        fit: BoxFit.cover,
                        height: 150.h,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      provider.profileModel.data?.name??'',
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16.sp,fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                    SizedBox(
                      width: 20.w,
                    )
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
                child: Divider(
                  color: light,
                )),
            profileTile(title: 'Settings', icon: 'Setting',function: (){
              AppRouter.appRouter.goToPage(SettingsScreen());
            }),
            profileTile(title: 'OrderTracking', icon: 'rack',function: (){}),
            profileTile(title: 'PaymentMethod', icon: 'payment',function: (){}),
            profileTile(title: 'Mypurches'.tr(), icon: 'Wallet',function: (){}),
            profileTile(title: 'Address', icon: 'Location',function: (){}),
            profileTile(title: 'Privacy', icon: 'privacy',function: (){}),
            profileTile(title: 'Logout', icon: 'Logout',function:(){
              auth.logOut();
              provider.setIndex(0);
            }),
          ],
        );
  },
),
      ),
    );
  }
}