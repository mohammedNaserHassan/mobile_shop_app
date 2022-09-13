
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/SpetialFeatureWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Model/ProductModel.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';

import 'package:carousel_indicator/carousel_indicator.dart';

class ProductDetails extends StatelessWidget {
  Products mobileModel;

  ProductDetails(this.mobileModel);

  @override
  Widget build(BuildContext context) {
    num price = mobileModel.price ?? 0;
    num oldPrice = mobileModel.oldPrice ?? 0;
    num total = oldPrice - price;
    return Consumer<MobileProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('Assets/Images/circleBorder.png'),
                      Transform.translate(
                        offset: Offset(15,10),
                        child: CircleAvatar(
                          backgroundColor: white,
                            radius: 155.r,),
                      ),
                    SizedBox(
                      height: 150.h,
                      child: PageView.builder(
                        onPageChanged: (ind){
                          provider.setPageIndex(ind);
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount:  mobileModel.images?.length,
                        itemBuilder: (context,index)=>  FadeInImage?.assetNetwork(
                          placeholder: 'Assets/Images/mobile1.png',
                          image: mobileModel.images?[index]??'Assets/Images/banner2.png',
                          height: 150.h,
                        ),
                      ),
                    ),
                      PositionedDirectional(
                          top: 20.h,
                          start: 20.w,
                          child: IconButton(onPressed: (){AppRouter.appRouter.back();}, icon: Icon(Icons.arrow_back_ios,color: black,))),
                      PositionedDirectional(
                        top: 70.h,
                        end: 20.w,
                        child: GestureDetector(
                          onTap: (){
                            AppRouter.appRouter.back(); provider.setIndex(3);
                          },
                          child: CircleAvatar(
                            backgroundColor: green,
                            radius: 15.r,
                            child: SvgPicture.asset('Assets/Icons/heart.svg',color: Colors.white,),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                          top: 20.h,
                          end: 10.w,
                          child: IconButton(onPressed: (){AppRouter.appRouter.back(); provider.setIndex(1);}, icon: Icon(Icons.shopping_cart_outlined,color: black,))),
                    ],
                  ),
                  CarouselIndicator(
                    color: grey,
                    activeColor: green,
                    count: mobileModel.images!.length,
                    index: provider.pageIndex,
                  ),
                  ListTile(
                    title:  total != 0
                          ? Container(
                      margin: EdgeInsetsDirectional.only(end: 110.w),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              width: 30.w,
                              height: 25.h,
                              child: Text(
                                '${total.toString().substring(0, 2)}%',
                                style: TextStyle(color: Colors.white,fontSize: 15.sp),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : SizedBox(),
                    leading: Text(
                      mobileModel.name?.substring(0,12) ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Text(
                      mobileModel.price.toString() + ' \$',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: green,fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Text('Smartphone'.tr()),
                        Text('            Oneplus'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                    child: Row(
                      children: [
                        Text('Smartphone'.tr()+' '),
                        Text(mobileModel.oldPrice.toString().substring(1,2)+'.0  '+'⭐⭐⭐⭐⭐'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text('Specialfeatures'.tr(),style: Theme.of(context).textTheme.headline5,)),
                  ),
                  SpetialFeatureWidget(),
                  SpetialFeatureWidget(),
                  SpetialFeatureWidget(),
                  Align(
                    alignment: Alignment.center,
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Container(
                        color: Colors.white,
                        height: 92.h,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                provider.addOrRemoveFavourite(mobileModel.id ?? 0);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    color: mobileModel.inFavorites ?? false
                                        ? green
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 44.w,
                                  height: 44.h,
                                  child: SvgPicture.asset('Assets/Icons/heart.svg')),
                            ),
                            ButtonWidget(
                                title: 'AddToCart'.tr(),
                                color: black,
                                function: () {
                                  provider.addOrRemoveCard(mobileModel.id ?? 0);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
