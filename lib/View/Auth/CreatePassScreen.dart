import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/TextFieldWidget.dart';
import 'package:mobile_shop_app/Controller/AuthProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePassScreen extends StatelessWidget {
  const CreatePassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [SvgPicture.asset('Assets/Icons/DangerCircle.svg'),SizedBox(width: 10,)],
        leading: IconButton(
          onPressed: () {
            AppRouter.appRouter.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, index) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Createnewpassword'.tr(),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 25,fontWeight: FontWeight.bold),
              ),
              Container(
                margin:  EdgeInsets.only(top: 16.h, bottom: 33.h),
                child: Text(
                  'PasswordCondition'.tr(),
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
                title: 'Password'.tr(),
                prefix: 'Assets/Icons/Lock.svg',
              ),
              Container(
                margin: EdgeInsets.only(right: 160.w),
                child: Text(
                  'passCondition'.tr(),
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
                title: 'Confirmpassword'.tr(),
                prefix: 'Assets/Icons/Lock.svg',
              ),
         provider.isConform?Center(child: CircularProgressIndicator(),):     ButtonWidget(
                title: 'Confirm'.tr(),
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
