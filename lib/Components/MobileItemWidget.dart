import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Model/ProductModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/TabScreens/HomePages/Action/ProductDetails.dart';
import 'package:provider/provider.dart';

class MobileItemWidget extends StatelessWidget {
  Products mobileModel;

  MobileItemWidget({required this.mobileModel});

  @override
  Widget build(BuildContext context) {
 num price  = mobileModel.price??0;
 num oldPrice  = mobileModel.oldPrice??0;
 num total = oldPrice-price;
    return Consumer<MobileProvider>(
  builder: (context, provider, child) {
  return GestureDetector(
    onTap: (){
      AppRouter.appRouter.goToPage(ProductDetails(mobileModel));
    },
    child: Card(
        shadowColor: Colors.black,
        child: Column(
          children: [
            ListTile(
              leading:total!=0
                  ? Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                      width: 35.w,
                      height: 25.h,
                      child: Center(
                        child: Text(
                          '${total.toString().substring(0,2)}%',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : SizedBox(),
              trailing: GestureDetector(
                onTap: (){
                  provider.addOrRemoveFavourite(mobileModel.id??0);
                },
                child: CircleAvatar(
                  backgroundColor:  mobileModel.inFavorites??false ?green:Colors.transparent,
                  radius: 15.r,
                  child:SvgPicture.asset('Assets/Icons/heart.svg')

                ),
              ),
              minVerticalPadding: 0,
            ),
            Container(
                width: 150.w,
                child:  FadeInImage.assetNetwork(
                  placeholder: 'Assets/Images/mobile1.png',
                  image: mobileModel.images?[0]??'Assets/Images/banner2.png',
                  fit: BoxFit.cover,
                  height: 150.h,
                )),
              Text(
              mobileModel.name??'',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
              Text(mobileModel.price.toString() + '.00 \$',),
             Text('⭐ ${mobileModel.oldPrice??'22'}'+
                '(${mobileModel.price}K )',overflow: TextOverflow.ellipsis,)
          ],
        ),
      ),
  );
  },
);
  }
}
