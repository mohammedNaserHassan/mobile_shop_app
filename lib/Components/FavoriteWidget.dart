import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Model/FavoriteModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';

class FavoriteWidget extends StatelessWidget {
  FavoriteModel mobileModel;

  FavoriteWidget({required this.mobileModel});

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
      builder: (context, provider, child) {
        return Card(
          shadowColor: Colors.black,
          child: Column(
            children: [
              ListTile(
                trailing: GestureDetector(
                  onTap: (){
                    provider.removeFavorite(mobileModel.id??0,mobileModel.product?.id??0);
                  },
                  child: CircleAvatar(
                    backgroundColor: green,
                    radius: 15.r,
                    child: SvgPicture.asset('Assets/Icons/heart.svg',color: Colors.white,),
                  ),
                ),
                minVerticalPadding: 0,
              ),
              Image.network(mobileModel.product?.image??'Assets/Images/banner2.png',width: 150.w,height: 150.h,),
              Text(
                mobileModel.product?.name??'',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(mobileModel.product?.price.toString()??'' '.00 \$',),
              Text('⭐ ${mobileModel.product?.oldPrice.toString()} (${mobileModel.product?.price}K)',    overflow: TextOverflow.ellipsis,)
            ],
          ),
        );
      },
    );
  }
}
