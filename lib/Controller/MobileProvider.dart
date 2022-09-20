import 'dart:convert';
import 'dart:io';
import 'package:bottom_navigation_view/bottom_navigation_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_shop_app/Components/BootomSheet.dart';
import 'package:mobile_shop_app/Components/MobileItemWidget.dart';
import 'package:mobile_shop_app/Controller/AuthProvider.dart';
import 'package:mobile_shop_app/Helper/DioHelper.dart';
import 'package:mobile_shop_app/Helper/SharedPreferencesHelper.dart';
import 'package:mobile_shop_app/Model/Address.dart';
import 'package:mobile_shop_app/Model/BannerModel.dart';
import 'package:mobile_shop_app/Model/CardModel.dart';
import 'package:mobile_shop_app/Model/CategoryModel.dart';
import 'package:mobile_shop_app/Model/FavoriteModel.dart';
import 'package:mobile_shop_app/Model/Message.dart';
import 'package:mobile_shop_app/Model/OrderModel.dart';
import 'package:mobile_shop_app/Model/ProductModel.dart';
import 'package:mobile_shop_app/Model/ProfileModel.dart';
import 'package:mobile_shop_app/Model/Question.dart';
import 'package:mobile_shop_app/Model/SettingsModel.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/customDialog.dart';
import 'package:mobile_shop_app/View/Auth/LoginScreen.dart';
import 'package:mobile_shop_app/View/Features/BoardingScreen.dart';
import 'package:mobile_shop_app/View/Features/HomeScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/ExploreTab.dart';
import 'package:mobile_shop_app/View/TabScreens/FavouriteTab.dart';
import 'package:mobile_shop_app/View/TabScreens/HomePages/HomeTab.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/MyPurchess.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/Payment/PaymentScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/Settings/Action/AboutScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/Settings/Action/HelpCenter/HelpCenterScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/Settings/Action/NotificationPage.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/Settings/Action/ScannerScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/Settings/SettingsScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/Action/ShippingAddressScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/Profile/ProfileTab.dart';
import 'package:mobile_shop_app/View/TabScreens/ShopTab.dart';
import 'package:mobile_shop_app/services/Constants.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../View/Auth/SignupScreen.dart';

enum PaymentMethod { A, B, C, D, E }

class MobileProvider extends ChangeNotifier {
  ///////////////////Scan code of mobile //////////////////////////////////
  final scannerkey = GlobalKey(debugLabel: 'QRCode');
  Barcode? barcode;
  QRViewController? qrViewController;

