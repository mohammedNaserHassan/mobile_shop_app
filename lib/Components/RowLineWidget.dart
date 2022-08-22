import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class RowLineWidget extends StatelessWidget {
  String text1,text2;
  Widget function;
   RowLineWidget({Key? key,required this.text2, required this.text1,required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Center(
      child: RichText(text: TextSpan(text: text1,children: [
        TextSpan(text: text2, style: Theme.of(context)
            .textTheme
            .headline4
            ?.copyWith(color: green,fontSize: 16.sp),recognizer: TapGestureRecognizer()..onTap = (){
          AppRouter.appRouter.goWithReplacement(function);
        }),
      ],
        style:
        Theme.of(context).textTheme.headline4?.copyWith(fontSize: 16.sp),
      ),
      ),
    );
  }
}
