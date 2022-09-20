import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Components/profileTile.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';
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
      body: Consumer<MobileProvider>(
  builder: (context, provider, child) {
  return ListView.builder(
          shrinkWrap: true,
          itemCount: provider.seting.length,
          itemBuilder: (context, index) =>
              profileTile(settings: provider.seting[index]));
  },
)
    );
  }
}
