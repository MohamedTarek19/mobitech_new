import 'package:flutter/material.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/view/landing_page.dart';

checkSocialLogin(BuildContext context,var _acountVm) async{
  var _prefs =await sharedPreferences;

  String user = await _prefs.getString('user')?? '0';
  print(user);
  String email = await _prefs.getString('email')?? '';
  print(email);
  String acctype =await _prefs.getString('account_type')??'';
  print(acctype);
  var userM = await _acountVm.login(email);
  if(userM != null && user != '0'){
    if(email == userM.agoogle || email == userM.aface){
      print('#########################################\nlanding');
      Navigation.puchReplace(const LandingPage(), context);
    }else{Navigation.puchReplace(const LoginScreen(), context);}

  }else{
    Navigation.puchReplace(const LoginScreen(), context);
  }
}