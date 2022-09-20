import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/services/Constants.dart';
import 'package:provider/provider.dart';
class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
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
          'Abouts'.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MobileProvider>(
  builder: (context, provider, child) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
          children: [
            Text(provider.about,overflow: TextOverflow.visible,),
            SizedBox(height: 20.h,),
            Text(provider.terms,overflow: TextOverflow.visible,),
          ],
        ),
  );
  },
),
    );
  }
}
