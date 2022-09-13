import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
class SpetialFeatureWidget extends StatelessWidget {
  const SpetialFeatureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
              side: BorderSide(color: grey)
          ),
          elevation: 0,
          child: Container(
            height: 42.h,
            width: 150.w,
            child: Row(
              children: [
                Container(
                  color: grey,
                  width: 42.w,
                  height: 42.h,
                  child: Icon(Icons.battery_0_bar,color: white,),
                ),
                Text(' 8/12GB RAM')
              ],
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
              side: BorderSide(color: grey)
          ),
          elevation: 0,
          child: Container(
            height: 42.h,
            width: 150.w,
            child: Row(
              children: [
                Container(
                  color: grey,
                  width: 42.w,
                  height: 42.h,
                  child: Icon(Icons.battery_0_bar,color: white,),
                ),
                Text(' 8/12GB RAM')
              ],
            ),
          ),
        )
      ],
    );
  }
}
