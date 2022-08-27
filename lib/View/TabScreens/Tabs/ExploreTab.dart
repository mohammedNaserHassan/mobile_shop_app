import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/MobileItemWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
class ExploreTab extends StatelessWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Explore',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        actions: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
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
                    items: provider.banners.map((e) =>
                        Container(
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
                  leading: Text('Best Seller',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                  trailing: Text(
                    'See All',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemExtent: 200,
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.mobiles.length,
                    itemBuilder: (context,index)=>MobileItemWidget(mobileModel: provider.mobiles[index]),),
                ),
                ListTile(
                  leading: Text('Top Trends',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  trailing: Text(
                    'See All',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemExtent: 200,
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.mobiles.length,
                    itemBuilder: (context,index)=>MobileItemWidget(mobileModel: provider.mobiles[index]),),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
