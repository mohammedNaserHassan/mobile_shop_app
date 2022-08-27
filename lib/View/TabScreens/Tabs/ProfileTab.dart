import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<MobileProvider>(
  builder: (context, provider, child) {
  return Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'Assets/Images/profile.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    provider.user.name,
                    style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Divider(
                  color: light,
                )),
            profileTile(title: 'Settings', icon: 'Setting',function: (){}),
            profileTile(title: 'Order Tracking', icon: 'rack',function: (){}),
            profileTile(title: 'Payment Method', icon: 'payment',function: (){}),
            profileTile(title: 'My purchess', icon: 'Wallet',function: (){}),
            profileTile(title: 'Address', icon: 'Location',function: (){}),
            profileTile(title: 'Privacy', icon: 'privacy',function: (){}),
            profileTile(title: 'Log out', icon: 'Logout',function:provider.logOut),
          ],
        );
  },
),
      ),
    );
  }
}

class profileTile extends StatelessWidget {
  String title, icon;
  Function() function;

  profileTile({
    required this.icon,
    required this.title,
    required this.function
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: function,
        leading: SvgPicture.asset('Assets/Icons/${icon}.svg'),
        title: Text(
          title,
          style: TextStyle(color: green),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    );
  }
}
