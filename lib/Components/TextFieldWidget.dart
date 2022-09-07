import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Controller/AuthProvider.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
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
  TextInputType type;
   TextFieldWidget({Key? key,required this.title, this.obscure=false,required this.prefix,required this.bottom,this.state=false,this.suffix,required this.controller,this.type=TextInputType.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context,provider,index) {
        return Container(
          margin: EdgeInsets.only(bottom:bottom),
          width: 325.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 20
              )
            ]
          ),
          child: TextField(
            textInputAction:TextInputAction.next ,
            keyboardType: type,
            obscureText:obscure ,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: green),
                borderRadius: BorderRadius.circular(10.r)
              ),
              hintText: title,
              suffixIcon: suffix,
              prefixIcon: state?
              Container(
                margin:  EdgeInsets.symmetric(horizontal: 5.w),
                child: DropdownButton<String>(
                  alignment: Alignment.center,
                  value: provider.selected,
                  icon: Container(child: Image.asset('Assets/Icons/Arrow - Down 2.png',color: green,),margin: EdgeInsets.symmetric(horizontal: 5.w),),
                  underline: SizedBox(),
                  items: provider.countries.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color:green),),
                    );
                  }).toList(),
                  onChanged: (index) {
                    provider.setCountries(index!);
                  },
                ),
              )
                  :SvgPicture.asset(prefix, fit: BoxFit.scaleDown,color: green,),
            ),
          ),
        );
      }
    );
  }
}
