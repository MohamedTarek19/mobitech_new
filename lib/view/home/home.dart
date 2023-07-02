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
import 'package:mobitech/view/maintance/mainance_details.dart';
import 'package:mobitech/view/maintance/mainance_search.dart';
import 'package:mobitech/view/maintance/maintenance_tips.dart';
import 'package:mobitech/view/stolens/stolen_main.dart';
import 'package:mobitech/view/store/stroe_details.dart';
import 'package:mobitech/view/store/shopdetails.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';


import '../../utils/navigation.dart';
import '../../widgets/service_widget.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var account_vm=Provider.of<AccountVM>(context);
    return  SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:   [

                  ServiceWidget(
                    imahePath: "assets/search.png",
                    name: "إستعلام صيانة",
                    action: (){
                        Navigation.puchNav(const MaintanceSearch(), context);

                    },
                  ),
                  ServiceWidget(
                    imahePath: "assets/repair.png",
                    name: "صيانة الاجهزة",
                    action: () {
                      Navigation.puchNav(MaintTips(), context);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  ServiceWidget(
                    imahePath: "assets/mobile.png",
                    name: "اجهزة مسروقة",
                    action: () {
                       Navigation.puchNav(const StolenMain(), context);
                       },
                  ),
                  ServiceWidget(
                    imahePath: "assets/marketing.png",
                    name: "محلات شراء",
                    action: (){
                      Navigation.puchNav(const ShopDetails(), context);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                children:   [
                  ServiceWidget(
                    imahePath: "assets/house.png",
                    name: "متجر",
                    action: (){
                       Navigation.puchNav(const StoreDetails(), context);
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
                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [

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

