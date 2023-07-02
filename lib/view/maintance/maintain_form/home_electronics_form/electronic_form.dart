import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/catsets_m.dart';
import 'package:mobitech/business_logic/view_model/categories_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/location_picker.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/device_factory.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/device_model.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/defict_type.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobileCategory.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/operating_system.dart';
import 'package:mobitech/view/maintance/maintain_form/regions.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

class ElectronicForm extends StatefulWidget {
  const ElectronicForm({Key? key}) : super(key: key);

  @override
  State<ElectronicForm> createState() => _ElectronicFormState();
}

class _ElectronicFormState extends State<ElectronicForm> {
  String? value;
  alert(String field){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        icon: Icon(Icons.dangerous,size: 55,),
        iconColor: Colors.red,
        title: Text('الرجاء إدخال ${field}',style: TextStyle(color: Colors.black,fontSize: 17),textDirection: TextDirection.rtl,),
        actions: [
          ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text('حسنا'))
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('املأ الطلب'),
        ),
        body: MainContainer(
          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "إختر المنطقة",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                            onTap: () {
                              Navigation.puchReplace(Regions(), context);
                            },
                            title: Text(FormInfo.region??
                              'إختر منطقة',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                      )
                    ],
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "إختر الشركة المصنعة",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                            onTap: () {
                              Navigation.puchReplace(DeviceFactory(), context);
                            },
                            title: Text(FormInfo.factory??
                              'إختر الشركة المصنعة',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                      )
                    ],
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "إختر الموديل",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                            onTap: () {
                              Navigation.puchReplace(DeviceModel(), context);
                            },
                            title: Text(FormInfo.model??
                              'إختر الموديل',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                      )
                    ],
                  )),
              Expanded(
                child: Container(),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListTile(
                    onTap: (){
                      Map<String,bool> validation = FormInfo.firstPageValidate(2)??{};
                      for(var v in validation.entries){
                        print(v.value);
                        if(v.value == false){
                          alert(v.key);
                          return;
                        }
                      }
                      Navigation.puchNav(googleMaps(), context);
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("التالي", style: TextStyle(color: Colors.black, fontSize: 13),),
                        Icon(Icons.arrow_circle_left_sharp),
                      ],
                    ),
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
