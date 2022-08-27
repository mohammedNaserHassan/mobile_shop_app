import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();
  static AppRouter appRouter = AppRouter._();
  GlobalKey<NavigatorState> navkey = GlobalKey<NavigatorState>();

  gotoPage(String routeName) {
    navkey.currentState?.pushNamed(routeName);
  }

  gotoPagewithReplacment(String routeName) {
    navkey.currentState?.pushReplacementNamed(routeName);
  }

  goWithInternalAnimation(Widget widget) {
    navkey.currentState?.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        barrierColor: Colors.orangeAccent.withOpacity(0.1),
        transitionDuration: Duration(seconds: 1),
      ),
    );
  }

  goWithReplacement(Widget widget) {
    navkey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (_) => widget));
  }

  back() {
    navkey.currentState?.pop();
  }
}
