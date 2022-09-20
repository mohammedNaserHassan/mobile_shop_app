import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/Settings/Action/HelpCenter/ChattingScreen.dart';
import 'package:provider/provider.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        leading: IconButton(
          onPressed: () {
            AppRouter.appRouter.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MobileProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Text('Frequently Asked'.tr()),
                  trailing: Text('SeeAll'.tr()),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: provider.question.length,
                  itemBuilder: (context,index)=>Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      title: Text(provider.question[index].question??''),
                      subtitle: Text(provider.question[index].answer??''),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'conversation'.tr(),
        onPressed: (){
          AppRouter.appRouter.goToPage(ChattingScreen());
        },
        child: SvgPicture.asset('Assets/Icons/Vector.svg'),
        backgroundColor: green,
      ),
    );
  }
}
