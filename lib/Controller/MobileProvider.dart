import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_shop_app/Helper/authHelper.dart';
import 'package:mobile_shop_app/Helper/fireStore_Helper.dart';
import 'package:mobile_shop_app/Model/Mobile.dart';
import 'package:mobile_shop_app/Model/ShoppingModel.dart';
import 'package:mobile_shop_app/Model/UserModel.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/customDialog.dart';
import 'package:mobile_shop_app/View/Auth/LoginScreen.dart';
import 'package:mobile_shop_app/View/Auth/recieveOtpScreen.dart';
import 'package:mobile_shop_app/View/Features/BoardingScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/HomeScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/Tabs/ExploreTab.dart';
import 'package:mobile_shop_app/View/TabScreens/Tabs/FavouriteTab.dart';
import 'package:mobile_shop_app/View/TabScreens/Tabs/HomeTab.dart';
import 'package:mobile_shop_app/View/TabScreens/Tabs/ProfileTab.dart';
import 'package:mobile_shop_app/View/TabScreens/Tabs/ShopTab.dart';

import '../Model/BoardModel.dart';
import '../View/Auth/SignupScreen.dart';

class MobileProvider extends ChangeNotifier {
  MobileProvider() {
    getUserFromFirestore();
  }

  //////////////////////////// Mobile Shopping////////////////////////
  List<ShoppingModel> shoppings = [
    ShoppingModel(
        name: 'Oneplus 9 pro',
        image: 'Assets/Images/banner2.png',
        number: 2,
        aed: 876,
        ram: '4/64 RAM'),
    ShoppingModel(
        name: 'Oneplus 9 pro',
        image: 'Assets/Images/banner2.png',
        number: 2,
        aed: 876,
        ram: '4/64 RAM'),
    ShoppingModel(
        name: 'Oneplus 9 pro',
        image: 'Assets/Images/banner2.png',
        number: 2,
        aed: 876,
        ram: '4/64 RAM'),
    ShoppingModel(
        name: 'Oneplus 9 pro',
        image: 'Assets/Images/banner2.png',
        number: 2,
        aed: 876,
        ram: '4/64 RAM'),
    ShoppingModel(
        name: 'Oneplus 9 pro',
        image: 'Assets/Images/banner2.png',
        number: 2,
        aed: 876,
        ram: '4/64 RAM'),
  ];

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////set Bottom Navigation ////////////////////////
  List<Widget> tabs = [
    HomeTab(),
    ShopTab(),
    ExploreTab(),
    FavouriteTab(),
    ProfileTab()
  ];
  int selectedIndex = 0;

  setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

  List<String> banners = [
    'Assets/Images/banner.png',
    'Assets/Images/banner2.png'
  ];

