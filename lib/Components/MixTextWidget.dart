import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
class MixTextWidget  extends StatelessWidget {
  String text1, text2;
   MixTextWidget ({Key? key,required this.text1,required this.text2,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(
          text: text1,
          children: [
            TextSpan(
                text: text2,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: green,fontSize: 25,fontWeight: FontWeight.bold))
          ],
          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 25,fontWeight: FontWeight.bold)),
    );
  }
}
