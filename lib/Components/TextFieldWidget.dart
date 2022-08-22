import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TextFieldWidget extends StatelessWidget {
  String title;
  String prefix;
  bool obscure;
  Widget? suffix=Container();
  double bottom;
  bool state;
  TextEditingController controller;
   TextFieldWidget({Key? key,required this.title, this.obscure=false,required this.prefix,required this.bottom,this.state=false,this.suffix,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
      builder: (context,provider,index) {
        return Container(
          margin: EdgeInsets.only(bottom:bottom),
          padding: EdgeInsets.only(top: 7.h),
          width: 325.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: TextField(
            obscureText:obscure ,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              suffixIcon: suffix,
              prefixIcon: state?
              Container(
                margin:  EdgeInsets.symmetric(horizontal: 5.w),
                child: DropdownButton<String>(
                  value: provider.selected,
                  icon: Container(child: Image.asset('Assets/Icons/Arrow - Down 2.png'),margin: EdgeInsets.symmetric(horizontal: 5.w),),
                  underline: SizedBox(),
                  items: provider.countries.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (index) {
                    provider.setCountries(index!);
                  },
                ),
              )
                  :SvgPicture.asset(prefix, fit: BoxFit.scaleDown),
            ),
          ),
        );
      }
    );
  }
}
