import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobile_form.dart';
import 'package:mobitech/view/maintance/maintain_form/problem_description.dart';
import 'package:mobitech/widgets/main_container.dart';

class PreferableTime extends StatefulWidget {
  const PreferableTime({Key? key}) : super(key: key);

  @override
  State<PreferableTime> createState() => _PreferableTimeState();
}

class _PreferableTimeState extends State<PreferableTime> {
  String? value;

  @override
  Widget build(BuildContext context) {
    var txtList = <String>[
      "اليوم","غدا","خلال اسبوع","الأسبوع القادم"
    ];
    var visitTime =<String,DateTime>{
    };
    visitTime["اليوم"] = DateTime.now();
    visitTime["غدا"] =DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 1);
    visitTime["خلال اسبوع"] =DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day +4);
    visitTime["الأسبوع القادم"] = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 7);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('إختر المدينة'),
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
                        FormInfo.prefered_time = val.toString();
                        FormInfo.visitdate = visitTime[val.toString()];
                        print(FormInfo.visitdate);
                      });
                      Navigation.puchReplace(ProblemDescription(), context);
                      // Navigator.pop(context);
                    }),
                    title: Text(txtList[index],
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
