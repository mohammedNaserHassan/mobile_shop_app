import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Model/SearchModel.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  SearchModel mobileModel;

  SearchWidget({required this.mobileModel});

  @override
  Widget build(BuildContext context) {
    num price  = mobileModel.price??0;
    num oldPrice  = mobileModel.price??0;
    num total = oldPrice-price;
    return Consumer<MobileProvider>(
      builder: (context, provider, child) {
        return Card(
          shadowColor: Colors.black,
          child: Column(
            children: [
              Image.network(mobileModel.images?[0]??'Assets/Images/banner2.png',height: 200.h,),
              Text(
                mobileModel.name??'',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(mobileModel.price.toString() + '.00 AED',    overflow: TextOverflow.ellipsis,),
              Text('⭐' +
                  mobileModel.price.toString() +
                  '(${mobileModel.price}K review)',    overflow: TextOverflow.ellipsis,)
            ],
          ),
        );
      },
    );
  }
}
