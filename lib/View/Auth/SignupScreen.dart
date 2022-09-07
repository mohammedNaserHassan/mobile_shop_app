import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/MixTextWidget.dart';
import 'package:mobile_shop_app/Components/RowLineWidget.dart';
import 'package:mobile_shop_app/Components/TextFieldWidget.dart';
import 'package:mobile_shop_app/Controller/AuthProvider.dart';
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
      body: Consumer<AuthProvider>(builder: (context, provider, index) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 40.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              MixTextWidget(text1: 'Sign', text2: 'Up'),
              Text(
                'Create a new account!',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 18.sp, color: Colors.grey),
              ),
              SizedBox(
                height: 70.h,
              ),
            ListView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: [
                TextFieldWidget(
                  controller: provider.name,
                  bottom: 14.h,
                  title: 'Full name',
                  prefix: 'Assets/Icons/Profile.svg',
                ),
                TextFieldWidget(
                  controller: provider.email,
                  bottom: 14.h,
                  title: 'Email',
                  prefix: 'Assets/Icons/email.svg',
                ),
                TextFieldWidget(
                  type: TextInputType.phone,
                  state: true,
                  controller: provider.phone,
                  bottom: 14.h,
                  title: 'Phone number',
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
              ],
            ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                checkColor: green,
                  controlAffinity:ListTileControlAffinity.leading,
                  activeColor: green,
                  value: provider.check,
                  onChanged: (val) {
                    provider.changeCheck(val??false);
                  },
                  title: Text(
                    'Agree with trams and condition.',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: grey,),
                  )),
              SizedBox(
                height: 40.h,
              ),
              provider.isRegister?Center(child: CircularProgressIndicator()):     ButtonWidget(
                  title: 'Sign Up', color: black, function: provider.register),
              Spacer(),
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
