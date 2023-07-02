import 'package:shared_preferences/shared_preferences.dart';
class SavedLocalData{

 var sharedPreferences= SharedPreferences.getInstance();

 Future<void> removeKey(String key)async{
   var pref=await sharedPreferences;
   await pref.remove(key);
 }

 Future<void> saveUserLogin(String userName)async{
  var pref=await sharedPreferences;
  await pref.setString("userName", userName);
 }

 Future<String?> getUserName()async{
  var pref=await sharedPreferences;
  var data= pref.getString("userName");
  return  data;
 }

 Future<void> setTipsViewed(bool isVisited)async{
  var pref=await sharedPreferences;
  await pref.setBool("tips", isVisited);
 }

 Future<bool?> getIsTipsViewd()async{
  var pref=await sharedPreferences;
  var data= pref.getBool("tips");
  return  data;
 }


}