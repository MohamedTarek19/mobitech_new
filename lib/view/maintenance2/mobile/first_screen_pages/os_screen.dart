import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/view_model/phone_types_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/view/maintenance2/maintenance_helper.dart';
import 'package:provider/provider.dart';

class OperatingSystem extends StatelessWidget {
  OperatingSystem({Key? key}) : super(key: key);

  String? value;
  final os = ['Android','IOS','Windows'];

  @override
  Widget build(BuildContext context) {
    final types = Provider.of<PhoneTypesVm>(context,listen: false);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text(
            "إختر نظام التشغيل",
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
            itemCount: os.length,
            itemBuilder: (BuildContext context, int index) {
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return RadioListTile<String>(
                      value: os[index],
                      groupValue: value,
                      //toggleable: true,
                      title: Text(os[index],style: TextStyle(fontSize: 17,color: Colors.white),),
                      onChanged: (val){
                        setState((){
                          value = val;
                        });
                        FormHelper.tmp = types.Phone?.where((element) =>
                        val =='IOS'? (element.phone_type == 'apple' || element.phone_type == 'iphone'):
                        val == 'Windows'? (element.phone_type == 'microsoft'):
                        (element.phone_type != 'apple' && element.phone_type != 'iphone' && element.phone_type != 'microsoft')).toList();
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
