import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Components/FavoriteWidget.dart';
import 'package:mobile_shop_app/Components/MobileItemWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:provider/provider.dart';
class FavouriteTab extends StatelessWidget {
  const FavouriteTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Favorite',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,

      ),
      body: Consumer<MobileProvider>(
        builder: (context, provider, child) {
          return provider.favoritesModels.length==0?
              Center(
                child: Text('No Favorites Yet \n You can Add from Home Tab',style: Theme.of(context).textTheme.headline6,),
              )
              :GridView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 5,
              mainAxisExtent: 300,
            ),
            children: provider.favoritesModels.map((e) => FavoriteWidget(mobileModel: e)).toList(),);
        },
      ),
    );
  }
}
