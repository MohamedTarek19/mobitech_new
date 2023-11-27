import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/account_m.dart';
 import 'package:mobitech/data_layer/accounts/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_layer/localdata/localdata.dart';
class AccountVM extends ChangeNotifier{

  String? userDetails;


  AccountRep accountRep=AccountRep();
  SavedLocalData savedLocalData=SavedLocalData();
  void removeLocalData(String key)async{
    await savedLocalData.removeKey(key);
    userDetails=null;
    notifyListeners();
  }

  void LoadUserData()async{
   userDetails=await savedLocalData.getUserName();
   // await getSocialName();
    notifyListeners();
  }

  // getSocialName() async{
  //   var _prefs =await sharedPreferences;
  //   socialName = await _prefs.getString('user')!;
  //   //notifyListeners();
  // }

  void keepLogin(String userName)async{
     await savedLocalData.saveUserLogin(userName);
     userDetails=await savedLocalData.getUserName();

     notifyListeners();

  }

  Future<dynamic> CreateAccount(AccountM accoutM)async{
    var result= await accountRep.createAccount(accoutM);
    return result;
  }

  Future<AccountM?> login(String email)async{

    var result= await accountRep.login(email);
    return result;
  }




} 
