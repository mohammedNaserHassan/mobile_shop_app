import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Controller/AuthProvider.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/Auth/CreatePassScreen.dart';
import 'package:mobile_shop_app/View/Auth/ResetPassScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class checkEmailScreen extends StatelessWidget {
  const checkEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          SvgPicture.asset('Assets/Icons/DangerCircle.svg'),
          SizedBox(width: 10.w,)
        ],
        leading: GestureDetector(
            onTap: (){
              AppRouter.appRouter.goWithReplacement(ResetPassScreen());
            },
            child: SvgPicture.asset('Assets/Icons/Stroke 1.svg',fit: BoxFit.scaleDown,)),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, index) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: Color(0xffEBF5EA),
                  radius: 100.r,
                  child: Image.asset(
                    'Assets/Images/otp.png',
                  )),
              SizedBox(
                height: 44.h,
              ),
              Text(
                'Check your mail',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 25,fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.h, bottom: 33.h),
                child: Text(
                  'We have sent a password recover instructions to\n your email.',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey,fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              ButtonWidget(
                title: 'Open email',
                color: green,
                function: provider.openEmail,
              ),
              SizedBox(height: 10.h,),
              ButtonWidget(
                textColor:black,
                title: 'i’ll confirm latter',
                color:  Color(0xffEBF5EA),
                function: (){
                  AppRouter.appRouter.goWithReplacement(CreatePassScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
