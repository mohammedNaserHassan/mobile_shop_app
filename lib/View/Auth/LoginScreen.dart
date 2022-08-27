import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/MixTextWidget.dart';
import 'package:mobile_shop_app/Components/RowLineWidget.dart';
import 'package:mobile_shop_app/Components/TextFieldWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/Auth/ResetPassScreen.dart';
import 'package:mobile_shop_app/View/Auth/SignupScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<MobileProvider>(
        builder: (context,provider,index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Container(
                  margin: EdgeInsets.only(left: 40.h,bottom: 30.h),
                  child: MixTextWidget(text1: 'Welcome', text2: 'back!')),
              Center(
                child: TextFieldWidget(
                  controller: provider.email,
                    title: 'example@gmail.com',
                    prefix: 'Assets/Icons/Profile.svg',
                    bottom: 14.h),
              ),
              Center(
                child: TextFieldWidget(
                  controller: provider.password,
                    title: 'password', prefix: 'Assets/Icons/Lock.svg', bottom: 14.h),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){
                    AppRouter.appRouter.goWithReplacement(ResetPassScreen());
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 35.w,bottom: 40.h),
                    child: Text(
                      'Forget password?',
                      style:
                          Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 12.sp),
                    ),
                  ),
                ),
              ),
              Center(child: ButtonWidget(title: 'Log in', color: black, function:provider.login)),
             Spacer(),
              RowLineWidget(text1: 'Haven’t an account? ', text2: 'Sign up',function: SignupScreen(),)
            ],
          );
        }
      ),
    );
  }
}
