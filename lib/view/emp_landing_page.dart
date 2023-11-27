import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/view/home/home.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/view/tips/landing_tips.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/text_button.dart';
import 'package:provider/provider.dart';

import 'package:mobitech/view/accounts/test_google_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/appthrmr.dart';
import 'home/homeemp.dart';

class LandingPage_emp extends StatefulWidget {
  const LandingPage_emp({Key? key}) : super(key: key);

  @override
  State<LandingPage_emp> createState() => _LandingPage_empState();
}

class _LandingPage_empState extends State<LandingPage_emp> {
  var landingInex = 0;
  var currentAppBarText = ["Mobi-Tech"];

  var landingContent = [
    HomeScreenemp(),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=> false,
      child: MainContainer(
          widget: Scaffold(
            key: _scaffoldKey,
            endDrawer:const AppDrawer(),
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text(
                currentAppBarText[landingInex],
                style: Theme.of(context).textTheme.headline2,
              ),
              centerTitle: true,
            ),
            body: landingContent[landingInex],
          )),
    );
  }
}

////////////app Drawer
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);
  //_handleSignOut();
  @override
  Widget build(BuildContext context) {
    var account_vm = Provider.of<AccountVM>(context);
    return Drawer(
      width: AppTheme.dynamicW(context) * .70,
      backgroundColor: AppTheme.secondColor,
      child: Column(children: [
        const SizedBox(
          height: 100,
        ),
        Text(
          "Hi,${account_vm.userDetails ?? '...'}",
          style: Theme.of(context).textTheme.headline2,
        ),
        TextBtn(
            text: account_vm.userDetails == null ? "Login" : "Logout",
            action: () {
              if (account_vm.userDetails == null) {

                Navigation.puchReplace(const LoginScreen(), context);
              } else {
                //  Navigation.puchNav(const LoginScreen(), context);
                account_vm.removeLocalData("userName");
              }
            }),
        Container(
          //  width: double.infinity,
          width: 150,
          color: AppTheme.mainColor,
          height: 3,
          padding: AppTheme.marginall,
        )
      ]),
    );
  }
}
