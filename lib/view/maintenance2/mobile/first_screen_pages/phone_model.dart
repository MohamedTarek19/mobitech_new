import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/phone_models_m.dart';
import 'package:mobitech/business_logic/view_model/phone_models_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:provider/provider.dart';

class PhoneModel extends StatelessWidget {
  PhoneModel({Key? key}) : super(key: key);

  String? value;
  late List<PhoneModelsM>? models;

  @override
  Widget build(BuildContext context) {
    final phoneModelsVm = Provider.of<PhoneModelsVm>(context);

    models =phoneModelsVm.models;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text(
            "إختر موديل الهاتف",
            style: Theme.of(context).textTheme.headline2,
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: AppTheme.mainGradient,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.9,
          child: ListView.builder(
            itemCount: models?.length??0,
            itemBuilder: (BuildContext context, int index) {
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return RadioListTile<String>(
                      value: models![index].phone_model!,
                      groupValue: value,
                      //toggleable: true,
                      title: Text(models![index].phone_model!,style: TextStyle(fontSize: 17,color: Colors.white),),
                      onChanged: (val){
                        setState((){
                          value = val;
                        });
                        Navigator.pop(context,val);
                      });
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
