import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/MixTextWidget.dart';
import 'package:mobile_shop_app/Components/RowLineWidget.dart';
import 'package:mobile_shop_app/Components/TextFieldWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/Auth/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Consumer<MobileProvider>(builder: (context, provider, index) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 40.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MixTextWidget(text1: 'Sign', text2: 'Up'),
              Text(
                'Create a new account!',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 24.sp),
              ),
              SizedBox(
                height: 70.h,
              ),
              TextFieldWidget(
                controller: provider.name,
                bottom: 14.h,
                title: 'Full name',
                prefix: 'Assets/Icons/Profile.svg',
              ),
              TextFieldWidget(
                controller: provider.email,
                bottom: 14.h,
                title: 'Email or Phone',
                prefix: 'Assets/Icons/email.svg',
              ),
              TextFieldWidget(
                controller: provider.password,
                bottom: 14.h,
                title: 'Password',
                prefix: 'Assets/Icons/Lock.svg',
              ),
              TextFieldWidget(
                controller: provider.confirm,
                bottom: 8.h,
                title: 'Confirm Password',
                prefix: 'Assets/Icons/Lock.svg',
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: provider.changeCheck,
                    child: Stack(
                      children: [
                        Image.asset(
                          'Assets/Images/Rectangle 59.png',scale: 0.9,
                        ),
                          Visibility(
                            visible: provider.check,
                            child: Icon(
                              Icons.check,
                              color: green,
                              size: 14.sp,
                            ),
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    'Agree with trams and condition.',
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              ButtonWidget(
                  title: 'Sign Up', color: black, function: provider.register),
              SizedBox(
                height: 90.h,
              ),
              RowLineWidget(
                  function: LoginScreen(),
                  text1: 'Have an account?',
                  text2: ' Log In')
            ],
          ),
        );
      }),
    );
  }
}