  setScanner(QRViewController qr) {
    qrViewController = qr;
    notifyListeners();
    qr.scannedDataStream.listen((event) {
      barcode = event;
    });
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////Enter your card name and number/////////////////////////////////
  setText(TextEditingController c, String text) {
    c.text = text;
    notifyListeners();
  }

  PaymentMethod selected = PaymentMethod.C;

  setPayment(PaymentMethod method) {
    selected = method;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////Get settings //////////////////////////
  TextEditingController searchController = TextEditingController();
  String about = '';
  String terms = '';

  getAbout() {
    DioHelper.dioHelper.getData(url: SETTINGS).then((value) {
      about = value?.data['data']['about'];
      terms = value?.data['data']['terms'];
    });
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////////////Make order //////////////////////////////////////////
  bool isOrder = false;

  makeOrder() {
    isOrder = true;
    notifyListeners();
    if (selectedAddress != -1) {
      DioHelper.dioHelper.postData(url: ORDERS, data: {
        "address_id": addresses[selectedAddress].id,
        "payment_method": selected.name,
        "use_points": false
      }).then((value) {
        isOrder = false;
        AppRouter.appRouter.back();
        AppRouter.appRouter.back();
        AppRouter.appRouter.back();
        CustomDialog.customDialog.thanksCustom('Thank you!'.tr());
        getOrders();
        notifyListeners();
      });
    }
  }

  List<Order> orderModels = [];

  getOrders() {
    DioHelper.dioHelper.getData(url: ORDERS).then((value) {
      List<dynamic> orders = value?.data['data']['data'];
      orderModels = orders.map((e) => Order.fromJson(e)).toList();
      notifyListeners();
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////////Slider of productCategories/////////////////////////////
  int pageIndex = 0;

  setPageIndex(int ind) {
    this.pageIndex = ind;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////////// Chat with helpCenter////////////////////////////
  List<MessageModel> messages = [];
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  sendComplaints() {
    String message = messageController.text;
    messageController.clear();
    messages.add(MessageModel(isSender: true, msg: message));
    notifyListeners();
    if (scrollController.hasClients) scrollController.jumpTo(50.0);
    DioHelper.dioHelper.postData(url: COMPLAINTS, data: {
      "name": profileModel.data?.name ?? '',
      "phone": profileModel.data?.phone ?? '',
      "email": profileModel.data?.email ?? '',
      "message": message
    }).then((value) {
      messages.add(MessageModel(isSender: false, msg: value?.data['message']));
      notifyListeners();
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////List of Settings ///////////////////////////////////////////////////
  List<SettingsMiodel> seting = [
    SettingsMiodel(
        title: 'Notification',
        icon: 'notify',
        function: () {
          AppRouter.appRouter.goToPage(NotificationPage());
        }),
    SettingsMiodel(
        title: 'Language',
        icon: 'language',
        function: () {
          showModalBottomSheet(
              context: AppRouter.appRouter.navkey.currentContext!,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              builder: (context) => BootomSheet());
        }),
    SettingsMiodel(
        title: 'Scanner',
        icon: 'Scan',
        function: () {
          AppRouter.appRouter.goToPage(ScannerScreen());
        }),
    SettingsMiodel(
        title: 'Helpcenter',
        icon: 'help',
        function: () {
          AppRouter.appRouter.goToPage(HelpCenterScreen());
        }),
    SettingsMiodel(
        title: 'Abouts',
        icon: 'DangerCircle',
        function: () {
          AppRouter.appRouter.goToPage(AboutScreen());
        }),
  ];

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////List of setttings in profile tab//////////////////////////////////
  List<SettingsMiodel> settings = [
    SettingsMiodel(
        title: 'Settings',
        icon: 'Setting',
        function: () {
          AppRouter.appRouter.goToPage(SettingsScreen());
        }),
    SettingsMiodel(
        title: 'PaymentMethod',
        icon: 'payment',
        function: () {
          AppRouter.appRouter.goToPage(PaymentScreen());
        }),
    SettingsMiodel(
        title: 'Mypurches',
        icon: 'Wallet',
        function: () {
          AppRouter.appRouter.goToPage(MyPurchess());
        }),
    SettingsMiodel(
        title: 'Address',
        icon: 'Location',
        function: () {
          AppRouter.appRouter.goToPage(ShippingAddressScreen());
        }),
    SettingsMiodel(
        title: 'Privacy',
        icon: 'privacy',
        function: () {
          AppRouter.appRouter.goToPage(AboutScreen());
        }),
    SettingsMiodel(
        title: 'Logout',
        icon: 'Logout',
        function: () {
          Provider.of<AuthProvider>(AppRouter.appRouter.navkey.currentContext!,
                  listen: false)
              .logOut();
        }),
  ];

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////Set Language/////////////////////////////
  Language lang =
      SharedPreferencesHelper.x.getLang() ? Language.Arabic : Language.English;

  setLanguage(language) {
    lang = language;
    notifyListeners();
  }

  bool isSavedLanguage = false;

  saveLanguage(BuildContext context) {
    SharedPreferencesHelper.x.deletLang();
    lang == Language.Arabic ? isSavedLanguage = true : isSavedLanguage = false;
    context.setLocale(isSavedLanguage ? Locale('ar') : Locale('en'));
    SharedPreferencesHelper.x.saveLang(isSavedLanguage);
    notifyListeners();
    getRequest();
    AppRouter.appRouter.back();
  }

  ///////////////////////////////////////////////////////////////////////////

///////////////////////Get Categories/////////////////////////

  List<CategoryModel> categoriesModels = [];

  getCategories() {
    DioHelper.dioHelper.getData(url: CATEGORIE).then((value) {
      List<dynamic> categories = value?.data['data']['data'];
      categoriesModels =
          categories.map((e) => CategoryModel.fromJson(e)).toList();
      notifyListeners();
    });
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////////Get ProductCategories/////////////////////////

  List<Products> productsCategories = [];
  String nameProduct = '';

  getProductCategories(int id, String name) {
    nameProduct = name;
    DioHelper.dioHelper.getData(url: CATEGORIE + '/${id}').then((value) {
      List<dynamic> categories = value?.data['data']['data'];
      productsCategories = categories.map((e) => Products.fromJson(e)).toList();
      notifyListeners();
    });
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /////// set Bottom Navigation ////////////////////////////
  List<Widget> tabs = [
    HomeTab(),
    const ShopTab(),
    const ExploreTab(),
    const FavouriteTab(),
    ProfileTab()
  ];
  int selectedIndex = 0;
  BottomNavigationController? bottomController;

  setIndex(int index) {
    selectedIndex = index;
    bottomController?.goTo(selectedIndex);
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /////////////////Get Notification //////////////////////////
  List<dynamic> notifications = [];

  getNotification() {
    DioHelper.dioHelper.getData(url: NOTIFICATION).then((value) {
      notifications = value?.data['data']['data'];
      notifyListeners();
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////Search Product////////////////////////////
  List<Products> searches = [];
  bool isSearched = false;

  setSearches() {
    searchController.clear();
    searches.clear();
    notifyListeners();
  }

  searchProductByAction(String searched) {
    isSearched = true;
    SharedPreferencesHelper.x.sharedPreferences?.remove('recently');
    recentlyProducts.clear();
    notifyListeners();
    DioHelper.dioHelper
        .postData(url: SEARCH, data: {"text": searched}).then((value) {
      if (value?.data['status'] ?? false) {
        List<dynamic> searche = value?.data['data']['data'];
        searches = searche.map((e) => Products.fromJson(e)).toList();
        isSearched = false;
        List<String> recent = searches.map((e) => jsonEncode(e)).toList();
        SharedPreferencesHelper.x.sharedPreferences
            ?.setStringList('recently', recent);
        getRecently();
      } else {
        CustomDialog.customDialog.showCustom(value?.data['message']);
      }
      isSearched = false;
      notifyListeners();
    });
  }

  getRecently() {
    List<String> savedRecently = SharedPreferencesHelper.x.sharedPreferences
            ?.getStringList('recently') ??
        [];
    recentlyProducts = savedRecently.map((element) {
      Map<String, dynamic> map = jsonDecode(element);
      return Products.fromJson(map);
    }).toList();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////Get All Mobiles ///////////////////////////////////////////
  List<Products> products = [];
  List<Products> recentlyProducts = [];
  List<dynamic> productsItems = [];
  String? ads;
  bool start = false;

  getMobiles() {
    DioHelper.dioHelper.getData(url: HOME).then((value) {
      productsItems = value?.data['data']['products'];
      ads = value?.data['data']['ad'];
      products =
          productsItems.map((value) => Products.fromJson(value)).toList();
      notifyListeners();
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////Add or Remove to Card/////////////////////////////////////////////////
  List<CardModel> cartsModels = [];

  addOrRemoveCard(int id) {
    Products product = products.where((element) => element.id == id).first;
    bool card = product.inCart ?? false;
    product.inCart = !card;
    if (product.inCart ?? false) {
      DioHelper.dioHelper.customPostData(
        url: CARDS,
        data: {"product_id": id},
      ).then((value) {
        CustomDialog.customDialog.showCustom(value?.data['message']);
        getCards();
      });
    } else
      CustomDialog.customDialog.showCustom('This product is already exist');
    notifyListeners();
  }

  CardItem card = CardItem();
  num total = 0, subTotal = 0;

  getCards() {
    card = CardItem();
    DioHelper.dioHelper.getData(url: CARDS).then((value) {
      card = CardItem.fromJson(value?.data["data"]);
      cartsModels = card.cartItems ?? [];
      total = card.total ?? 0;
      subTotal = card.subTotal ?? 0;
      notifyListeners();
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////Update amount of cards ///////////////////////////////
  increment(num qount, int id, {required int index}) {
    num price = cartsModels[index].product!.price ?? 0;
    ++qount;
    cartsModels[index].quantity = qount;
    total = total + price;
    subTotal = subTotal + price;
    updateCard(id: id, quntity: qount);
    notifyListeners();
  }

  decrement(num qount, int id, {required int index}) {
    num price = cartsModels[index].product!.price ?? 0;
    if (qount > 1) {
      --qount;
      cartsModels[index].quantity = qount;
      total = total - price;
      subTotal = subTotal - price;
      updateCard(id: id, quntity: qount);
      notifyListeners();
    }
  }

  updateCard({required int id, required num quntity}) {
    DioHelper.dioHelper.putDataWithToken(
      url: CARDS + '/${id}',
      data: {"quantity": quntity},
    );
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////Add or Remove to Favorite/////////////////////////////////////////////////
  List<FavoriteModel> favoritesModels = [];

  removeFavorite(int id, int secondId) {
    Products produc = products.where((element) => element.id == secondId).first;
    produc.inFavorites = false;
    favoritesModels.removeWhere((element) => element.id == id);
    DioHelper.dioHelper
        .delete(FAVORRITE + '/${id}')
        .then((value) => getMobiles());
    notifyListeners();
  }

  addOrRemoveFavourite(
    int id,
  ) {
    Products product = products.where((element) => element.id == id).first;
    bool fav = product.inFavorites ?? false;
    product.inFavorites = !fav;
    DioHelper.dioHelper.customPostData(
      url: FAVORRITE,
      data: {"product_id": id},
    ).then((value) {
      getFavorites();
    });
    notifyListeners();
  }

  getFavorites() {
    DioHelper.dioHelper
        .getData(
      url: FAVORRITE,
    )
        .then((value) {
      List<dynamic> favorites = value?.data['data']['data'];
      favoritesModels =
          favorites.map((e) => FavoriteModel.fromJson(e)).toList();
      notifyListeners();
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////// Set up for Boarding screen///////////////////////////////////////////////////////
  Color color = Colors.green;
  List<bool> states = [true, false, false];
  PageController controller = PageController();

  scrollChange(int index) {
    controller.animateToPage(index,
        duration: Duration(seconds: 2), curve: Curves.bounceOut);
    states.fillRange(0, 3, false);
    states[index] = true;
    notifyListeners();
  }

  scrollIndex(int index) {
    if (index < 2) {
      controller.animateToPage(index + 1,
          duration: Duration(seconds: 2), curve: Curves.fastLinearToSlowEaseIn);
      states.fillRange(0, 3, false);
      states[index] = true;
    } else {
      AppRouter.appRouter.goWithReplacement(SignupScreen());
    }
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////Get Banners///////////////////////////////////
  List<DataBanners>? banners = [];

  getBanners() {
    DioHelper.dioHelper.getData(url: BANNERS).then((value) {
      Banenr bannerModels = Banenr();
      bannerModels = Banenr.fromJson(value?.data);
      banners = bannerModels.data;
      notifyListeners();
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////////// Search of Product///////////////////////////////
  List<Products> searchModels = [];

  searchProduct(String searched) {
    DioHelper.dioHelper
        .postData(url: SEARCH, data: {"text": searched}).then((value) {
      List<dynamic> searches = value?.data['data']['data'];
      searchModels = searches.map((e) => Products.fromJson(e)).toList();
    });
  }

  List<Products> searchSModels = [];

  searchSProduct(String searched) {
    DioHelper.dioHelper
        .postData(url: SEARCH, data: {"text": searched}).then((value) {
      List<dynamic> searches = value?.data['data']['data'];
      searchSModels = searches.map((e) => Products.fromJson(e)).toList();
      notifyListeners();
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////Check if user found//////////////////////////
  getRequest() {
    getBanners();
    getMobiles();
    getProfile();
    getFavorites();
    getRecently();
    getCards();
    getNotification();
    getCategories();
    searchProduct('Xiaomi');
    searchSProduct('z');
    getAddresses();
    getAbout();
    getQuestions();
    getOrders();
  }

  checkEnter() {
    getRequest();
    bool verify = SharedPreferencesHelper.x.getVerify();
    Future.delayed(Duration(seconds: 3)).then((value) => {
          if (SharedPreferencesHelper.x.getUserEnter() == 1)
            {
              verify
                  ? AppRouter.appRouter.goWithReplacement(ShowProgress())
                  : AppRouter.appRouter.goWithReplacement(LoginScreen())
            }
          else
            {AppRouter.appRouter.goWithReplacement(BoardingScreen())}
        });
    SharedPreferencesHelper.x.saveUserEnter();
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////Delete Product //////////////////////////////////////
  deleteCard(int id) {
    CardModel cardModel =
        cartsModels.where((element) => element.id == id).first;
    num price = cardModel.product!.price ?? 0;
    num quntity = cardModel.quantity ?? 0;
    total = total - quntity * price;
    cartsModels.remove(cardModel);
    DioHelper.dioHelper.delete(CARDS + '/${id}');
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  List<Questions> question = [];

  getQuestions() {
    DioHelper.dioHelper.getData(url: QUESTIONs).then((value) {
      List<dynamic> questions = value?.data['data']['data'];
      question = questions.map((e) => Questions.fromJson(e)).toList();
      notifyListeners();
    });
  }

  /////////////////////Select Image//////////////////////////////////////////
  String img64 = '';
  File? file;

  selectFile() async {
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile?.path ?? '');
    final bytes = file?.readAsBytesSync();
    img64 = base64Encode(bytes!);

    notifyListeners();
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////////Update profile/////////////////////////////////////
  bool isUpdate = false;

  updateProfile() {
    isUpdate = true;
    notifyListeners();
    DioHelper.dioHelper.putDataWithToken(url: UPDATEPROFILE, data: {
      "name": nameEdit.text,
      "phone": phoneEdit.text,
      "email": emailEdit.text,
      "password": passwordEdit.text,
      "image": img64
    }).then((value) {
      CustomDialog.customDialog.showCustom(value?.data['message']);
      isUpdate = false;
      notifyListeners();
    });
    getProfile();

  }

  fillControllers() {
    nameEdit.text = profileModel.data?.name ?? '';
    phoneEdit.text = profileModel.data?.phone ?? '';
    emailEdit.text = profileModel.data?.email ?? '';
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////Get My Profile/////////////////////
  TextEditingController nameEdit = TextEditingController();
  TextEditingController phoneEdit = TextEditingController();
  TextEditingController emailEdit = TextEditingController();
  TextEditingController passwordEdit = TextEditingController();

  Profile profileModel = Profile();

  getProfile() {
    DioHelper.dioHelper
        .getData(
      url: PROFILES,
    )
        .then((value) {
      profileModel = Profile.fromJson(value?.data);
      fillControllers();
      notifyListeners();
    });
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////// Get Address ///////////////////
  List<Addres> addresses = [];

  getAddresses() {
    DioHelper.dioHelper.getData(url: Address).then((value) {
      List<dynamic> addres = value?.data['data']['data'];
      addresses = addres.map((e) => Addres.fromJson(e)).toList();
      notifyListeners();
    });

  }

  TextEditingController nameAddress = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController notes = TextEditingController();
  int selectedAddress = -1;

  setAddress(dynamic v) {
    selectedAddress = v;
    notifyListeners();
  }

  bool isAddress = false;

  addAdddress() {
    if (nameAddress.text.length != 0 &&
        city.text.length != 0 &&
        region.text.length != 0 &&
        details.text.length != 0 &&
        notes.text.length != 0) {
      isAddress = true;
      notifyListeners();
      DioHelper.dioHelper.postData(url: Address, data: {
        "name": nameAddress.text,
        "city": city.text,
        "region": region.text,
        "details": details.text,
        "latitude": 198.32,
        "longitude": 55,
        "notes": notes.text
      }).then((value) {
        AppRouter.appRouter.back();
        CustomDialog.customDialog.showCustom(value?.data['message']);
        isAddress = false;
      });
      getAddresses();
    } else
      CustomDialog.customDialog.showCustom('fillFields'.tr());
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  TextEditingController holderName = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController lock = TextEditingController();
  TextEditingController promocode = TextEditingController();

//////////////////////////Search Widget when search in searchpage//////////////////////////
  searchWidget() {
    if (searches.length == 0 && recentlyProducts.length == 0) {
      return Container(
          margin: EdgeInsets.only(top: 100.h),
          child: isSearched
              ? CircularProgressIndicator()
              : Text('Searchanyproduct'.tr()));
    } else if (searches.length == 0 && recentlyProducts.length != 0) {
      return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ListTile(
            leading: Text('Recently'.tr()),
          ),
          GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 5,
                mainAxisExtent: 300,
              ),
              itemCount: recentlyProducts.length,
              itemBuilder: (context, index) =>
                  MobileItemWidget(mobileModel: recentlyProducts[index]))
        ],
      );
    } else if (searches.length != 0) {
      return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 5,
            mainAxisExtent: 300,
          ),
          itemCount: searches.length,
          itemBuilder: (context, index) =>
              MobileItemWidget(mobileModel: searches[index]));
    }
    notifyListeners();
    return Text('no');
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}
