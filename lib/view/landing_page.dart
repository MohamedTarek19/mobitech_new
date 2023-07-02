import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:mobitech/business_logic/view_model/categories_vm.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/view/home/home.dart';
import 'package:mobitech/view/maintance/maintain_form/in_home_form/service_type.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobile_form.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobileCategory.dart';
import 'package:mobitech/view/maintance/maintain_form/regions.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/view/notify/notification_page.dart';
import 'package:mobitech/view/tips/landing_tips.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/text_button.dart';
import 'package:provider/provider.dart';
import 'package:mobitech/view/accounts/logingoogle.dart';
import 'package:mobitech/view/accounts/google_signin_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/appthrmr.dart';

var sharedPreferences= SharedPreferences.getInstance();

String? socialName;

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  var landingInex = 0;
  var currentAppBarText = ["Mobi-Tech"];
  getSocialName() async{
    var _prefs =await sharedPreferences;
    socialName = await _prefs.getString('user');
    print("##############[Social Name]###############\n${socialName}\n###########################################");
    try{
      socialName = socialName!.replaceRange(socialName!.length - 2, socialName!.length, '');
      print("##############[Social Name]###############\n${socialName}\n###########################################");
      //notifyListeners();
    }catch(err){
      print("#######################[Error]#############################");
    }
  }

  var landingContent = [
    HomeScreen(),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    MHelper.isInEmp = false;
    getSocialName();
    // var service = FlutterBackgroundService();
    // service.startService();
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
    var service = FlutterBackgroundService();

    return Drawer(
      width: AppTheme.dynamicW(context) * .70,
      backgroundColor: AppTheme.secondColor,
      child: Column(children: [
        const SizedBox(
          height: 100,
        ),
        Text(
          "Hi,${socialName ?? '...'}",
          style: Theme.of(context).textTheme.headline2,
        ),
        TextBtn(
            text: socialName == null ? "Login" : "Logout",
            action: () async {
              var _prefs =await sharedPreferences;

              if (account_vm.userDetails == null) {
                service.invoke("stopService");

                await _prefs.clear();

                Navigation.puchReplace(const LoginScreen(), context);
              } else {
                service.invoke("stopService");
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
        ),
        TextBtn(text: "Notifications", action: (){
          Navigation.puchNav(const ServiceType(), context);

        }),
        Container(
          //  width: double.infinity,
          width: 150,
          color: AppTheme.mainColor,
          height: 3,
          padding: AppTheme.marginall,
        ),

      ]),
    );
  }
}
