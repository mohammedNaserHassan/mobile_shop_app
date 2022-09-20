import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/TextFieldWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                'Address'.tr(),
                style: Theme.of(context).textTheme.headline5,
              ),
              margin: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 20.h),
            ),
            TextFieldWidget(
                title: 'AddressName'.tr(),
                prefix: '',
                bottom: 10,
                controller: provider.nameAddress),
            TextFieldWidget(
                title: 'City'.tr(),
                prefix: '',
                bottom: 10,
                controller: provider.city),
            TextFieldWidget(
                title: 'Region'.tr(),
                prefix: '',
                bottom: 10,
                controller: provider.region),
            TextFieldWidget(
                title: 'details'.tr(),
                prefix: '',
                bottom: 10,
                controller: provider.details),
            TextFieldWidget(
                title: 'notes'.tr(),
                prefix: '',
                bottom: 10,
                controller: provider.notes),
            Center(
                child:provider.isAddress?CircularProgressIndicator():  ButtonWidget(
              function:   provider.addAdddress,
              title: 'AddAddress'.tr(),
              color: green,
            )),
            SizedBox(
              height: 20.h,
            )
          ],
        );
      },
    );
  }
}
