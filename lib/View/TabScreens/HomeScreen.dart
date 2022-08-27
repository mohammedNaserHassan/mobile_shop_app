import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:provider/provider.dart';
import 'package:bottom_navigation_view/bottom_navigation_view.dart';

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
        body:Consumer<MobileProvider>(
            builder: (cont,provider,index)=>BottomNavigationView(
          controller: _controller,
          transitionType: BottomNavigationTransitionType.fadeInOut,
          backgroundColor: Colors.lime,
          children: provider.tabs,
          ),
        )
      ),
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
          width: 35,
          height: 35,
         decoration: BoxDecoration(
           color:  data==index?Colors.green:Colors.transparent,
           borderRadius: BorderRadius.circular(5)
         ),
          child: SvgPicture.asset('Assets/Icons/${icon}.svg',color:  data==index?Colors.white:Colors.grey,fit: BoxFit.scaleDown,)),
    );
  }
}
