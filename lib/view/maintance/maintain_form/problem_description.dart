import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobitech/business_logic/model/catsets_m.dart';
import 'package:mobitech/business_logic/view_model/categories_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/location_picker.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/electronics_form_viewer.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/defict_type.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_viewer.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobileCategory.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/operating_system.dart';
import 'package:mobitech/view/maintance/maintain_form/personal_form.dart';
import 'package:mobitech/view/maintance/maintain_form/preferable_time.dart';
import 'package:mobitech/view/maintance/maintain_form/regions.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

class ProblemDescription extends StatefulWidget {
  const ProblemDescription({Key? key}) : super(key: key);

  @override
  State<ProblemDescription> createState() => _ProblemDescriptionState();
}

class _ProblemDescriptionState extends State<ProblemDescription> {
  String? value;
  TextEditingController description = TextEditingController();

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
                            child: const Text(
                              "إختر الوقت المفضل للتنفيذ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
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
                                  Navigation.puchReplace(PreferableTime(), context);
                                },
                                title: Text( FormInfo.prefered_time??
                                  'إختر الوقت المناسب',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "أوصف مشكلتك و حاجتك بوضوح",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  "أضف وصف واضح لمشكلتك، ليتمكن مزود الخدمة من فهمها و تقديم العرض الأفضل لك",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white70),
                                  textAlign: TextAlign.right,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: SizedBox(
                              height: 100,
                              child: TextField(
                                maxLines: null,
                                expands: true,
                                controller: description,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(right: 5),
                                    hintText: "أضف وصف للمشكلة",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                                //style: TextStyle(height: 50),
                              ),
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
                          print(description.text);
                          setState(() {
                            FormInfo.description = description.text;
                          });
                          Map<String,bool> descValid = FormInfo.descPageValidate()??{};
                          for(var v in descValid.entries){
                            if(v.value == false){
                              alert(v.key);
                              return;
                            }
                          }
                          Navigation.puchNav(PersonalDataForm(), context);
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "التالي",
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
