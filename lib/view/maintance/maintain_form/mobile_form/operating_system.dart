import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/typesubs_m.dart';
import 'package:mobitech/business_logic/view_model/categories_vm.dart';
import 'package:mobitech/business_logic/view_model/typesubs_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/electronic_form.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobile_form.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

class OperatingSystems extends StatefulWidget {
  const OperatingSystems({Key? key}) : super(key: key);

  @override
  State<OperatingSystems> createState() => _OperatingSystemsState();
}

class _OperatingSystemsState extends State<OperatingSystems> {
  String? value;
  List<TypeSubsM> txtList = [];
  @override
  Widget build(BuildContext context) {
    var cat_vm = Provider.of<CategoriesVm>(context, listen: false);
    var typesets_vm = Provider.of<TypeSubsVm>(context, listen: false);
    setState(() {
      txtList = typesets_vm.typeSubs!;
    });
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('إختر نظام التشغيل'),
          actions: [
            IconButton(onPressed: (){if(MHelper.dropdownvalueMaint == 'أجهزة كهربائية'){
              Navigation.puchReplace(ElectronicForm(), context);
            }else if(MHelper.dropdownvalueMaint == "هاتف محمول"){
              Navigation.puchReplace(MobileForm(), context);
            }}, icon: Icon(Icons.arrow_forward_ios))
          ],
        ),
        body: MainContainer(
          widget: ListView.builder(
              itemCount: txtList.length,
              itemBuilder: (context, index) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.end, children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 20),
                    leading: Radio(
                        value: txtList[index].typesub1??'', groupValue: value, onChanged: (val) {
                      setState(() {
                        print(val);
                        value = val.toString();
                        FormInfo.os = val.toString();
                        showDialog(context: context, builder: (context){return const Center(child: CircularProgressIndicator());});
                        cat_vm.getPhoneCategoriesByTypeSub(val.toString());
                        Navigator.of(context).pop();
                      });
                      Navigation.puchReplace(MobileForm(), context);
                      // Navigator.pop(context);
                    }),
                    title: Text(txtList[index].typesub1??'',
                        style: TextStyle(
                          fontSize: 25,
                        )),
                  ),
                ]);
              }),
        ),
      ),
    );
  }
}
