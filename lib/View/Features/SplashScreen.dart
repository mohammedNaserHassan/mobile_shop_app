import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:provider/provider.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<MobileProvider>(context,listen:false).checkEnter();
    return SafeArea(
        child: Container(
          color: Colors.white,
          child: Image.asset(
            'Assets/Images/splash.png',
          ),
        ));
  }
}
