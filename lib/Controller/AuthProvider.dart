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
import 'package:mobile_shop_app/View/TabScreens/HomeScreen.dart';
import 'package:open_mail_app/open_mail_app.dart';

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
              .showCustom('You should accept and agree of the terms');
        }
      } else {
        CustomDialog.customDialog.showCustom('Password not match');
      }
    } else {
      CustomDialog.customDialog.showCustom('Please fill all the fields');
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
      CustomDialog.customDialog.showCustom('Please enter verification number');
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
      CustomDialog.customDialog.showCustom('Please fill the fields');
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
          .showCustom('Check  your email to reset password');
    } else {
      CustomDialog.customDialog.showCustom('Please Enter your email address');
    }
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////Login////////////////////////////////////
  RegisterUser userEnter = RegisterUser();
  bool isLoading = false;

  login() async {
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
          clearControllers();
          AppRouter.appRouter.goWithReplacement(HomeScreen());
        } else {
          CustomDialog.customDialog.showCustom(userEnter.message ?? '');
          isLoading = false;
          notifyListeners();
        }
      });
      notifyListeners();
    } else {
      CustomDialog.customDialog.showCustom("Please fill all the fields");
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////Sign out////////////////////////////////////
  logOut() async {
    isLoading = false;
    DioHelper.dioHelper.postData(
      url: LOGOUT,
      data: {'fcm_token': token},
    );
    SharedPreferencesHelper.x.removeVerify();
    SharedPreferencesHelper.x.removeName();
    AppRouter.appRouter.goWithReplacement(LoginScreen());
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}