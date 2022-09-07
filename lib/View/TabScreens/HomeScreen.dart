import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/TabScreens/Tabs/HomeTab.dart';
import 'package:provider/provider.dart';
import 'package:bottom_navigation_view/bottom_navigation_view.dart';
class ShowProgress extends StatelessWidget {
  const ShowProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<MobileProvider>(context,listen: false).getMobiles();
    Future.delayed(Duration(seconds: 3)).then((value) {
      AppRouter.appRouter.goWithInternalAnimation(HomeScreen());

    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: LinearProgressIndicator(color: green,minHeight: 5.h),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>   with SingleTickerProviderStateMixin {
  late final BottomNavigationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BottomNavigationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
      builder: (c, provider, i) => Scaffold(
        bottomNavigationBar: BottomNavigationIndexedBuilder(
          controller: _controller,
          builder: (context, index, child) {
            return BottomNavigationBar(
              currentIndex: provider.selectedIndex,
              onTap: (index) {
                _controller.goTo(index);
                provider.setIndex(index);
              },
              type: BottomNavigationBarType.shifting,
              items:  [
                BottomNavigationBarItem(label: '', icon: bottomItem(index: 0,icon: 'Home',)),
                BottomNavigationBarItem(label: '', icon: bottomItem(index: 1,icon: 'Buy',)),
                BottomNavigationBarItem(label: '', icon: bottomItem(index: 2,icon: 'Discovery',)),
                BottomNavigationBarItem(label: '', icon: bottomItem(index: 3,icon: 'Star',)),
                BottomNavigationBarItem(label: '', icon: bottomItem(index: 4,icon: 'Profile',)),
              ],
            );
          },
        ),
        body:    BottomNavigationView(
          controller: _controller,
          transitionType: BottomNavigationTransitionType.fadeInOut,
          backgroundColor: Colors.lime,
          children: provider.tabs,
          ),
        )
    );
  }
}

class bottomItem extends StatelessWidget {
  String icon;
  int index;
  bottomItem({required this.icon,required this.index});
  @override
  Widget build(BuildContext context) {
    return Selector<MobileProvider,int>(
      selector: (context,selected)=>selected.selectedIndex,
      builder:(context,data,child)=> Container(
          width: 35.w,
          height: 35.h,
         decoration: BoxDecoration(
           color:  data==index?Colors.green:Colors.transparent,
           borderRadius: BorderRadius.circular(5.r)
         ),
          child: SvgPicture.asset('Assets/Icons/${icon}.svg',color:  data==index?Colors.white:Colors.grey,fit: BoxFit.scaleDown,)),
    );
  }
}
