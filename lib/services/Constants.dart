import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Model/BoardModel.dart';

////////////API//////////////////////
var baseUrl = 'https://student.valuxapps.com/api/';
var LOGIN = 'login';
var REGISTER = 'register';
var LOGOUT = 'logout';
var PROFILES = 'profile';
var VERIFY_EMAIL = 'verify-email';
var VERIFY_CODE = 'verify-code';
var RESET_PASSWORD = 'reset-password';
var UPDATE_PROFILE = 'update-profile';
var CHANGE_PASSWORD = 'change-password';
var BANNERS = 'banners';
var HOME = 'home';
var FAVORRITE = 'favorites';
var CARDS = 'carts';
var SEARCH = 'products/search';
var CATEGORIE = 'categories';
var NOTIFICATION = 'notifications';
var UPDATEPROFILE = 'update-profile';
var Address = 'addresses';
var SETTINGS = 'settings';
var QUESTIONs = 'faqs';
var COMPLAINTS = 'complaints';
var ORDERS = 'orders';
/////////////////////////////////////////////////////////////////////////////////////////////////

/////////////Boards of Boarding Screen/////////////////////
List<Board> boards = [
  Board(
      title: 'TitleBorad'.tr(),
      image: 'Assets/Images/Boarding/1.png',
      subtitle:
      'SubtitleBoard'.tr()),
  Board(
      title:  'TitleBorad'.tr(),
      image: 'Assets/Images/Boarding/2.png',
      subtitle:
      'SubtitleBoard'.tr()),
  Board(
      title:  'TitleBorad'.tr(),
      image: 'Assets/Images/Boarding/3.png',
      subtitle:
      'SubtitleBoard'.tr()),
];
/////////////////////////////////////////////////////////////////////////////////////////////////

//////////////Colors////////////////////////////////////////////////
var green = Colors.green;
var lightGreen = Color(0xff38972E);
var black= const Color(0xff414138);
var greyBlack = const Color(0xff1F272E);
var grey = const Color(0xff828282);
var moreBlack=const Color(0xff260029);
var light=const Color(0xffECE9F9);
var moreLight= const Color(0xffF7F7F7);
var white=const  Color(0xffFFFFFF);
//////////////////////////////////////////////////////////////////////////////////////////////////

////////////Theme////////////////////////////////////////
ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: moreLight,
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: moreLight
  ),
  fontFamily: 'OpenSans',
  brightness: Brightness.light,
  primaryColor: green,
  hintColor: grey,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: green,
    unselectedItemColor: grey
  ),
 //  textTheme: TextTheme(
 //    bodyText1:  const TextStyle(
 //      fontWeight: FontWeight.bold,
 //      fontSize: 22,),
 // //   subtitle1:  TextStyle(color: grey, fontSize: 14),
 //    bodyText2: const TextStyle(fontWeight: FontWeight.bold,fontSize: 35),
 //    bodySmall: TextStyle(fontSize: 11),
 //    button: TextStyle(fontSize: 17,)
 //  )
);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
