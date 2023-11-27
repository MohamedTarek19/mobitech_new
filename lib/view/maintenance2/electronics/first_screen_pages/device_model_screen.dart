import 'package:flutter/material.dart';
import 'package:mobitech/theme/appthrmr.dart';

class DeviceModel extends StatelessWidget {
  DeviceModel({Key? key}) : super(key: key);

  String? value;
  final models = ['XXXXXX1','XXXXXXX2','XXXXXXX3','XXXXXXX4','XXXXXXX5','XXXXXXX6','XXXXXXX7','XXXXXXX8'];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text(
            "إختر موديل الجهاز",
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
            itemCount: models.length,
            itemBuilder: (BuildContext context, int index) {
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return RadioListTile<String>(
                      value: models[index],
                      groupValue: value,
                      //toggleable: true,
                      title: Text(models[index],style: TextStyle(fontSize: 17,color: Colors.white),),
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
