import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:mobitech/business_logic/usecase/validation.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/new_account.dart';
import 'package:mobitech/view/accounts/loginface.dart';
import 'package:mobitech/view/emp_landing_page.dart';
import 'package:mobitech/view/landing_page.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/custom_form-fild.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/password-form-field.dart';
import 'package:mobitech/widgets/snackbar.dart';
import 'package:mobitech/widgets/text_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../business_logic/view_model/account_vm.dart';
import 'package:mobitech/view/accounts/test_login_google.dart';




class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggedIn =false;
  Map _userObj ={};


  _forget()async{
    setState(()async {
      var _prefs =await sharedPreferences;
      await _prefs.remove('email');
      await _prefs.remove('user');
      await _prefs.remove('id');
      await _prefs.remove('account_type');
      print('##################[pref data]#####################\naccount_type = ${await _prefs.getBool('remember_me') ?? " not found"}');
    });

  }
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  var formK = GlobalKey<FormState>();

//########################################################

  bool isLoggedIn = false;
   var profileData;
//########################################################
  @override
  Widget build(BuildContext context) {
    var service = FlutterBackgroundService();
    final _acountVm = Provider.of<AccountVM>(context, listen: false);
    _forget();
    return MainContainer(
        widget: Scaffold(
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        child: Form(
          key: formK,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Text("Mobi-Tec",
                      style: Theme.of(context).textTheme.headline1)),
              const SizedBox(
                height: 50,
              ),
              CustomFormField(
                
                controller: userName,
                iconData: Icons.person,
                hint: "اسم االمستخدم",
                errorMessage: "In Valid Input",
              ),
              PasswordTextField(
                controller: password,
                validator: Validator.isValidPassword,
                hint: "كلمة المرور",
                errorMessage: "In Valid Input",
              ),
              CustomBtn(
                  name: "دخول",
                  action: () async {

                    if (formK.currentState!.validate()) {
                      var userM = await _acountVm.login(userName.text);

                      if (userM != null && userM.pass == password.text) {
                        if (!mounted) {
                          return;
                        }
                        _acountVm.keepLogin(  userM.aname!);
                        MHelper.isInEmp = true;
                        Navigation.puchReplace(const LandingPage_emp(), context);
                      } else {
                        if (!mounted) {
                          return;
                        }
                        CSnackBar.showSnackBar(context, "Password or user name not correct!");
                      }
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBtn(
                      text: "حساب جديد",
                      action: () {
                        Navigation.puchNav(const Registeration(), context);
                      }),

                ],
              ),

              ///Social Login
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: AppTheme.marginall,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Image.asset("assets/google.png"),
                              iconSize: 50,
                              onPressed: () async {
                                print("######################################################################################");
                                MHelper.isInEmp = false;
                                //Navigation.puchReplace(const SignInDemo(), context);
                                Navigation.puchReplace(Login_page(), context);
                              }
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                          ],
                        ),
                      ),
                      //facebook login
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Image.asset("assets/facebook.png"),
                              iconSize: 50,
                        onPressed: ()  {
                          print('openedr');
                          MHelper.isInEmp = false;
                          Navigation.puchReplace(const Facelogin(), context);
                        }),
                        const SizedBox(
                          width: 7,
                        ),


                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
        ));
  }
}


