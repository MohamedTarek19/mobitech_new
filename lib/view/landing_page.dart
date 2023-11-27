import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/maintenance_m.dart';
import 'package:mobitech/business_logic/model/maintenance_request_m.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:mobitech/data_layer/maintenance/maintenance.dart';
import 'package:mobitech/data_layer/maintenance_request/maintenance_request.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/view/home/home.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/text_button.dart';
import 'package:provider/provider.dart';
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
                await _prefs.clear();

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
        ),
        TextBtn(text: "Notifications", action: () async {
          print('dsaadsa');
          // MaintenanceRequestRep maint = MaintenanceRequestRep();
          // MaintenanceRequestM m = MaintenanceRequestM(
          //     area: '1',
          //     location: '1',
          //     coordinates: '1',
          //     phone: '1',
          //     name:  '1',
          //     preferredtime: '1',
          //     problemdescription: '1',
          //     maintenancetype: '1',
          //   buildingtype: '1',
          //   deffict: '1',
          //   devicecategory: '1',
          //   factory: '1',
          //   inhomecategory:'1' ,
          //   model:'1' ,
          //   os: '1',
          //   photourl: '1',
          //   servicetype: '1',
          // );
          // await maint.createRequest(m);

          //await rep.CreateTest();

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
