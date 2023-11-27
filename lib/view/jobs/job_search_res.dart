import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobitech/business_logic/model/jobsub_m.dart';
import 'package:mobitech/business_logic/view_model/job_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

import '../../business_logic/view_model/maints_vm.dart';

class JobSearchResult extends StatelessWidget {
  const JobSearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var jobsVm_Vm = Provider.of<JobVM>(context);
    var x=MediaQuery.of(context).orientation;

    return MainContainer(
      widget: Scaffold(
        appBar: CustomAppBar("نتا~ج البحث", context),
        body: FutureBuilder<List<JobSubject>?>(future: jobsVm_Vm.getJobsByName(jobsVm_Vm.searchValue??""),builder: (context, snapshot) {
         
         if(snapshot.hasError){

          return Center(child: Text("حدث خطأ!",style: Theme.of(context).textTheme.headline2,),);
         }
         if(snapshot.connectionState==ConnectionState.waiting){


          return  const Center(child: CircularProgressIndicator(color: AppTheme.mainColor),);
         }
          return ListView.builder(itemCount: snapshot.data!.length,itemBuilder: (context, index) {

            return  Card(
              child: ListTile(
                title: Text(snapshot.data![index].jname??""),
                subtitle:Text(snapshot.data![index].aname??"") ,
              ),
            );
          });
        },)
      ),
    );
  }
}
