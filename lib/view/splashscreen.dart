import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:mobitech/data_layer/localdata/localdata.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/view/home/home.dart';
import 'package:mobitech/view/landing_page.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/view/tips/landing_tips.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var sharedPreferences= SharedPreferences.getInstance();

class SplachScreen extends StatelessWidget {
  const SplachScreen({Key? key}) : super(key: key);

  checkSocialLogin(BuildContext context,var _acountVm) async{
    var _prefs =await sharedPreferences;

    String user = await _prefs.getString('user')?? '0';
    print(user);
    var userM = await _acountVm.login(user);
    String email = await _prefs.getString('email')?? '';
    print(email);
    String acctype =await _prefs.getString('account_type')??'';
    print(acctype);
    if(userM != null && user != '0'){
      if(email == userM.agoogle || email == userM.aface){
        print('#########################################\nlanding');
        Navigation.puchReplace(const LandingPage(), context);
      }else{Navigation.puchReplace(const LoginScreen(), context);}

    }else{
    Navigation.puchReplace(const LoginScreen(), context);
    }
  }
  @override
  Widget build(BuildContext context) {
    final _acountVm = Provider.of<AccountVM>(context, listen: false);
    bool? x;
    print(x??"not visited");
    print('in landing');
    Future.delayed(const Duration(seconds: 3), () {
      Provider.of<AccountVM>(context,listen: false).LoadUserData();
      SavedLocalData savedLocalData=SavedLocalData();
      savedLocalData.getIsTipsViewd().then((value) {
        MHelper.isInMaintenance = false;
        Navigation.puchReplace(const LandingTips(), context);
        //Navigation.puchReplace(const LoginScreen(), context);
        //print('in landing');
        //checkSocialLogin(context,_acountVm);

      }
      );
    });
    return Scaffold(
        body: MainContainer(
      widget: Center(
        child: Image.asset("assets/logo.png"),
      ),
    ));
  }
}
