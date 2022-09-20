import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/ShippingAddressScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShopTab extends StatelessWidget {
  const ShopTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        actions: [
       const   Icon(
            Icons.more_vert,
            color: Colors.grey,
          ),
          SizedBox(
            width: 30.w,
          ),
        ],
        centerTitle: true,
        title: Text(
          'ShoppingCart'.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Consumer<MobileProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                flex: 3,
                child: provider.cartsModels.length == 0
                    ? Center(
                        child: Text(
                          'NoCards'.tr(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          provider.getCards();
                          provider.cartsModels.toSet();
                        },
                        child: ListView.builder(
                          itemCount: provider.cartsModels.length,
                          itemBuilder: (context, index) => Slidable(
                            key: ValueKey(index),
                            startActionPane: ActionPane(
                              motion: Container(
                                margin: EdgeInsets.only(
                                    top: 30.h, bottom: 30.h, left: 25.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.red),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    provider.deleteCard(
                                        provider.cartsModels[index].id ?? 0);
                                  },
                                ),
                              ),
                              extentRatio: 0.18,
                              dragDismissible: true,
                              children: [
                                SlidableAction(
                                  onPressed: (context) {},
                                  borderRadius: BorderRadius.circular(10),
                                  autoClose: true,
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  label: '',
                                )
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: green,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          provider.decrement(
                                              index: index,
                                              provider.cartsModels[index]
                                                      .quantity ??
                                                  0,
                                              provider.cartsModels[index].id ??
                                                  0);
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      '${provider.cartsModels[index].quantity}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          provider.increment(
                                              index: index,
                                              provider.cartsModels[index]
                                                      .quantity ??
                                                  0,
                                              provider.cartsModels[index].id ??
                                                  0);
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                              extentRatio: 0.5,
                              children: [
                                SlidableAction(
                                  borderRadius: BorderRadius.circular(10.r),
                                  onPressed: (context) {},
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  label: '',
                                )
                              ],
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 100.h,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 20.w),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                children: [
                                  Container(
                                    height: 100.h,
                                    width: 120.w,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: light,
                                    ),
                                    child: Image.network(provider
                                            .cartsModels[index]
                                            .product
                                            ?.image ??
                                        ''),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.cartsModels[index].product
                                                ?.name
                                                ?.substring(0, 13) ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Text(
                                        provider.cartsModels[index].product
                                                ?.price
                                                .toString() ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 12, color: grey),
                                      ),
                                      Text(
                                        ' ${provider.cartsModels[index].product?.oldPrice.toString()}\$',
                                        style: TextStyle(color: green),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    'x' +
                                        provider.cartsModels[index].quantity
                                            .toString(),
                                    style: TextStyle(color: green),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              Expanded(
                flex: 2,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  child: Container(
                    height: 250,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Text('SubTotal'.tr()),
                            trailing: Text('${provider.subTotal} \$'),
                          ),
                          ListTile(
                            leading: Text('Discount'.tr()),
                            trailing: Text('30%'),
                          ),
                          ListTile(
                            leading: Text(
                              'Shipping'.tr(),
                              style: TextStyle(color: green),
                            ),
                            trailing: Text(
                              '-\$11.00',
                              style: TextStyle(color: green),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: DottedLine(
                              direction: Axis.horizontal,
                              lineLength: double.infinity,
                              lineThickness: 1.0,
                              dashLength: 4.0,
                              dashColor: green,
                              dashGapLength: 4.0,
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'Total'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              '\$' + provider.total.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          ButtonWidget(
                              title: 'Proceedcheckout'.tr(),
                              color: black,
                              function: () {
                                AppRouter.appRouter.goToPage(ShippingAddressScreen());
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
