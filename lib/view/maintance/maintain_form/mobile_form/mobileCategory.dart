import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/catsets_m.dart';
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

class MobileCategory extends StatefulWidget {
  const MobileCategory({Key? key}) : super(key: key);

  @override
  State<MobileCategory> createState() => _MobileCategoryState();
}

List<CatsetsM>? txtList = [];

class _MobileCategoryState extends State<MobileCategory> {
  String? value;

  @override
  Widget build(BuildContext context) {
    var cat_vm = Provider.of<CategoriesVm>(context, listen: false);
      setState(() {
        txtList = cat_vm.MainCategories;
      });
    var model_vm = Provider.of<ModelSetsVm>(context, listen: false);
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
              itemCount: txtList?.length?? 0,
              itemBuilder: (context, index) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 20),
                        leading: Radio(
                            value: txtList?[index].catname ?? '',
                            groupValue: value,
                            onChanged: (val)async {
                              setState(() {
                                print(val);
                                value = val.toString();
                                FormInfo.factory = val.toString();
                                print(FormInfo.factory);
                                FormInfo.model = null;
                              });
                              showDialog(context: context, builder: (context){return const Center(child: CircularProgressIndicator());});
                              await model_vm.getModelSetsByCatName(value??'');
                              Navigator.of(context).pop();
                              Navigation.puchReplace(MobileForm(), context);
                              // Navigator.pop(context);
                            }),
                        title: Text(txtList?[index].catname ?? '',
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
