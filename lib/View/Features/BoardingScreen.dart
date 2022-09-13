import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/Constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoardingScreen extends StatelessWidget {
  BoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MobileProvider>(
        builder: (context, value, child) => Container(
          margin: EdgeInsets.only(top: 70.h),
          child: PageView.builder(
            onPageChanged: (selected) {
              value.scrollChange(selected);
            },
            physics: const AlwaysScrollableScrollPhysics(),
            controller: value.controller,
            itemCount: boards.length,
            itemBuilder: (context, index) => Column(
              children: [
                Image.asset(
                  boards[index].image,
                  height: index == 0 ? 370.h : 400.h,
                ),
                if (index == 0)
                  SizedBox(
                    height: 40.h,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Indicator(color: value.states[0]),
                    Indicator(
                      color: value.states[1],
                    ),
                    Indicator(color: value.states[2]),
                  ],
                ),
                Text(boards[index].title,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                    maxLines: 2),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  boards[index].subtitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () {
                    value.scrollIndex(index);
                  },
                  child: value.states[2]
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          width: 136.w,
                          height: 42.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.r),
                              color: green),
                          child: Center(
                              child: Text(
                            'StartBoard'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Colors.white, fontSize: 16.sp),
                          )),
                        )
                      : CircleAvatar(
                          backgroundColor: green,
                          child: SvgPicture.asset(
                              "Assets/Icons/Arrow-Right.svg",
                              color: Colors.white),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  bool color;

  Indicator({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 3.w, bottom: 50.h, top: 40.h, right: 3.w),
      width: 8.w,
      height: 8.h,
      color: color ? green : Colors.grey,
    );
  }
}
