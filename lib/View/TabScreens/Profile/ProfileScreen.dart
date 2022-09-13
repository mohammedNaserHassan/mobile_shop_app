import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/TextFieldWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/Auth/CreatePassScreen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 100.h,
            leading: IconButton(
              onPressed: () {
                AppRouter.appRouter.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: black,
              ),
            ),
            centerTitle: true,
            title: Text(
              'Profile'.tr(),
              style: Theme.of(context).textTheme.headline5,
            ),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    provider.selectFile();
                  },
                  child: provider.file == null
                      ? FadeInImage.assetNetwork(
                    placeholder: 'Assets/Images/profile.png',
                    image: provider.profileModel.data?.image?? 'Assets/Images/profile.png',
                    fit: BoxFit.cover,
                    height: 70.h,
                  )
                      : CircleAvatar(
                    radius: 50.r,
                    backgroundImage: FileImage(provider.file!),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                    child: Divider(
                      color: light,
                    )),
                TextFieldWidget(title: '', prefix: '', bottom: 10.h, controller: provider.phoneEdit),
                TextFieldWidget(title: '', prefix: '', bottom: 10.h, controller: provider.nameEdit),
                TextFieldWidget(title: '', prefix: '', bottom: 10.h, controller: provider.emailEdit),
                TextFieldWidget(title:  'yourpassword'.tr(), prefix: '', bottom: 0, controller: provider.passwordEdit),
                Align(
                  alignment: Alignment.center,
                    child: Text('Alternatemobilenumberdetails'.tr(),style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold,fontSize: 16.sp),)),
                TextFieldWidget(title:  '', prefix: '', bottom: 10.h, controller: provider.phoneEdit),
                Text('Thiswill'.tr(),style: Theme.of(context).textTheme.bodySmall?.copyWith(color: grey)),
                TextFieldWidget(title:  '', prefix: '', bottom: 10.h, controller: provider.nameEdit),
                Text('Addname'.tr(),style: Theme.of(context).textTheme.bodySmall?.copyWith(color: grey),),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  child: ButtonWidget(
                    isBorder: true,
                    textColor: grey,
                      title: 'Changepassword'.tr(),
                      color: Colors.transparent,
                      function: () {
                        AppRouter.appRouter.goToPage(CreatePassScreen());
                      }),
                ),
        provider.isUpdate?CircularProgressIndicator():  ButtonWidget(title: 'Edit'.tr(), color: green, function: provider.updateProfile)
              ],
            ),
          ),
        );
      },
    );
  }
}
