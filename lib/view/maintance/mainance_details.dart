import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobitech/business_logic/view_model/maintenance_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

import '../../business_logic/view_model/maints_vm.dart';

class MaintSearchResult extends StatelessWidget {
  const MaintSearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maints_Vm = Provider.of<MaintenanceVM>(context);
    var x=MediaQuery.of(context).orientation;

    return MainContainer(
      widget: Scaffold(
        appBar: CustomAppBar("نتائج البحث", context),
        body: SingleChildScrollView(
          child: Column(
             children: [
          x==Orientation.portrait?     const SizedBox(
                height: 50,
              ):Container(),
                 Container(
                margin: AppTheme.marginall,
                padding: AppTheme.paddingall,
                decoration: const BoxDecoration(
                    color: AppTheme.mainColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppTheme.borderradiu2))),
                child: Center(
                    child: Text(
                  "إستعلام عن جهاز صيانة",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.green),
                )),
              ), const SizedBox(
                height: 50,
              ),
              Card(
                margin: AppTheme.marginall,
                shape: Border.all(color: AppTheme.mainColor,width: 2),
                elevation: 0,
                color: Colors.transparent,
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                          maints_Vm.maints?.customer_name ?? "غير متوفر",
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      ": اسم العميل",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
                Container(height: 2,color: AppTheme.mainColor,margin: AppTheme.marginall,width: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                          maints_Vm.maints?.stat ?? "غير متوفر",
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      ": الحالة",
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),
                Container(height: 2,color: AppTheme.mainColor,margin: AppTheme.marginall,width: 200),
                Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                          maints_Vm.maints?.customer_tele ?? "غير متوفر",
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      ": رقم التليفون ",
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),
                Container(height: 2,color: AppTheme.mainColor,margin: AppTheme.marginall,width: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                          maints_Vm.maints?.phone_error ?? "غير متوفر",
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      ": عطل الهاتف ",
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),
                Container(height: 2,color: AppTheme.mainColor,margin: AppTheme.marginall,width: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                          maints_Vm.maints?.customer_paid ?? "غير متوفر",
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      ": التكلفة ",
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),
                Container(height: 2,color: AppTheme.mainColor,margin: AppTheme.marginall,width: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                          maints_Vm.maints?.phone_model ?? "غير متوفر",
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      ": نوع الهاتف ",
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),
                Container(height: 2,color: AppTheme.mainColor,margin: AppTheme.marginall,width: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                            maints_Vm.maints?.serial_number ==null ||  (maints_Vm.maints?.serial_number?.isEmpty??true)? "غير متوفر":
                            maints_Vm.maints?.serial_number??'غير متوفر',
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      ": السيريال ",
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),
                Container(height: 2,color: AppTheme.mainColor,margin: AppTheme.marginall,width: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                          maints_Vm.maints?.engreply ?? "غير متوفر",
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      ": رد المهندس ",
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),
                Container(height: 2,color: AppTheme.mainColor,margin: AppTheme.marginall,width: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SingleChildScrollView(
                      scrollDirection:Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                          maints_Vm.maints?.report ?? "غير متوفر",
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      ": التقرير ",
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),

              ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
