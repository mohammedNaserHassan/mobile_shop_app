import 'package:flutter/material.dart';

var green = Colors.green;
var black= const Color(0xff414138);
var greyBlack = const Color(0xff1F272E);
var grey = const Color(0xff828282);
var moreBlack=const Color(0xff260029);
var light=const Color(0xffECE9F1);
var moreLight= const Color(0xffF7F7F7);
var white=const  Color(0xffFFFFFF);

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
