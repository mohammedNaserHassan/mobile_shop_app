import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Components/ButtonWidget.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShopTab extends StatelessWidget {
  const ShopTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  toolbarHeight: 100,
  actions: [
    Icon(Icons.more_vert,color: Colors.grey,),
    SizedBox(width: 30,),
  ],
  centerTitle: true,
  title: Text('Shopping Cart',style: Theme.of(context).textTheme.headline5,),
),
      body: Consumer<MobileProvider>(
  builder: (context, provider, child) {
  return Column(
        children: [
          SizedBox(
            height: 380,
            child: provider.shoppings.length==0?CircularProgressIndicator():ListView.builder(
              itemCount: provider.shoppings.length,
              itemBuilder: (context,index)=>Slidable(
                key: ValueKey(index),
                startActionPane: ActionPane(
                  // dismissible: DismissiblePane(
                  //   onDismissed: (){},
                  // ),
                  motion: Container(
                    margin: EdgeInsets.only(top: 30,bottom: 30,left: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red
                    ),
                    child: IconButton(icon: Icon(Icons.delete,color: Colors.white,),onPressed: (){},),
                  ),
                  extentRatio: 0.18,
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
                    margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.remove,color: Colors.white,)),
                        Text('2',style: TextStyle(color: Colors.white),),
                        IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.white,)),
                      ],
                    ),
                  ),
                  extentRatio: 0.5,
                  children: [
                    SlidableAction(
                      borderRadius: BorderRadius.circular(10),
                      onPressed: (context) {},
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      label: '',
                    )
                  ],
                ),
                child: Container(
                  width:double.infinity,
                  height: 100,
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                ),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 120,
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: light,
                        ),
                        child: Image.asset(provider.shoppings[index].image),
                      ),
                      SizedBox(width: 10.w,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(provider.shoppings[index].name,style: Theme.of(context).textTheme.headline6,),
                          Text(provider.shoppings[index].ram,style: TextStyle(fontSize: 12,color: grey),),
                          Text(provider.shoppings[index].aed.toString()+'AED',style: TextStyle(color: green),),
                        ],
                      ),
                      Spacer(),
                      Text('x'+provider.shoppings[index].number.toString(),style: TextStyle(color: green),),
                      SizedBox(width: 20,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            elevation: 10,
            child: Container(
              height: 250,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: Text('Suttotal'),
                      trailing: Text('234 AED'),
                    ),
                    ListTile(
                      leading: Text('Discount'),
                      trailing: Text('30%'),
                    ),
                    ListTile(
                      leading: Text('Shipping',style: TextStyle(color: green),),
                      trailing: Text('-\$11.00',style: TextStyle(color: green),),
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
                      leading: Text('Total',style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),),
                      trailing: Text('\$234.99',style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),),
                    ),
                    ButtonWidget(title: 'Proceed to checkout', color: black, function: (){})

                  ],
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

