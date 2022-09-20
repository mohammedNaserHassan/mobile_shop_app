import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Components/BootomSheet.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Components/addressBottomSheet.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/Payment/PaymentScreen.dart';
import 'package:provider/provider.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Icon(
              Icons.more_vert,
              color: black,
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            AppRouter.appRouter.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        centerTitle: true,
        title: Text(
          'ShippingAddress'.tr(),
          style: Theme
              .of(context)
              .textTheme
              .headline5,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MobileProvider>(
        builder: (context, provider, child) {
          return   SingleChildScrollView(
            child: Column(
              children: [
                provider.addresses.length==0?Center(child: Text('No Address Added'),):      ListView.builder(
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
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: grey
                            ),
                            child: Icon(Icons.location_on_sharp,color: black,)),
                        subtitle: Text('Addtheshippingaddress'.tr()),
                        title: Text('Home Address'.tr()),
                        trailing: Icon(Icons.refresh,color: grey,),
                        onTap: (){
                          provider.getAddresses();
                        },
                      ),
                      Divider(
                        color: grey,
                      ),
                    DottedBorder(
                          padding: EdgeInsets.zero,
                          color: grey,
                          radius: Radius.circular(10),
                          strokeWidth: 2,
                          child: GestureDetector(
                            onTap: (){
                              showModalBottomSheet(
                                  context: AppRouter.appRouter.navkey.currentContext!,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)
                                      )),
                                  builder: (context)=>AddressBottomSheet()
                              );
                            },
                            child: Container(
                              color: white,
                              margin: EdgeInsets.symmetric(vertical: 15.h,horizontal: 5.w),
                              width: 320.w,
                              height: 30.h,
                              child: Center(
                                child: Icon(Icons.add,color: grey,),
                              ),
                            ),
                          ),

                      ),

                    ],
                  ),
                ),

                Container(
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    child: ButtonWidget(title: 'Continuetopayment'.tr(), color: black, function: (){
                      AppRouter.appRouter.goToPage( PaymentScreen());
                    }))
              ],
            ),
          );
        },
      ),
    );
  }
}
