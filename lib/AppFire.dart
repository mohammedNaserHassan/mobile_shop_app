import 'package:flutter/material.dart';
import 'package:mobile_shop_app/View/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

class AppFire extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Container(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return SplashScreen();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
