import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobitech/business_logic/model/catsets_m.dart';
import 'package:mobitech/business_logic/view_model/categories_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/emp_landing_page.dart';
import 'package:mobitech/view/landing_page.dart';
import 'package:mobitech/view/maintance/location_picker.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/electronics_form_viewer.dart';
import 'package:mobitech/view/maintance/maintain_form/in_home_form/in_home_form_viewer.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/defict_type.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_viewer.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobileCategory.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/operating_system.dart';
import 'package:mobitech/view/maintance/maintain_form/preferable_time.dart';
import 'package:mobitech/view/maintance/maintain_form/regions.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

class PersonalDataForm extends StatefulWidget {
  const PersonalDataForm({Key? key}) : super(key: key);

  @override
  State<PersonalDataForm> createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<PersonalDataForm> {
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

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController Name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('املأ الطلب'),
        ),
        body: MainContainer(
          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
          widget: SingleChildScrollView(
            child: SizedBox(
              height: Height*0.88,//MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "من فضلك سجل عن طريق إدخال رقم هاتفك داخل دولة مصر بدون إدخال رمز الدولة و ادخل الأرقام باللغة الإنجليزية",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white70),
                                  textAlign: TextAlign.right,
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: phoneNumber,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 5),
                                  hintText: "إدخل رقم هاتفك",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              //style: TextStyle(height: 50),
                            ),
                          ),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "إدخل إسمك بالكامل باللغة العربية",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white70),
                                  textAlign: TextAlign.right,
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: Name,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 5),
                                  hintText: "إدخل إسمك",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              //style: TextStyle(height: 50),
                            ),
                          ),
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
                        onTap: () {
                          FormInfo.phone_number = phoneNumber.text;
                          print(phoneNumber.text);
                          FormInfo.Name = Name.text;
                          Map<String,bool> personalValidate = FormInfo.personalPageValidate()??{};
                          for(var v in personalValidate.entries){
                            if(v.value == false){
                              alert(v.key);
                              return;
                            }
                          }
                          if(MHelper.dropdownvalueMaint == 'هاتف محمول'){
                            Navigation.puchNav(FormViewer(), context);
                          }else if(MHelper.dropdownvalueMaint == 'أجهزة كهربائية'){
                            Navigation.puchNav(ElecFormViewer(), context);
                          }else{
                            Navigation.puchNav(InHomeFormViewer(), context);
                          }
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "تسجيل",
                              style:
                              TextStyle(color: Colors.black, fontSize: 13),
                            ),
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
        ),
      ),
    );
  }
}
