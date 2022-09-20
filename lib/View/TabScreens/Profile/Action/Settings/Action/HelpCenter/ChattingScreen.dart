import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/services/Constants.dart';
import 'package:provider/provider.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Helpcenter'.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        toolbarHeight: 80.h,
        leading: IconButton(
          onPressed: () {
            AppRouter.appRouter.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MobileProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                flex: 6,
                child: ListView.builder(
                  controller: provider.scrollController,
                    shrinkWrap: true,
                    itemCount: provider.messages.length,
                    itemBuilder: (context, index) {
                      final message = provider.messages[index];
                      return ChatBubble(
                        alignment: message.isSender
                      ? Alignment.topRight
                          : Alignment.topLeft,
                        margin: EdgeInsets.symmetric(vertical: 5.h,),
                        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                        backGroundColor: message.isSender? green:green.withOpacity(0.2),
                        clipper: ChatBubbleClipper4(type: message.isSender? BubbleType.sendBubble:BubbleType.receiverBubble,),
                        child: FittedBox(
                          child: Row(
                              children: [
                                message.isSender
                                    ? CircleAvatar(
                                        radius: 15.r,
                                        backgroundImage: NetworkImage(
                                            provider.profileModel.data?.image ?? ''))
                                    : CircleAvatar(
                                        radius: 15.r,
                                        backgroundImage:
                                            AssetImage('Assets/Images/profile.png')),
                                SizedBox(width: 5.w,),
                                Text(
                                  message.msg,
                                  overflow: TextOverflow.visible,
                                ),
                              ]),
                        ),
                      );
                    }),
              ),
              Card(
                elevation: 0,
                child: TextField(
                  controller: provider.messageController,
                  decoration: InputDecoration(
                    hintText: 'Type your problem'.tr(),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: green,
                      ),
                      onPressed: provider.sendComplaints,
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
