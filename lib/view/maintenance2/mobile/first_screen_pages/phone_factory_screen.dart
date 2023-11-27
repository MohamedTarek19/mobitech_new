import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/phone_types_m.dart';
import 'package:mobitech/business_logic/view_model/phone_models_vm.dart';
import 'package:mobitech/business_logic/view_model/phone_types_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/view/maintenance2/maintenance_helper.dart';
import 'package:provider/provider.dart';

class PhoneFactory extends StatelessWidget {
  PhoneFactory({Key? key}) : super(key: key);

  String? value;
  late List<PhoneTypesM>? factory;

  @override
  Widget build(BuildContext context) {
    final types = Provider.of<PhoneTypesVm>(context,listen: false);
    final pmodels = Provider.of<PhoneModelsVm>(context,listen: false);
    factory = FormHelper.tmp;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text(
            "إختر نوع الهاتف",
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
            itemCount: factory?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return RadioListTile<String>(
                      value: factory![index].phone_type!,
                      groupValue: value,
                      //toggleable: true,
                      title: Text(factory![index].phone_type!,style: TextStyle(fontSize: 17,color: Colors.white),),
                      onChanged: (val) async {
                        showDialog(context: context, builder: (context){return const Center(child: CircularProgressIndicator());});
                        setState((){
                          value = val;
                        });
                        await pmodels.findModelsByPhoneType(val ?? '');
                        Navigator.pop(context);
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
