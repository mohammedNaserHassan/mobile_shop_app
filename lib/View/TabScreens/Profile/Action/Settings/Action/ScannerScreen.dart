import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_shop_app/Controller/MobileProvider.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/services/Constants.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  @override
  void reassemble() {
  final  provider = Provider.of<MobileProvider>(context,listen: false);
    super.reassemble();
    if (Platform.isAndroid) {
      provider.qrViewController?.pauseCamera();
    } else if (Platform.isIOS) {
      provider.qrViewController?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        title: Text(
          'Scanner'.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {
            AppRouter.appRouter.back();
          },
        ),
        actions: [
          Icon(
            Icons.more_vert,
            color: black,
          ),
          SizedBox(
            width: 20.w,
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MobileProvider>(
  builder: (context, provider, child) {
  return Column(
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              width:300.w,
              height: 300.h,
              child:   provider.barcode!=null?Center(child: Text(provider.barcode?.code??'')):  QRView(
                overlay: QrScannerOverlayShape(
                  cutOutSize: MediaQuery.of(context).size.width*0.8,
                  borderColor: green,
                  overlayColor: Colors.white,
                  borderWidth: 5,
                  borderRadius: 10,
                  borderLength: 30,
                ),
                key: provider.scannerkey,
                onQRViewCreated: (c){
                  provider.setScanner(c);
                },
              ),
            ),
          ),
          ListTile(
            leading: Text('PopularItem'.tr(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            trailing: Text(
              'SeeAll'.tr(),
              style: TextStyle(color: Colors.green),
            ),
          ),
          Container(
            width: double.infinity,
            height: 100.h,
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                Container(
                  height: 100.h,
                  width: 120.w,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: light,
                  ),
                  child: Image.asset('Assets/Images/mobile0.png'),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Oneplus 9',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      '4/64 RAM',
                      style: TextStyle(fontSize: 12, color: grey),
                    ),
                    Text(
                      '676 AED ',
                      style: TextStyle(color: green),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width: 75.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Center(
                    child: Text(
                      'Shop Now'.tr(),
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                )
              ],
            ),
          )
        ],
      );
  },
),
    );
  }
}
