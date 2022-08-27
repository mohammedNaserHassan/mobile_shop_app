import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Model/Mobile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Services/Constants.dart';

class MobileItemWidget extends StatelessWidget {
  MobileModel mobileModel;

  MobileItemWidget({required this.mobileModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      child: Column(
        children: [
          ListTile(
            leading: mobileModel.isOffered
                ? Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                    width: 35,
                    height: 25,
                    child: Center(
                      child: Text(
                        '30%',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : SizedBox(),
            trailing: CircleAvatar(
              backgroundColor: green,
              radius: 15.r,
              child: mobileModel.favourite
                  ? Icon(Icons.favorite,color: Colors.white,)
                  : Icon(Icons.favorite_border),
            ),
            minVerticalPadding: 0,
          ),
          Image.asset(mobileModel.image, scale: 0.7),
          Text(
            mobileModel.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(mobileModel.price.toString() + '.00 AED'),
          Text('⭐' +
              mobileModel.rating.toString() +
              '(${mobileModel.review}K review)')
        ],
      ),
    );
  }
}
