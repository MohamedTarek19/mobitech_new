import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/typesubs_m.dart';
import 'package:mobitech/business_logic/view_model/categories_vm.dart';
import 'package:mobitech/business_logic/view_model/maints_vm.dart';
import 'package:mobitech/business_logic/view_model/typesubs_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/mainance_details.dart';
import 'package:mobitech/view/maintance/maintain_form/alert.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/electronic_form.dart';
import 'package:mobitech/view/maintance/maintain_form/in_home_form/in_home_data.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobile_data.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:mobitech/view/maintance/mhelper.dart';

class ElectronicDeviceSelection extends StatefulWidget {
  const ElectronicDeviceSelection({Key? key}) : super(key: key);

  @override
  State<ElectronicDeviceSelection> createState() => _ElectronicDeviceSelectionState();
}

class _ElectronicDeviceSelectionState extends State<ElectronicDeviceSelection> {

  List<TypeSubsM> items = [];
  String Val = 'غسالة';
  @override
  Widget build(BuildContext context) {
    FormInfo.reset();
    var typeSubs_vm = Provider.of<TypeSubsVm>(context, listen: false);
    var Cat_vm = Provider.of<CategoriesVm>(context, listen: false);
    items = typeSubs_vm.typeSubs??[];
    final formK = GlobalKey<FormState>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MainContainer(
          widget: Scaffold(
            appBar: CustomAbbBar("الأجهزة المنزلية", context),
            body: Form(
              key: formK,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: AppTheme.marginall,
                    padding: AppTheme.paddingall,
                    child: Center(
                        child: Text(
                          "إختر خدمة الصيانة",
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
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      padding: EdgeInsets.only(right: 6),
                      width: 310.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(
                        underline: SizedBox(),
                        isExpanded: true,
                        value: MHelper.dropdownvalueEH,
                        icon: const Icon(Icons.arrow_drop_down),
                        items: items.map((items) {
                          return DropdownMenuItem(
                            value: items.typesub1??'',
                            child: SizedBox(
                              width: 100.0, // for example
                              child: Text(items.typesub1??'', textAlign: TextAlign.center),
                            ),
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) {
                          return items.map((value) {
                            return Align(
                              alignment: Alignment.centerRight,
                              child: Text(MHelper.dropdownvalueEH),
                            );
                          }).toList();
                        },
                        onChanged: (String? newValue) {
                          setState(()async {
                            print(newValue);
                            //await Cat_vm.getPhoneCategoriesByTypeSub(newValue.toString());
                            Val = newValue.toString();
                            MHelper.dropdownvalueEH = newValue.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: double.infinity,
                      //height: double.infinity,lef
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.bottomLeft,
                      child: CustomBtn(
                          name: "التالي",
                          action: () async {
                            showDialog(context: context, builder: (context){return const Center(child: CircularProgressIndicator());});
                            MHelper.typesub = Val.toString();
                            await Cat_vm.getPhoneCategoriesByTypeSub(Val.toString());
                            Navigator.of(context).pop();
                            //Navigation.puchNav(PersonalData(), context);
                            Navigation.puchNav(ElectronicForm(), context);
                          }),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
