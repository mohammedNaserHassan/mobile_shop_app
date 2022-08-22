import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
      builder:(c,provider,i)=> Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: provider.logOut, icon: Icon(Icons.login,color: Colors.black,))
          ],
        ),
        body: Column(
          children:const [
            Text('Home Screen')
          ],
        ),
      ),
    );
  }
}
