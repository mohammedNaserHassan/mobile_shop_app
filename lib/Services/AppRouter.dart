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
          return FadeTransition(
            opacity: animation,
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

  goToPage(Widget widget) {
    navkey.currentState
        ?.push(MaterialPageRoute(builder: (_) => widget));
  }

  back() {
    navkey.currentState?.pop();
  }
}
