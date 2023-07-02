import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mobitech/business_logic/view_model/work_orders_vm.dart';
import 'package:mobitech/view/landing_page.dart';
import 'package:mobitech/view/notify/status_updater.dart';
import 'package:mobitech/view/test_api/fetch_api_view.dart';
import 'package:provider/provider.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/business_logic/model/account_m.dart';
import 'package:mobitech/business_logic/usecase/validation.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestFacelogin extends StatefulWidget {
  const TestFacelogin({Key? key}) : super(key: key);

  @override
  State<TestFacelogin> createState() => _TestFaceloginState();
}

class _TestFaceloginState extends State<TestFacelogin> {
  bool _isLoggedIn = false;
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  var sharedPreferences = SharedPreferences.getInstance();

  _login() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      _accessToken = loginResult.accessToken;
      final userInfo = await FacebookAuth.instance.getUserData();
      _userData = userInfo;
    } else {
      print('ResultStatus: ${loginResult.status}');
      print('Message: ${loginResult.message}');
    }
  }

  _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
  }

  //bool status = false;
  bool _isChecked = false;

  _handleRemeberme(String email, String userName) async {
    var _prefs = await sharedPreferences;
    print(
        '#####################[check]###############################\n$_isChecked');
    print('#####################[Local data]###############################\n');
    await _prefs.setBool("remember_me", _isChecked);
    await _prefs.setString('email', email);
    await _prefs.setString('user', userName);
    await _prefs.setString("account_type", "facebook");

    print(
        'email: ${_prefs.getString('email')}\n name: ${_prefs.getString('user')}\n is checked: ${_prefs.getBool('remember_me')}');
    print(
        '#####################[end Local data]###############################\n');
    await _prefs.reload();
  }

  _forget() async {
    var _prefs = await sharedPreferences;
    setState(() {
      _prefs.remove('email');
      _prefs.remove('user');
      _prefs.remove('account_type');
      _prefs.setBool("remember_me", _isChecked);
    });
    print(
        '##################[pref data]#####################\naccount_type = ${_prefs.getBool('remember_me') ?? " not found"}');
  }

  @override
  Widget build(BuildContext context) {
    final _acountVm = Provider.of<AccountVM>(context, listen: false);
    final _workorders_vm = Provider.of<WorkOrdersVM>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("دخول بالفيسيوك"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Login with Facebook"),
                onPressed: () async {
                  await _logOut();
                  await _login();
                  setState(() async {
                    print(_userData!['email']);
                    try {
                      Navigation.puchReplace(const LandingPage(), context);
                        _forget();
                        print('##########################################################');
                        print("done");
                        print('##########################################################');
                        var _prefs =await sharedPreferences;
                        var userM = await _acountVm.login('${_userData!["name"]} f');
                        if(userM == null){
                          var statusCode = await _acountVm.CreateAccount(AccountM(
                              amail: _userData!["email"].toString(),
                              pass: '',
                              aname: '${_userData!["name"]} f',
                              atel: '', id: 0,
                              aface: _userData!["email"].toString(),
                              agoogle: ''));
                          if (statusCode == 201) {
                            print('#########################################');
                          }
                          userM = await _acountVm.login('${_userData!["name"]} f');
                        }
                      await _prefs.setString("Userid", userM?.id.toString()??'');
                      print("from facebook user id = "+_prefs.getString("Userid").toString());
                      StatusUtils.inLanding = true;

                      await StatusUtils.SaveStatusList(_workorders_vm, _prefs);
                        _handleRemeberme(
                            _userData!['email'], _userData!["name"] + ' f');
                    } catch (err) {
                      print(err);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                        "Something err",
                      )));
                    }
                    _isLoggedIn = true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
