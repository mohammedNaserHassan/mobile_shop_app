import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Components/BootomSheet.dart';
import 'package:mobile_shop_app/Components/profileTile.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/TabScreens/HomePages/Action/NotificationPage.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        title: Text('Notification',style: Theme.of(context).textTheme.headline5,),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: black,), onPressed: () {
          AppRouter.appRouter.back();
        },),
        actions: [
          Icon(Icons.more_vert, color: black,),
          SizedBox(width: 20.w,)
        ],
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          profileTile(title: 'Notification', icon: 'notify',function: (){
            AppRouter.appRouter.goToPage(NotificationPage());
          }),
          profileTile(title: 'Language', icon: 'language',function: (){
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                    )),
              builder: (context)=>BootomSheet()
            );
          }),
          profileTile(title: 'Scanner', icon: 'Scan',function: (){}),
          profileTile(title: 'Helpcenter', icon: 'help',function: (){}),
          profileTile(title: 'About s', icon: 'DangerCircle',function: (){}),
        ],
      ),
    );
  }
}
