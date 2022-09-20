import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        title: Text('Notification'.tr(),style: Theme.of(context).textTheme.headline5,),
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
            itemCount:provider.notifications.length,
            itemBuilder: (context,index){
            final notify=  provider.notifications[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 1,
                child: ListTile(
                  title: Text(notify['title'],style: Theme.of(context).textTheme.headline5,),
                  subtitle: Text(notify['message'],style: TextStyle(color: grey),overflow: TextOverflow.ellipsis,),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
