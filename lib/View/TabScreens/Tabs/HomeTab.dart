import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/MobileItemWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        leading: SvgPicture.asset(
          'Assets/Icons/drawer.svg',
          fit: BoxFit.scaleDown,
        ),
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
                CarouselSlider(
                    items: provider.banners
                        .map((e) => Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage(e))),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
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
                  leading: Text('Popular Item',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  trailing: Text(
                    'See All',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                GridView(
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
                  children: provider.mobiles
                      .map((e) => MobileItemWidget(mobileModel: e))
                      .toList(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
