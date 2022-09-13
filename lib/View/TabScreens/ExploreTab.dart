import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/MobileItemWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        title: Text(
          'Explore'.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        actions: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: SvgPicture.asset('Assets/Icons/notification.svg',
                  fit: BoxFit.scaleDown)),
        ],
      ),
      body: Consumer<MobileProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                    items: provider.banners
                        ?.map((e) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 25.w),
                            width: double.infinity,
                            child: Image.network(
                              e.image ?? 'Assets/Images/banner2.png',
                              fit: BoxFit.fill,
                            )))
                        .toList(),
                    options: CarouselOptions(
                      height: 200.h,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    )),
                ListTile(
                  leading: Text('BestSeller'.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.sp)),
                  trailing: Text(
                    'SeeAll'.tr(),
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                Container(
                    height: 320.h,
                    child: ListView.builder(
                      itemExtent: 200.w,
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.searchModels.length,
                      itemBuilder: (context, index) => MobileItemWidget(
                          mobileModel: provider.searchModels[index]),
                    )),
                ListTile(
                  leading: Text(
                    'TopTrends'.tr(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  trailing: Text(
                    'SeeAll'.tr(),
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                SizedBox(
                  height: 320.h,
                  child: ListView.builder(
                    itemExtent: 200.w,
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.searchSModels.length,
                    itemBuilder: (context, index) => MobileItemWidget(
                        mobileModel: provider.searchSModels[index]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
