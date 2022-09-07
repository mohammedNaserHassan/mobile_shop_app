import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{
  SharedPreferencesHelper._();
  static SharedPreferencesHelper x =SharedPreferencesHelper._();
  SharedPreferences? sharedPreferences;

  initSharedPreference()async{
    sharedPreferences= await SharedPreferences.getInstance();
  }
  saveVerify(bool  verify){
    sharedPreferences?.setBool('verify', verify);
  }
  bool  getVerify(){
    return sharedPreferences?.getBool('verify')??false;
  }

  removeVerify(){
    sharedPreferences?.remove('verify');
  }

  saveName(String  token){
    sharedPreferences?.setString('name', token);
  }
  String  getName(){
    return sharedPreferences?.getString('name')??'';
  }

  removeName(){
    sharedPreferences?.remove('name');
  }

  saveLang(bool isSave){
    sharedPreferences?.setBool('lang', isSave);
  }

 bool  getLang(){
  return  sharedPreferences?.getBool('lang')??false;
 }

 saveUserEnter(){
    sharedPreferences?.setInt('entered', 1);
 }

 int getUserEnter(){
   return  sharedPreferences?.getInt('entered')??0;

 }

 saveFavorite(bool favorite){
   sharedPreferences?.setBool('fav', favorite);
 }

bool  getFavorite(){
   return  sharedPreferences?.getBool('fav')??false;

 }
}