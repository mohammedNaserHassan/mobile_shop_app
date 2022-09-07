import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Model/ProductModel.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  Products mobileModel;

  ProductDetails(this.mobileModel);

  @override
  Widget build(BuildContext context) {
    return Consumer<MobileProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(mobileModel.name ?? ''),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  title: 'Add To Cart ', color: black, function: (){
                provider.addOrRemoveCard(mobileModel.id??0);
              }),
            ],
          ),
        );
      },
    );
  }
}
