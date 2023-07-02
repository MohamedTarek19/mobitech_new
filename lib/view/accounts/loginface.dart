import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
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

class Facelogin extends StatefulWidget {
  const Facelogin({Key? key}) : super(key: key);

  @override
  State<Facelogin> createState() => _FaceloginState();
}

class _FaceloginState extends State<Facelogin> {
  bool _isLoggedIn = false;
  Map _userObj = {};
  var sharedPreferences = SharedPreferences.getInstance();
  var service = FlutterBackgroundService();


  _logOut() {
    print(_userObj['email']);
    FacebookAuth.instance.logOut().then((value) {
      setState(() {
        _isLoggedIn = false;
        _userObj = {};
      });
    });
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
                  FacebookAuth.instance.login(
                      permissions: ["public_profile", "email"]).then((value) {
                    FacebookAuth.instance.getUserData().then((userData) {
                      setState(() async {
                        _userObj = userData;
                        print(_userObj['email']);
                        try {

                          _forget();
                          var _prefs = await sharedPreferences;
                          await _prefs.clear();
                          await _prefs.reload();
                          var userM = await _acountVm.login('${_userObj["name"]} f');
                          print('##########################################################');
                          print("done");
                          print('##########################################################');
                          if (userM == null) {
                            var statusCode = await _acountVm.CreateAccount(AccountM(
                                amail: _userObj["email"].toString(),
                                pass: '',
                                aname: '${_userObj["name"]} f',
                                atel: '',
                                id: 0, aface: _userObj["email"].toString(),
                                agoogle: ''));
                            userM = await _acountVm.login('${_userObj["name"]} f');
                          }
                          await _prefs.setString("Userid", userM?.id.toString()??'');
                          print("from facebook user id = "+_prefs.getString("Userid").toString());
                          StatusUtils.inLanding = true;

                          await StatusUtils.SaveStatusList(_workorders_vm, _prefs);
                          await _handleRemeberme(_userObj['email'], _userObj["name"] + ' f');
                          service.startService();
                          Navigation.puchReplace(const LandingPage(), context);
                        } catch (err) {
                          print(err);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                            "Something err",
                          )));
                        }

                        _isLoggedIn = true;
                      });
                    });
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
