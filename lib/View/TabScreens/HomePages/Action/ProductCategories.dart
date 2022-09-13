import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Components/MobileItemWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/services/Constants.dart';
import 'package:provider/provider.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100.h,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(provider.nameProduct,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: black)),
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
          body: provider.productsCategories.length == 0
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                                image: NetworkImage(
                                  provider.ads,
                                ),
                                fit: BoxFit.fill)),
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                      ),
                      Container(
                        height: 170.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: provider.productsCategories.length,
                            itemBuilder: (context, index) {
                              final detail = provider.productsCategories[index];
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                padding: EdgeInsets.zero,
                                width: 150.w,
                                height: 133.h,
                                child: Card(
                                  semanticContainer: true,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FadeInImage.assetNetwork(
                                        placeholder:
                                            'Assets/Images/mobile1.png',
                                        image: detail.image ?? '',
                                        width: 50.w,
                                      ),
                                      Text(
                                        detail.name ?? '',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        width: 90.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: lightGreen.withOpacity(0.30),
                                        ),
                                        child: Center(
                                            child: Text(
                                          'Explorenow'.tr(),
                                          style: TextStyle(color: green),
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      ListTile(
                        leading: Text(
                          'Inthespotlight'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
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
                ),
        );
      },
    );
  }
}
