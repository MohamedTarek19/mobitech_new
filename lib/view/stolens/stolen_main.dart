import 'package:flutter/material.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/jobs/job_search.dart';
import 'package:mobitech/view/jobs/jobs_req.dart';
import 'package:mobitech/view/stolens/stolen_add.dart';
import 'package:mobitech/view/stolens/stolen_search.dart';
  import 'package:mobitech/widgets/main_container.dart';
 
 import '../../widgets/cuttom_appbar.dart';
import '../jobs/jobs_main.dart';

class StolenMain extends StatelessWidget {
const StolenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MainContainer(widget: Scaffold(
      appBar:  CustomAppBar("اجهزة مسروقة", context),
      body:  SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        
        crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
      ServiceWidget2(imahePath: "assets/stolen.png", name: "تبليغ عن جهاز مسروق",action: (){
      Navigation.puchNav(const StolenAdd(), context);
      
      
      },),
      ServiceWidget2(imahePath: "assets/serial.png", name: "بحث عن جهاز ",action: (){
      
            Navigation.puchNav(const LostSearch(), context);

        
      },)
      
      
        ]),
      ),
    ));
    
  }
}