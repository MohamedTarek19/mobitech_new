import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/electronic_form.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobile_form.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/main_container.dart';

class DefictType extends StatefulWidget {
  const DefictType({Key? key}) : super(key: key);

  @override
  State<DefictType> createState() => _DefictTypeState();
}

class _DefictTypeState extends State<DefictType> {
  String? value;

  @override
  Widget build(BuildContext context) {
    var txtList = <String>[
      "سوفت وير","هارد وير"
    ];
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
                        value: txtList[index], groupValue: value, onChanged: (val) {
                      setState(() {
                        print(val);
                        value = val.toString();
                        FormInfo.defict_type = val.toString();
                      });
                      Navigation.puchReplace(MobileForm(), context);

                      // Navigator.pop(context);
                    }),
                    title: Text(txtList[index],
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
