import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/view/about/aboutus.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/view/employee/emp_main.dart';
import 'package:mobitech/view/jobs/jobs_main.dart';
import 'package:mobitech/view/landing_page.dart';
import 'package:mobitech/view/maintance/mainance_search.dart';
import 'package:mobitech/view/maintance/maintenance_test.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/view/maintance/test2.dart';
import 'package:mobitech/view/stolens/stolen_main.dart';
import 'package:mobitech/view/store/stroe_details.dart';
import 'package:mobitech/view/store/shopdetails.dart';
import 'package:mobitech/view/tips/landing_tips.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';
import 'package:mobitech/view/maintance/maintenance_tips.dart';


import '../../utils/navigation.dart';
import '../../widgets/service_widget.dart';


class HomeScreenemp extends StatefulWidget {
  const HomeScreenemp({Key? key}) : super(key: key);

  @override
  State<HomeScreenemp> createState() => _HomeScreenempState();
}

class _HomeScreenempState extends State<HomeScreenemp> {
  @override
  Widget build(BuildContext context) {
    MHelper.isInEmp = true;
    var account_vm=Provider.of<AccountVM>(context);
    return  SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:   [
              ServiceWidget(
                imahePath: "assets/fingerprint.png",
                name: "الموظفين",

                action: ()async {
                  if  (account_vm.userDetails==null) {
                    Navigation.puchNav(const LoginScreen(), context);
                  }
                  else{
                    Navigation.puchNav(const EmpMain(), context);


                  }
                },
              ),
              ServiceWidget(
                imahePath: "assets/jobs.png",
                name: "التوظيف",
                action: (){
                  Navigation.puchNav(const JobsMain(), context);

                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServiceWidget(
                imahePath: "assets/repair.png",
                name: "صيانة الاجهزة",
                action: () async {
                  setState(() {
                    MHelper.isInMaintenance = true;
                  });
                  if  (account_vm.userDetails==null) {
                    Navigation.puchNav(const LoginScreen(), context);
                    //Navigation.puchNav(maintenance(), context);
                  }
                  else{
                    //Navigation.puchNav(maintenance(), context);
                    Navigation.puchNav(MaintTips(), context);

                  }
                },
              ),
              // ServiceWidget(
              //   imahePath: "assets/mobile.png",
              //   name: "  اجهزة مسروقة",
              //   action: () {
              //
              //     if(account_vm.userDetails==null) {
              //       Navigation.puchNav(LoginScreen(), context);
              //     }
              //     else{
              //       Navigation.puchNav(const StolenMain(), context);
              //
              //     }
              //   },
              // ),
              ServiceWidget(
                imahePath: "assets/search.png",
                name: "إستعلام عن صيانة",
                action: () {

                  if(account_vm.userDetails==null) {
                    Navigation.puchNav(LoginScreen(), context);
                  }
                  else{
                    Navigation.puchNav(const MaintanceSearch(), context);

                  }
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children:   [
              ServiceWidget(
                imahePath: "assets/marketing.png",
                name: "محلات شراء",
                action: (){
                  Navigation.puchNav(const ShopDetails(), context);
                },
              ),
              ServiceWidget(
                imahePath: "assets/house.png",
                name: "متجر",
                action: (){

                  Navigation.puchNav(const StoreDetails(), context);

                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              ServiceWidget(
                imahePath: "assets/sale.png",
                name: "عروض ",
              ),
              ServiceWidget(
                imahePath: "assets/houseselling.png",
                name: "بيع وشراء",
              ),
            ],
          ),
          Row(
            children:   [
              ServiceWidget(
                imahePath: "assets/about.png",
                name: "عن الشركة",
                action: (){

                  Navigation.puchNav(const AboutUs(), context);

                },
              ),

            ],
          ),
        ],
      ),

    );
  }
}


