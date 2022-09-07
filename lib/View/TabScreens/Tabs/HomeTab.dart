import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/MobileItemWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        toolbarHeight: 100.h,
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: SvgPicture.asset(
              'Assets/Icons/drawer.svg',
              fit: BoxFit.scaleDown,
            ),
          );
        }),
        actions: [
          SvgPicture.asset('Assets/Icons/search.svg', fit: BoxFit.scaleDown),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: SvgPicture.asset('Assets/Icons/notification.svg',
                  fit: BoxFit.scaleDown)),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<MobileProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          image: NetworkImage(
                            provider.ads,
                          ),
                          fit: BoxFit.fill)),
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                ),
                ListTile(
                  leading: Text('Popular Item',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  trailing: Text(
                    'See All',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 300,
                    ),
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) => MobileItemWidget(
                            mobileModel: provider.products[index])
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
