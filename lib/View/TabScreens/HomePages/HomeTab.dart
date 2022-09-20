import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/MobileItemWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/TabScreens/HomePages/Action/CategoryPage.dart';
import 'package:mobile_shop_app/View/TabScreens/HomePages/Action/SearchPage.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/Settings/Action/NotificationPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        toolbarHeight: 100.h,
        title: Text(
          'Home'.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            AppRouter.appRouter.goToPage(CategoryPage());
          },
          child: SvgPicture.asset(
            'Assets/Icons/drawer.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              AppRouter.appRouter.goToPage(SearchPage());
            },
              child: Icon(Icons.search,color: black,size: 30.sp,)),
          GestureDetector(
            onTap: (){
              AppRouter.appRouter.goToPage(NotificationPage());
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: SvgPicture.asset('Assets/Icons/Group1.svg',
                    fit: BoxFit.scaleDown)),
          ),
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
                            provider.ads??'Assets/Images/banner2.png',
                          ),
                          fit: BoxFit.fill)),
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                ),
                ListTile(
                  leading: Text('PopularItem'.tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  trailing: GestureDetector(
                    onTap: (){
                      AppRouter.appRouter.goToPage(CategoryPage());
                    },
                    child: Text(
                      'SeeAll'.tr(),
                      style: TextStyle(color: Colors.green),
                    ),
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
                    itemBuilder: (context, index) =>
                        MobileItemWidget(mobileModel: provider.products[index]))
              ],
            );
          },
        ),
      ),
    );
  }
}
