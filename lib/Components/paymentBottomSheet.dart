import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';
class PaymentBootomSheet extends StatelessWidget {
  const PaymentBootomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
      builder: (context, provider, child) {
        return provider.addresses.length==0?SizedBox(
            height: 150.h,
            child: Center(child: Text('No Address Added'),)):    SizedBox(
          height: 400.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5.h,),
                Text('Select your address'.tr(),style: Theme.of(context).textTheme.headline5,),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.addresses.length,
                    itemBuilder: (context, index) {
                      final x =   provider.addresses[index];
                      return   Card(
                        margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Column(
                          children: [
                            RadioListTile<dynamic>(
                              activeColor: green,
                              secondary: Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: grey
                                  ),
                                  child: Icon(Icons.location_on_sharp,color: black,)),
                              subtitle: Text('${x.latitude} ${x.city},City, ${x.longitude} road'),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value:index, groupValue:provider.selectedAddress , onChanged: (c){
                              provider.setAddress(c);
                            },
                              title: Text(x.name??''),
                            ),
                            Divider(
                              color: grey,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15.h,horizontal: 5.w),
                              width: 320.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('Assets/Images/map.png')
                                  )
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                ),
                ButtonWidget(title: 'Save', color: black, function: (){
                  AppRouter.appRouter.back();
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