  clearControllers() {
    name.clear();
    email.clear();
    password.clear();
    confirm.clear();
    phone.clear();
    phone1.clear();
    phone2.clear();
    phone3.clear();
    phone4.clear();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////Get All Mobiles ///////////////////////////////////////////
  List<MobileModel> mobiles = [
    MobileModel(
        image: 'Assets/Images/mobile0.png',
        name: 'Oneplus 9',
        rating: 4.5,
        price: 945,
        favourite: true,
        isOffered: true,
        review: 3),
    MobileModel(
        image: 'Assets/Images/mobile1.png',
        name: 'Oneplus 9',
        rating: 4.5,
        price: 945,
        favourite: true,
        isOffered: true,
        review: 3),
    MobileModel(
        image: 'Assets/Images/mobile2.png',
        name: 'Oneplus 9',
        rating: 4.5,
        price: 945,
        favourite: true,
        isOffered: true,
        review: 3),
    MobileModel(
        image: 'Assets/Images/mobile3.png',
        name: 'Oneplus 9',
        rating: 4.5,
        price: 945,
        favourite: true,
        isOffered: true,
        review: 3),
  ];

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

  ////////////////////// Set up for Boarding screen///////////////////////////////////////////////////////
  Color color = Colors.green;
  List<bool> states = [true, false, false];
  PageController controller = PageController();
  List<Board> boards = [
    Board(
        title: 'Get the Best Smartphone ',
        image: 'Assets/Images/Boarding/1.png',
        subtitle:
            'Lorem Ipsum is simply dummy text of the \n printing and typesetting..'),
    Board(
        title: 'Great experince with \n our product ',
        image: 'Assets/Images/Boarding/2.png',
        subtitle:
            'Lorem Ipsum is simply dummy text of the \n printing and typesetting..'),
    Board(
        title: 'Get product from at home ',
        image: 'Assets/Images/Boarding/3.png',
        subtitle:
            'Lorem Ipsum is simply dummy text of the \n  printing and typesetting..'),
  ];

  scrollChange(int index) {
    controller.animateToPage(index,
        duration: Duration(seconds: 2), curve: Curves.bounceOut);
    states.fillRange(0, 3, false);
    states[index] = true;
    notifyListeners();
  }

  scrollIndex(int index) {
    if (index < 2) {
      controller.animateToPage(index + 1,
          duration: Duration(seconds: 2), curve: Curves.fastLinearToSlowEaseIn);
      states.fillRange(0, 3, false);
      states[index] = true;
    } else {
      AppRouter.appRouter.goWithReplacement(SignupScreen());
    }
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /////Sign up///////////////////////////////////////////
  register() async {
    if (name.text.length != 0 &&
        email.text.length != 0 &&
        password.text.length != 0 &&
        confirm.text.length != 0 &&
        check) {
      if (password.text == confirm.text) {
        if (check) {
          try {
            UserCredential? userCredential =
                await Auth_helper.auth_helper.signup(email.text, password.text);
            UserModel registerRequest = UserModel(
              id: userCredential?.user?.uid ?? "",
              email: email.text,
              name: name.text,
            );
            await fireStore_Helper.helper.addUserToFireBase(registerRequest);
            await Auth_helper.auth_helper.signOut();
            clearControllers();
            AppRouter.appRouter.goWithReplacement(LoginScreen());
          } on Exception catch (e) {
            print(e);
          }
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

  /////////// Send OTP to mobile number///////////
  sendOtp() {
    if (phone.text.length != 0) {
      AppRouter.appRouter.goWithReplacement(recieveOtpScreen());
    } else {
      CustomDialog.customDialog.showCustom('Please enter your phone');
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /////////// Verify OTP code sent/////////////////////////////////
  verifyphonenumber() {
    if (phone1.text.length != 0 &&
        phone2.text.length != 0 &&
        phone3.text.length != 0 &&
        phone4.text.length != 0) {
      AppRouter.appRouter.goWithReplacement(LoginScreen());
    } else {
      CustomDialog.customDialog.showCustom('Please enter verification number');
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////

  /////////// Check Tile for Registration//////////////////////
  bool check = false;

  changeCheck() {
    check = !check;
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////// Confirm Password/////////////////////////////////
  confirmPassword() {
    if (password.text.length != 0 && confirm.text.length != 0) {
      if (password.text == confirm.text) {
        AppRouter.appRouter.goWithReplacement(LoginScreen());
      } else {
        CustomDialog.customDialog.showCustom('Password not matched');
      }
    } else {
      CustomDialog.customDialog.showCustom('Please fill the fields');
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////Reset Password////////////////////////////////////////////////////////////////////////////
  resetPassword() async {
    if (email.text.length != 0) {
      await Auth_helper.auth_helper.resetPassword(email.text.trim());
      clearControllers();
      AppRouter.appRouter.goWithReplacement(LoginScreen());
      CustomDialog.customDialog
          .showCustom('Check  your email to reset password');
    } else {
      CustomDialog.customDialog.showCustom('Please Enter your email address');
    }
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////Login////////////////////////////////////
  String? userId;

  login() async {
    if (email.text.length != 0 && password.text.length != 0) {
      UserCredential? userCredential =
          await Auth_helper.auth_helper.signin(email.text, password.text);
      await fireStore_Helper.helper.getUserFromFirestore();
      userId = Auth_helper.auth_helper.getUserId();
      clearControllers();
      AppRouter.appRouter.goWithReplacement(HomeScreen());
    } else {
      CustomDialog.customDialog.showCustom("Please fill all the fields");
    }
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /////////// Get User from FireStore ///////////////////////////////////////////////////////
  UserModel user = UserModel(name: '', email: '', id: '');

  getUserFromFirestore() async {
    user = await fireStore_Helper.helper.getUserFromFirestore();
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////Check if user found//////////////////////////
  checkEnter() {
    bool isLoggin = Auth_helper.auth_helper.checkUser();
    if (isLoggin) {
      this.userId = Auth_helper.auth_helper.getUserId();
      getUserFromFirestore();
      AppRouter.appRouter.goWithReplacement(HomeScreen());
    } else {
      AppRouter.appRouter.goWithReplacement(BoardingScreen());
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////Sign out////////////////////////////////////
  logOut() async {
    await Auth_helper.auth_helper.signOut();
    userId = null;
    this.selectedIndex = 0;
    AppRouter.appRouter.goWithReplacement(LoginScreen());
    notifyListeners();
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}
