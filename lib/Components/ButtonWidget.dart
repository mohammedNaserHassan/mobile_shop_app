import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
class ButtonWidget extends StatelessWidget {
  bool isBorder;
  String title;
  Color color;
  Color textColor;
  VoidCallback function;
  ButtonWidget({Key? key,
    required this.title,required this.color,required this.function,this.textColor=Colors.white,this.isBorder=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: function,
      child: Container(
      child: Center(child: Text(title,style: Theme.of(context).textTheme.bodyText1?.copyWith(color: textColor,fontSize: 17.sp),)),
width: 325.w,
height: 44.h,
decoration:
BoxDecoration(
color: color,
borderRadius: BorderRadius.circular(10.r),
  border: Border.all(color: isBorder?black:Colors.transparent)
),
),
    );
  }
}
