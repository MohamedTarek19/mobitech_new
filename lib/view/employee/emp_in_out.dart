 import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobitech/business_logic/model/empin_m.dart';
import 'package:mobitech/business_logic/view_model/emp_vm.dart';
import 'package:provider/provider.dart';

import '../../widgets/cuttom_appbar.dart';
import '../../widgets/main_container.dart';
import '../jobs/jobs_main.dart';

class EmpCheckOutIn extends StatelessWidget {
  const EmpCheckOutIn({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    var emp_vm=Provider.of<EmpVm>(context,listen: false);


    return MainContainer(widget: Scaffold(
      appBar:  CustomAbbBar("الحضور والانصراف", context),
      body:  SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        
        crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
      ServiceWidget2(imahePath: "assets/fingerprint.png", name: "تسجيل حضور",action: (){
      //Navigation.puchNav(const JobRequest(), context);
      //emp_vm.empCheckIn(Empin());
      
      },),
      ServiceWidget2(imahePath: "assets/fingerprint.png", name: "تسجيل انصراف",action: (){
      
           // Navigation.puchNav(const JobSearch(), context);

        
      },)
      
      
        ]),
      ),
    ));
    
  }
    
  }
