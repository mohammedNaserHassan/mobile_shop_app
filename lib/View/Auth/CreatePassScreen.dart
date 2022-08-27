import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/TextFieldWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/Auth/checkEmailScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePassScreen extends StatelessWidget {
  const CreatePassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [SvgPicture.asset('Assets/Icons/Danger Circle.svg'),SizedBox(width: 10,)],
        leading: GestureDetector(
            onTap: (){
              AppRouter.appRouter.goWithReplacement(checkEmailScreen());
            },
            child: SvgPicture.asset('Assets/Icons/Stroke 1.svg',fit: BoxFit.scaleDown,)),
      ),
      body: Consumer<MobileProvider>(
        builder: (context, provider, index) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create new password',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 25,fontWeight: FontWeight.bold),
              ),
              Container(
                margin:  EdgeInsets.only(top: 16.h, bottom: 33.h),
                child: Text(
                  'Your new password must be different from\n previous used passwords.',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey,fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
               SizedBox(
                height: 44.h,
              ),
              TextFieldWidget(
                obscure:provider.obscure,
                controller: provider.password,
                suffix:GestureDetector(
                    onTap: (){
                      provider.changeobscure();
                    },
                    child:!provider.obscure? SvgPicture.asset('Assets/Icons/Hide.svg',fit: BoxFit.scaleDown,):Icon(Icons.remove_red_eye_outlined,color: grey,)),
                bottom: 0.h,
                title: 'Password',
                prefix: 'Assets/Icons/Lock.svg',
              ),
              Container(
                margin: EdgeInsets.only(right: 160.w),
                child: Text(
                  'Must be at least 8 characters.',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontSize: 11.sp),
                ),
              ),
               SizedBox(
                height: 16.h,
              ),
              TextFieldWidget(
                controller: provider.confirm,
                bottom: 24.h,
                title: 'Confirm password',
                prefix: 'Assets/Icons/Lock.svg',
              ),
              ButtonWidget(
                title: 'Confirm',
                color: green,
                function: provider.confirmPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
