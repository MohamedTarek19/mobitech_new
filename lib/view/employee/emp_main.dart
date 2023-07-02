import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobitech/view/employee/emp_in_out.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:external_app_launcher/external_app_launcher.dart';


import '../../utils/navigation.dart';
import '../../widgets/service_widget.dart';

class EmpMain extends StatelessWidget {
  const EmpMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainContainer(
        widget: Scaffold(
      appBar: CustomAbbBar("الموظفين", context),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              ServiceWidget(
                imahePath: "assets/fingerprint.png",
                name: "الحضور والانصراف",
                action: () async {
                  await LaunchApp.isAppInstalled(
                      androidPackageName: 'com.ruanmeng.biotime'
                  );
                  await LaunchApp.openApp(
                      androidPackageName: 'com.ruanmeng.biotime',
                      openStore: true,
                  );
   
            // Navigation.puchNav(EmpCheckOutIn(), context);
    
                  // final List<BiometricType> availableBiometrics =
                  //     await auth.getAvailableBiometrics();

                  // if (availableBiometrics.isNotEmpty) {
                  //   for(var v in availableBiometrics){

                 
                  //     print(v.name);
                  //   }
                  // }

                  // if (availableBiometrics.contains(BiometricType.weak)) {
                   
                  // }
                  // Navigation.puchNav(const JobsMain(), context);
                },
              ),
            ],
          ),

        ]),
      ),
    ));
  }
}
