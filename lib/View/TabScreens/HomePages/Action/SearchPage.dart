import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 100.h,
        title: Text(
          'Search'.tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {
            AppRouter.appRouter.back();
          },
        ),
      ),
      body: Consumer<MobileProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: 265.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                                color: black.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 20)
                          ]),
                      child: TextField(
                        onChanged: (txt) {
                          if (txt.trim().length == 0) provider.setSearches();
                        },
                        onSubmitted: (c) {
                          c.trim().length == 0
                              ? provider.setSearches()
                              : provider.searchProductByAction(c);
                        },
                        textInputAction: TextInputAction.next,
                        controller: provider.searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: green),
                              borderRadius: BorderRadius.circular(10.r)),
                          hintText: 'Search'.tr(),
                          prefixIcon: Icon(Icons.search, color: grey),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: black,
                          borderRadius: BorderRadius.circular(5.r),
                          image: DecorationImage(
                              image: AssetImage(
                                'Assets/Icons/Filter.png',
                              ),
                              fit: BoxFit.scaleDown)),
                      width: 50.w,
                      height: 50.h,
                    ),
                  ],
                ),
                provider.searchWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
