import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobitech/business_logic/view_model/work_orders_vm.dart';
import 'package:mobitech/view/notify/status_updater.dart';
import 'package:provider/provider.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/business_logic/model/account_m.dart';
import 'package:mobitech/business_logic/usecase/validation.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../landing_page.dart';

class Login_page extends StatefulWidget{
  const Login_page({super.key});

  @override
  State<StatefulWidget> createState()=> Login_page_state();

}

class Login_page_state extends State<Login_page> {
  var service = FlutterBackgroundService();

  var sharedPreferences= SharedPreferences.getInstance();
  //bool status = false;
  bool _isChecked = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email'],);

  Future<dynamic>  handleSignIn() async {
    try {
      var prefs = await sharedPreferences;
      await prefs.clear();
      await prefs.reload();
      handleSignOut();
      var account = await _googleSignIn.signIn();
      var googleKey = await account?.authentication;
      print('#####################################################################');
      print("Acount mail: ${account?.email}");
      print("Acount name: ${account?.displayName}");
      print("Acount id: ${account?.id}");
      print("AccessToken: ${googleKey?.accessToken}");
      print("idToken: ${googleKey?.idToken}");
      var _prefs =await sharedPreferences;

      print('#######################################\nemail = ${await _prefs.getString('email') ?? " not found"}');
      print('#####################################################################');
      return account;
    } catch (error) {
      print(error);
    }
  }


  save_in_api(dynamic account,bool check)async {
    final _acountVm = Provider.of<AccountVM>(context, listen: false);
    final _workorders_vm = Provider.of<WorkOrdersVM>(context, listen: false);
    try {
      //_forget();
      print('##########################################################');
      if(account != null){
        var _prefs =await sharedPreferences;
        var userM = await _acountVm.login(account.displayName+ ' g');
        if(userM == null){
          var statusCode = await _acountVm.CreateAccount(AccountM(
              amail: account.email,
              pass: '',
              aname: account.displayName+ ' g',
              atel: '',
              id: 0,
              aface: '',
              agoogle: account.email));
          userM = await _acountVm.login(account.displayName+ ' g');
        }
        print(userM?.id.toString()??'');
        await _prefs.setString("Userid", userM?.id.toString()??'');
        print("from google user id = "+_prefs.getString("Userid").toString());

        StatusUtils.inLanding = true;

        await StatusUtils.SaveStatusList(_workorders_vm, _prefs);
        await _handleRemeberme(account.email, account.displayName+ ' g');
        service.startService();
      } else{
        print('##################[null obj]#######################');
      }
    } catch (err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something err",)));
    }
  }


  _handleRemeberme(String email,String userName) async{
    var _prefs =await sharedPreferences;
    print('#####################[check]###############################\n$_isChecked');
    print('#####################[Local data]###############################\n');
      await _prefs.setBool("remember_me", _isChecked);
      await _prefs.setString('email', email);
      await _prefs.setString('user', userName);
      await _prefs.setString("account_type", "Google");

    print('email: ${await _prefs.getString('email')}\n '
        'name: ${await _prefs.getString('user')}\n '
        'is checked: ${await _prefs.getBool('remember_me')}');
    print('#####################[end Local data]###############################\n');
    await _prefs.reload();
  }


  _forget()async{
    var _prefs =await sharedPreferences;
    setState(() async {
      await _prefs.remove('email');
      await _prefs.remove('user');
      await _prefs.remove('account_type');
      await _prefs.setBool("remember_me", _isChecked);
    });
    print('##################[pref data]#####################\naccount_type = ${_prefs.getBool('remember_me') ?? " not found"}');
  }

  Future<void> handleSignOut() async {
    await _googleSignIn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google account Login page'),
      ),
      body:Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text('You are not currently signed in.'),
              SignInButton(
                Buttons.Google,
                onPressed: ()async {
                  setState(() async {
                    var acc = await handleSignIn();
                    if(acc != null){
                      await save_in_api(acc,_isChecked);
                      // service.startService();
                      Navigation.puchReplace(const LandingPage(), context);
                    }
                  });

                },
              ),
            ],
          ),
        ),
      )
    );

  }
}
