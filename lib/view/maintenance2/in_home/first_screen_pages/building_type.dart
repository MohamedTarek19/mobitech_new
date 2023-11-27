import 'package:flutter/material.dart';
import 'package:mobitech/theme/appthrmr.dart';

class BuildingType extends StatelessWidget {
  BuildingType({Key? key}) : super(key: key);

  String? value;
  final building = ["مبنى","فيلا","شقة","أخرى"];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text(
            "إختر نوع الوحدة السكنية",
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
            itemCount: building.length,
            itemBuilder: (BuildContext context, int index) {
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return RadioListTile<String>(
                      value: building[index],
                      groupValue: value,
                      //toggleable: true,
                      title: Text(building[index],style: TextStyle(fontSize: 17,color: Colors.white),),
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
