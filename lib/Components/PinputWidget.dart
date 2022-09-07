import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PinPutWidget extends StatelessWidget {
  String hint;
  TextEditingController controller;
   PinPutWidget({Key? key,required this.hint,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      width: 68.w,
      height: 59.h,
      child: TextFormField(
        controller: controller,
        onChanged: (val){
          if(val.length==1){
            FocusScope.of(context).nextFocus();
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.phone,
        style: TextStyle(fontSize: 16.sp,color: black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: green
          )),
    );
  }
}
