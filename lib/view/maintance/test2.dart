import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/view_model/maints_vm.dart';
import 'package:mobitech/business_logic/view_model/typesets_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/mainance_details.dart';

import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import '../../business_logic/usecase/validation.dart';
import '../../widgets/custom_form-fild.dart';
import 'package:mobitech/view/maintance/mhelper.dart';

class MaintanceTest2 extends StatefulWidget {
  const MaintanceTest2({Key? key}) : super(key: key);

  @override
  State<MaintanceTest2> createState() => _MaintanceTest2State();
}

class _MaintanceTest2State extends State<MaintanceTest2> {

  var items = [
    'هاتف محمول',
    'أجهزة كهربائية',
    'أعمال منزلية'
  ];

  @override
  Widget build(BuildContext context) {
    var typesets_vm = Provider.of<TypeSetsVm>(context, listen: false);

    final formK = GlobalKey<FormState>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MainContainer(
          widget: Scaffold(
        appBar: CustomAppBar("طلب صيانة اجهزة", context),
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
                    value: MHelper.dropdownvalueMaint,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: SizedBox(
                          width: 100.0, // for example
                          child: Text(items, textAlign: TextAlign.center),
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (BuildContext context) {
                      return items.map((String value) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Text(MHelper.dropdownvalueMaint),
                        );
                      }).toList();
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        MHelper.dropdownvalueMaint = newValue!;
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
                          //Navigation.puchNav(PersonalData(), context);
                        await typesets_vm.getTypeSets();
                        Navigator.of(context).pop();

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
