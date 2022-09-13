import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Services/Constants.dart';

class profileTile extends StatelessWidget {
  String title, icon;
  Function() function;

  profileTile({
    required this.icon,
    required this.title,
    required this.function
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r)
      ),
      child: ListTile(
        onTap: function,
        leading: SvgPicture.asset('Assets/Icons/${icon}.svg'),
        title: Text(
          title.tr(),
          style: TextStyle(color: black),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h ,horizontal: 15.w),
    );
  }
}
