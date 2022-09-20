import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Model/SettingsModel.dart';
import 'package:mobile_shop_app/Services/Constants.dart';

class profileTile extends StatelessWidget {
  SettingsMiodel settings;

  profileTile({
 required  this.settings
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r)
      ),
      child: ListTile(
        onTap: settings.function,
        leading: SvgPicture.asset('Assets/Icons/${settings.icon}.svg'),
        title: Text(
          settings. title.tr(),
          style: TextStyle(color: black),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h ,horizontal: 15.w),
    );
  }
}
