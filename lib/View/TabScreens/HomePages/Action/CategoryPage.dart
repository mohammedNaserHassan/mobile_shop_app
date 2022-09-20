import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/TabScreens/HomePages/Action/ProductCategories.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Category'.tr(),style: Theme.of(context).textTheme.headline4?.copyWith(color: black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: black,), onPressed: () {
          AppRouter.appRouter.back();
        },),
      ),
      body: Consumer<MobileProvider>(
        builder: (context, provider, child) {
          return provider.categoriesModels.length==0?Center(child: CircularProgressIndicator()):Container(
            margin: EdgeInsets.only(top: 20.h),
            child: GridView.builder(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0.0.w,
                mainAxisSpacing: 3.h,
                mainAxisExtent: 240.h,
              ),
              itemCount: provider.categoriesModels.length,
                itemBuilder: (context, index){
                final category =  provider.categoriesModels[index];
                return GestureDetector(
                    onTap: (){
                      provider.getProductCategories(category.id??0,category.name??'');
                      AppRouter.appRouter.goToPage( ProductCategories());
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: 150.w,
                              child:  FadeInImage.assetNetwork(
                                placeholder: 'Assets/Images/mobile1.png',
                                image: category.image??'',
                                fit: BoxFit.cover,
                                height: 150.h,
                              )),
                          Text(category.name??''),
                        ],
                      ),
                    ),
                  );
                }
            ),
          );
        },
      ),
    );
  }
}
