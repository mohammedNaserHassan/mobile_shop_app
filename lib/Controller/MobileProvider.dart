import 'package:flutter/material.dart';
import 'package:mobile_shop_app/Helper/DioHelper.dart';
import 'package:mobile_shop_app/Helper/SharedPreferencesHelper.dart';
import 'package:mobile_shop_app/Model/BannerModel.dart';
import 'package:mobile_shop_app/Model/CardModel.dart';
import 'package:mobile_shop_app/Model/FavoriteModel.dart';
import 'package:mobile_shop_app/Model/ProductModel.dart';
import 'package:mobile_shop_app/Model/ProfileModel.dart';
import 'package:mobile_shop_app/Model/SearchModel.dart';
import 'package:mobile_shop_app/Model/UserModel.dart';
import 'package:mobile_shop_app/Services/AppRouter.dart';
import 'package:mobile_shop_app/Services/customDialog.dart';
import 'package:mobile_shop_app/View/Auth/LoginScreen.dart';
import 'package:mobile_shop_app/View/Auth/checkEmailScreen.dart';
import 'package:mobile_shop_app/View/Auth/recieveOtpScreen.dart';
import 'package:mobile_shop_app/View/Features/BoardingScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/HomeScreen.dart';
import 'package:mobile_shop_app/View/TabScreens/Tabs/ExploreTab.dart';
import 'package:mobile_shop_app/View/TabScreens/Tabs/FavouriteTab.dart';
import 'package:mobile_shop_app/View/TabScreens/Tabs/HomeTab.dart';
import 'package:mobile_shop_app/View/TabScreens/Tabs/ProfileTab.dart';
import 'package:mobile_shop_app/View/TabScreens/Tabs/ShopTab.dart';

import '../View/Auth/SignupScreen.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:mobile_shop_app/Services/Constants.dart';

class MobileProvider extends ChangeNotifier {

/////////////Sae Language/////////////////////////////
  bool isSavedLanguage = false;

  String getLanguage() {
    isSavedLanguage = SharedPreferencesHelper.x.getLang();
    SharedPreferencesHelper.x.saveLang(!isSavedLanguage);
    return isSavedLanguage ? 'en' : 'ar';
  }

  ///////////////////////////////////////////////////////////////////////////

  /////// set Bottom Navigation ////////////////////////////
  List<Widget> tabs = [
    HomeTab(),
    const ShopTab(),
   const  ExploreTab(),
 const   FavouriteTab(),
    ProfileTab()
  ];
  int selectedIndex = 0;

  setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



  ////////////Get All Mobiles ///////////////////////////////////////////
  List<Products> products = [];
  List<dynamic> productsItems = [];
  String ads = '';

  bool isShemmer = false;

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
    DioHelper.dioHelper.customPostData(
      url: CARD,
      data: {"product_id": id},
    ).then((value) {
      CustomDialog.customDialog.showCustom(value?.data['message']);
      getCards();
    });
    notifyListeners();
  }

  CardItem card = CardItem();
  num total = 0, subTotal = 0;

  getCards() {
    card = CardItem();
    DioHelper.dioHelper.getData(url: CARD).then((value) {
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
      url: CARD + '/${id}',
      data: {"quantity": quntity},
    );
    notifyListeners();
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////Add or Remove to Favorite/////////////////////////////////////////////////
  List<FavoriteModel> favoritesModels = [];

  removeFavorite(int id,int secondId) {
  Products produc =  products.where((element) => element.id==secondId).first;
    produc.inFavorites=false;
  favoritesModels.removeWhere((element) => element.id == id);
  DioHelper.dioHelper.delete( FAVORRITE + '/${id}').then((value) => getMobiles());
    notifyListeners();
  }

  addOrRemoveFavourite(int id,) {
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
  List<SearchModel> searchModels = [];

  searchProduct(String searched) {
    DioHelper.dioHelper
        .postData(url: SEARCH, data: {"text": searched}).then((value) {
      List<dynamic> searches = value?.data['data']['data'];
      searchModels = searches.map((e) => SearchModel.fromJson(e)).toList();
    });
  }

  List<SearchModel> searchSModels = [];

  searchSProduct(String searched) {
    DioHelper.dioHelper
        .postData(url: SEARCH, data: {"text": searched}).then((value) {
      List<dynamic> searches = value?.data['data']['data'];
      searchSModels = searches.map((e) => SearchModel.fromJson(e)).toList();
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////Check if user found//////////////////////////

  checkEnter() {
    getBanners();
    getMobiles();
    getProfile();
    getFavorites();
    getCards();
    searchProduct('Xiaomi');
    searchSProduct('z');
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
    DioHelper.dioHelper.delete(CARD + '/${id}');
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////Get My Profile/////////////////////

  Profile profileModel = Profile();

  getProfile() {
    DioHelper.dioHelper.getData(
      url: PROFILE,
    )
        .then((value) {
      profileModel = Profile.fromJson(value?.data);
      notifyListeners();
    });
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}
