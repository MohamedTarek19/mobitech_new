import 'package:flutter/material.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/jobs/job_search.dart';
import 'package:mobitech/view/jobs/jobs_req.dart';
  import 'package:mobitech/widgets/main_container.dart';
 
import '../../theme/appthrmr.dart';
import '../../widgets/cuttom_appbar.dart';

class JobsMain extends StatelessWidget {
  const JobsMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MainContainer(widget: Scaffold(
      appBar:  CustomAbbBar("طلب وظيفة", context),
      body:  SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        
        crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
      ServiceWidget2(imahePath: "assets/jobreq.png", name: "طلب وظيفة",action: (){
      Navigation.puchNav(const JobRequest(), context);
      
      
      },),
      ServiceWidget2(imahePath: "assets/jobsearch.png", name: "بحث عن وظيفة",action: (){
      
            Navigation.puchNav(const JobSearch(), context);

        
      },)
      
      
        ]),
      ),
    ));
    
  }
}
class ServiceWidget2 extends StatelessWidget {
  final String imahePath;
  final String name;
  final VoidCallback? action;
  const ServiceWidget2({
    Key? key,
    required this.imahePath,
    required this.name,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: action,
     child: Container(
       margin: AppTheme.marginall.copyWith(left: 30,right: 30),
       padding: AppTheme.paddingall.copyWith(top: 5,bottom: 5),
      
 
       decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(AppTheme.borderradiu3),
           border: Border.all(color: AppTheme.mainColor, width: 1.5)),
       child: Column(mainAxisAlignment: MainAxisAlignment.center,   children: [
         Image.asset(
           imahePath,
            fit: BoxFit.contain,
         ),
         const SizedBox(height: 9),
         Text(
           name,
           style: Theme.of(context).textTheme.headline3,
           overflow: TextOverflow.ellipsis,
         )
       ]),
     ),
      );
  }
}
