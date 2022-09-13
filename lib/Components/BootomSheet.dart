import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';
enum Language{ Arabic, English}
class BootomSheet extends StatelessWidget {
  const BootomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
  builder: (context, provider, child) {
  return Column(
    mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: Text('Language'.tr(),style: Theme.of(context).textTheme.headline5,),margin: EdgeInsets.only(left: 20.w,top: 10.h,bottom: 20.h),),
        Card(
          elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
          child: RadioListTile(
            title: Text('English'.tr()),
            onChanged: (x){
              provider.setLanguage(x);
            },
            activeColor: black,
            value: Language.English,
            groupValue: provider.lang,
          ),
        ),
        Card(
          elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
          child: RadioListTile(
            title: Text('Arabic'.tr()),
            onChanged: (x){
              provider.setLanguage(x);
            },
            value: Language.Arabic,
            groupValue: provider.lang,
            activeColor: black,
          ),
        ),
        Center(child: ButtonWidget(function: (){
          provider.saveLanguage(context);
        },title: 'SaveChanges'.tr(),color: black,)),
        SizedBox(height: 20.h,)
      ],
    );
  },
);
  }
}
