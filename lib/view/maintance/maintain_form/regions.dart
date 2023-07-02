import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/zonearea_m.dart';
import 'package:mobitech/business_logic/view_model/zonearea_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/electronic_form.dart';
import 'package:mobitech/view/maintance/maintain_form/in_home_form/in_home_form.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobile_form.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

class Regions extends StatefulWidget {
  const Regions({Key? key}) : super(key: key);

  @override
  State<Regions> createState() => _RegionsState();
}

class _RegionsState extends State<Regions> {
  String? value;

  @override
  Widget build(BuildContext context) {
    List<ZoneAreaM> txtList = [
    ];
    var zoa_vm = Provider.of<ZoneAreaVm>(context, listen: false);
    txtList = zoa_vm.zoneArea??[];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('إختر المدينة'),
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
                        value: txtList[index].areaname??'', groupValue: value, onChanged: (val) {
                      setState(() {
                        print(val);
                        value = val.toString();
                        FormInfo.region = val.toString();
                      });
                      if(MHelper.dropdownvalueMaint == 'أجهزة كهربائية'){
                        Navigation.puchReplace(ElectronicForm(), context);
                      }else if(MHelper.dropdownvalueMaint == "هاتف محمول"){
                        Navigation.puchReplace(MobileForm(), context);
                      }else{
                        Navigation.puchReplace(InHomeForm(), context);
                      }

                    }),
                    title: Text(txtList[index].areaname??'',
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
