import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobitech/business_logic/view_model/losts_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

import '../../business_logic/view_model/maints_vm.dart';

class LostSearchResult extends StatelessWidget {
  const LostSearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lost_Vm = Provider.of<LostVM>(context);
    var x = MediaQuery.of(context).orientation;

    return MainContainer(
      widget: Scaffold(
        appBar: CustomAppBar("نتا~ج البحث", context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              x == Orientation.portrait
                  ? const SizedBox(
                      height: 50,
                    )
                  : Container(),
              Container(
                margin: AppTheme.marginall,
                padding: AppTheme.paddingall,
                decoration: const BoxDecoration(
                    color: AppTheme.mainColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppTheme.borderradiu2))),
                child: Center(
                    child: Text(
                  "إستعلام عن جهاز مسروق",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.green),
                )),
              ),
              const SizedBox(
                height: 50,
              ),
              Card(

                margin: AppTheme.marginall,
                shape: Border.all(color: AppTheme.mainColor, width: 2),
                elevation: 0,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              lost_Vm.lostsM?.aname ?? "",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              ": الاسم ",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),

                        Container(
                            height: 2,
                            color: AppTheme.mainColor,
                            margin: AppTheme.marginall,
                            width: 200),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              lost_Vm.lostsM?.gtel ?? "",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              ": رقم الموبايل",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),

                        Container(
                            height: 2,
                            color: AppTheme.mainColor,
                            margin: AppTheme.marginall,
                            width: 200),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              lost_Vm.lostsM?.gname ?? "",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              ": نوع الجهاز",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),

                        Container(
                            height: 2,
                            color: AppTheme.mainColor,
                            margin: AppTheme.marginall,
                            width: 200),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              lost_Vm.lostsM?.gmodel ?? "",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              ": موديل الجهاز",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),

                        Container(
                            height: 2,
                            color: AppTheme.mainColor,
                            margin: AppTheme.marginall,
                            width: 200),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              lost_Vm.lostsM?.gserial ?? "",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              ": رقم السيريال",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),

                        Container(
                            height: 2,
                            color: AppTheme.mainColor,
                            margin: AppTheme.marginall,
                            width: 200),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(

                              lost_Vm.lostsM?.gdate ?? "",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              ": تاريخ البلاغ",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),

                        Container(
                            height: 2,
                            color: AppTheme.mainColor,
                            margin: AppTheme.marginall,
                            width: 200),
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

class InfoWidget extends StatelessWidget {
  final String fname;
  final String? fvalue;
  const InfoWidget({
    Key? key,
    required this.fname,
    this.fvalue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.marginall,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$fname: ",
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            fvalue ?? "",
            style: Theme.of(context).textTheme.headline3,
          )
        ],
      ),
    );
  }
}
