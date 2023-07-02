import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/catsets_m.dart';
import 'package:mobitech/business_logic/model/modelsets_m.dart';
import 'package:mobitech/business_logic/view_model/categories_vm.dart';
import 'package:mobitech/business_logic/view_model/modelsets_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/electronic_form.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobile_form.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

class MobileModels extends StatefulWidget {
  const MobileModels({Key? key}) : super(key: key);

  @override
  State<MobileModels> createState() => _MobileModelsState();
}

List<ModelSetsM> txtList = [];

class _MobileModelsState extends State<MobileModels> {
  String? value;

  @override
  Widget build(BuildContext context) {
    var model_vm = Provider.of<ModelSetsVm>(context, listen: false);
    setState(() {
      txtList = model_vm.modelSets??[];
      if(txtList.isEmpty == true){
        FormInfo.model ='';
      }
    });
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('إختر شركة هاتفك'),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 20),
                        leading: Radio(
                            value: txtList[index].model ?? '',
                            groupValue: value,
                            onChanged: (val) {
                              setState(() {
                                print(val);
                                value = val.toString();
                                FormInfo.model = val.toString();
                                print(FormInfo.model);
                                //model_vm.getModelSetsByCatName(val.toString());
                              });
                              Navigation.puchReplace(MobileForm(), context);

                              // Navigator.pop(context);
                            }),
                        title: Text(txtList[index].model ?? '',
                            style: const TextStyle(
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
