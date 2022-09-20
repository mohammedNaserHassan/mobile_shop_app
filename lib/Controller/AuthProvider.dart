import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Helper/DioHelper.dart';
import 'package:mobile_shop_app/Helper/SharedPreferencesHelper.dart';
import 'package:mobile_shop_app/Model/UserModel.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/Services/customDialog.dart';
import 'package:mobile_shop_app/View/Auth/LoginScreen.dart';
import 'package:mobile_shop_app/View/Auth/checkEmailScreen.dart';
import 'package:mobile_shop_app/View/Auth/recieveOtpScreen.dart';
import 'package:mobile_shop_app/View/Features/HomeScreen.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier{
  //////////////////////// Controllers//////////////////////////
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phone1 = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  TextEditingController phone3 = TextEditingController();
  TextEditingController phone4 = TextEditingController();

  clearControllerWithEmail() {
    clearControllers();
    email.clear();
  }

  clearControllers() {
    name.clear();
    phone.clear();
    password.clear();
    confirm.clear();
    phone1.clear();
    phone2.clear();
    phone3.clear();
    phone4.clear();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////Password Text Field//////////////////////
  bool obscure = true;

  changeobscure() {
    obscure = !obscure;
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////Country codeNumber for Mobile number////////////////////////////////////////////
  List<String> countries = ['+00', '+972', '+90', '+91'];
  String selected = '+00';

  setCountries(String x) {
    selected = x;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////Sign up///////////////////////////////////////////
  bool isRegister = false;
  String image = '';
  String token = '';

  register() async {
    if (name.text.length != 0 &&
        email.text.length != 0 &&
        password.text.length != 0 &&
        confirm.text.length != 0 &&
        phone.text.length != 0 &&
        check) {
      if (password.text == confirm.text) {
        if (check) {
          isRegister = true;
          DioHelper.dioHelper.postData(url: REGISTER, data: {
            'name': name.text,
            'email': email.text,
            'password': password.text,
            'phone': phone.text,
            'image': image
          }).then((value) {
            RegisterUser register = RegisterUser.fromJson(value?.data);
            if (register.status ?? false) {
              AppRouter.appRouter.goToPage(recieveOtpScreen());
              CustomDialog.customDialog.showCustom(register.message ?? '');
              clearControllers();
              isRegister = false;
              notifyListeners();
            } else {
              CustomDialog.customDialog.showCustom(register.message ?? '');
              isRegister = false;
              notifyListeners();
            }
          });
        } else {
          CustomDialog.customDialog
              .showCustom('myCondition'.tr());
        }
      } else {
        CustomDialog.customDialog.showCustom('passwordNotmatch'.tr());
      }
    } else {
      CustomDialog.customDialog.showCustom('fillFields'.tr());
    }
    notifyListeners();
  }

///////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /////////// Verify OTP code sent/////////////////////////////////
  bool isVerified = false;

  verifyphonenumber() {
    if (phone1.text.length != 0 &&
        phone2.text.length != 0 &&
        phone3.text.length != 0 &&
        phone4.text.length != 0) {
      isVerified = true;
      DioHelper.dioHelper.postData(url: VERIFY_CODE, data: {
        "code": phone1.text + phone2.text + phone3.text + phone4.text,
        "email": email.text
      }).then((value) {
        // if (value?.data['status']) {
        clearControllers();
        AppRouter.appRouter.goWithReplacement(LoginScreen());
        CustomDialog.customDialog.showCustom(value?.data['message']);
        clearControllerWithEmail();
      });
      notifyListeners();
    } else {
      CustomDialog.customDialog.showCustom('enterVerification'.tr());
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////

  /////////// Check Tile for Registration//////////////////////
  bool check = false;

  changeCheck(bool val) {
    check = val;
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////// Change Password/////////////////////////////////
  bool isConform = false;

  confirmPassword() {
    if (password.text.length != 0 && confirm.text.length != 0) {
      isConform = true;
      DioHelper.dioHelper.customPostData(
        url: CHANGE_PASSWORD,
        data: {"current_password": password.text, "new_password": confirm.text},
      ).then((value) {
        if (value?.data['status']) {
          AppRouter.appRouter.back();
          CustomDialog.customDialog.showCustom(value?.data['message']);
          clearControllerWithEmail();
        } else {
          isConform = false;
          CustomDialog.customDialog.showCustom(value?.data['message']);
          notifyListeners();
        }
      });
    } else {
      CustomDialog.customDialog.showCustom('fillFields'.tr());
    }
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /////////////////Open Email App//////////////////////////
  openEmail() async {
    var result = await OpenMailApp.openMailApp();
    if (!result.didOpen && !result.canOpen) {
      CustomDialog.customDialog.showCustom('Opened Email');
    } else if (!result.didOpen && result.canOpen) {
      CustomDialog.customDialog.showCustom('Opened Email', (_) {
        return MailAppPickerDialog(
          mailApps: result.options,
        );
      });
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////Reset Password////////////////////////////////////////////////////////////////////////////
  resetPassword() async {
    if (email.text.length != 0) {
      clearControllers();
      AppRouter.appRouter.goWithReplacement(checkEmailScreen());
      CustomDialog.customDialog
          .showCustom('checkEmailPass'.tr());
    } else {
      CustomDialog.customDialog.showCustom('enterEmail'.tr());
    }
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////Login////////////////////////////////////
  RegisterUser userEnter = RegisterUser();
  bool isLoading = false;

  login() async {
    final mobile =  Provider.of<MobileProvider>(AppRouter.appRouter.navkey.currentContext!,listen: false);
    if (email.text.length != 0 && password.text.length != 0) {
      isLoading = true;
      DioHelper.dioHelper.postData(
        url: LOGIN,
        data: {'email': email.text, 'password': password.text},
      ).then((value) {
        userEnter = RegisterUser.fromJson(value?.data);
        SharedPreferencesHelper.x.saveVerify(userEnter.status ?? false);
        if (userEnter.status ?? false) {
          SharedPreferencesHelper.x.saveName(userEnter.data?.token ?? '');
          clearControllerWithEmail();
          mobile.getRequest();
          Future.delayed(Duration(seconds: 2)).then((value) =>   AppRouter.appRouter.goWithReplacement(HomeScreen()));
        } else {
          CustomDialog.customDialog.showCustom(userEnter.message ?? '');
          isLoading = false;
          notifyListeners();
        }
      });
      notifyListeners();
    } else {
      CustomDialog.customDialog.showCustom("fillFields".tr());
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////Sign out////////////////////////////////////
  logOut() async {
  final mobile =  Provider.of<MobileProvider>(AppRouter.appRouter.navkey.currentContext!,listen: false);
    isLoading = false;
  mobile.setIndex(0);
    DioHelper.dioHelper.postData(
      url: LOGOUT,
      data: {'fcm_token': SharedPreferencesHelper.x.getName()},
    );
    SharedPreferencesHelper.x.removeVerify();
    SharedPreferencesHelper.x.removeName();
    AppRouter.appRouter.goWithReplacement(LoginScreen());
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}