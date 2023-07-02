import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/electronic_form.dart';
import 'package:mobitech/view/maintance/maintain_form/in_home_form/in_home_form.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobile_form.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/main_container.dart';

class BuildingInfo extends StatefulWidget {
  const BuildingInfo({Key? key}) : super(key: key);

  @override
  State<BuildingInfo> createState() => _BuildingInfoState();
}

class _BuildingInfoState extends State<BuildingInfo> {
  String? value;

  @override
  Widget build(BuildContext context) {
    var txtList = <String>[
      "مبنى","فيلا","شقة","أخرى"
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('إختر نوع الوحدة السكنية'),
          actions: [
            IconButton(onPressed: (){
              Navigation.puchReplace(InHomeForm(), context);
              }
                , icon: Icon(Icons.arrow_forward_ios))
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
                        FormInfo.buildingInfo = val.toString();
                      });
                      Navigation.puchReplace(InHomeForm(), context);

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
