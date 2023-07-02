import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/typesets_m.dart';
import 'package:mobitech/business_logic/view_model/maints_vm.dart';
import 'package:mobitech/business_logic/view_model/typesets_vm.dart';
import 'package:mobitech/business_logic/view_model/typesubs_vm.dart';
import 'package:mobitech/business_logic/view_model/zonearea_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/mainance_details.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/electronic_device_selection.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/electronic_form.dart';
import 'package:mobitech/view/maintance/maintain_form/in_home_form/in_home_data.dart';
import 'package:mobitech/view/maintance/maintain_form/in_home_form/in_home_form.dart';
import 'package:mobitech/view/maintance/maintain_form/in_home_form/in_home_service_selection.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobile_data.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobile_form.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:mobitech/view/maintance/mhelper.dart';

class Alertclass extends StatefulWidget {
  const Alertclass({Key? key}) : super(key: key);

  @override
  State<Alertclass> createState() => _AlertclassState();
}

class _AlertclassState extends State<Alertclass> {

  var items = [
    'هاتف محمول',
    'أجهزة كهربائية',
    'أعمال منزلية'
  ];
  List<TypeSetsM> typeSets = [];
  @override
  Widget build(BuildContext context) {
    var typesets_vm = Provider.of<TypeSetsVm>(context, listen: false);
      setState(() {
        print(typesets_vm.TypeSets);
        typeSets = typesets_vm.TypeSets??[];
      });

    FormInfo.reset();

    var zoa_vm = Provider.of<ZoneAreaVm>(context, listen: false);
    var typesubs_vm = Provider.of<TypeSubsVm>(context, listen: false);
    final formK = GlobalKey<FormState>();
    return MainContainer(
        widget: Scaffold(
          appBar: CustomAbbBar("إنشاء طلب جديد", context),
          body: Form(
            key: formK,
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                margin: AppTheme.marginall,
                padding: AppTheme.paddingall,
                  child: Center(
                      child: Text(
                        "سنسألك بعض الأسئلة لجمع التفاصيل حول طلبك و إرسالها للشركة و الفنيين",
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.white),
                      )),
                ),
                Align(
                  alignment: Alignment.center,

                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 2,
                    color: Colors.white,
                  ),
                ),

                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(top: 100),
                    child: CustomBtn(
                        name: "التالي",
                        action: () async {
                          showDialog(context: context, builder: (context){return const Center(child: CircularProgressIndicator());});
                          await zoa_vm.getZoneArea();
                          //Navigation.puchNav(PersonalData(), context);
                          if(MHelper.dropdownvalueMaint == items[0]){
                            MHelper.typeset = typeSets[0].typework!;
                            typesubs_vm.getTypeSubByTypeSet(MHelper.typeset);
                            Navigator.of(context).pop();
                            Navigation.puchReplace(MobileForm(), context);
                          }else if(MHelper.dropdownvalueMaint == items[1]){
                            MHelper.typeset = typeSets[1].typework??'';
                            await typesubs_vm.getTypeSubByTypeSet(MHelper.typeset);
                            setState(() {
                              Navigator.of(context).pop();
                              Navigation.puchReplace(ElectronicDeviceSelection(), context);
                            });
                          }else{
                            MHelper.typeset = typeSets[2].typework??'';
                            // var typeSubs_vm = Provider.of<TypeSubsVm>(context, listen: false);
                            await typesubs_vm.getTypeSubByTypeSet(MHelper.typeset);
                            setState(() {
                              Navigator.of(context).pop();
                              Navigation.puchReplace(InHomeServiceSelection(), context);
                            });
                          }

                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
