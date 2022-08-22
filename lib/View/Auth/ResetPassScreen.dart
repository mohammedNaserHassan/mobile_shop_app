import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/TextFieldWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/Auth/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ResetPassScreen extends StatelessWidget {
  const ResetPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
        actions: [
        SvgPicture.asset('Assets/Icons/Danger Circle.svg',fit: BoxFit.scaleDown,),
          SizedBox(width: 10.w,)
    ],
    leading: GestureDetector(
        onTap: (){
          AppRouter.appRouter.goWithReplacement(LoginScreen());
        },
        child: SvgPicture.asset('Assets/Icons/Stroke 1.svg',fit: BoxFit.scaleDown,)),),
      body: Consumer<MobileProvider>(
        builder: (context, provider, index) => Center(
          child: Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              Text(
                'Reset password',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Container(
                margin: EdgeInsets.only(top: 16.h, bottom: 33.h),
                child: Text(
                  'Enter the email associated with your account and \n we’ll send an email with instructions to reset your\n password!',
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24.h,),
              TextFieldWidget(
                controller: provider.email,
                bottom:24 ,
                title: 'Email address',
                prefix: '',
              ),
              ButtonWidget(
                title: 'Next',
                color: green,
                function: provider.resetPassword,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
