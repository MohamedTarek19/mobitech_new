import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/inhome_services_m.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/view/maintenance2/maintenance_helper.dart';

class ServiceType extends StatelessWidget {
  ServiceType({Key? key,required this.service}) : super(key: key);

  String? value;
  final List<InHomeServicesM> service;



  @override
  Widget build(BuildContext context) {
    if (FormHelper.selected.isEmpty == true) {
      FormHelper.selected = List<bool>.filled(service.length, false);
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text(
            "إختر نوع الخدمة",
            style: Theme.of(context).textTheme.headline2,
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.mainGradient,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex:9,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height:MediaQuery.of(context).size.height*0.788,
                      child: ListView.builder(
                        itemCount: service.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return CheckboxListTile(
                                  controlAffinity: ListTileControlAffinity.leading,
                                  selected: true,
                                  value: FormHelper.selected[index],
                                  title: Text(
                                    service[index].phone_model??'',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      FormHelper.selected[index] = val ?? false;
                                      if (val == true) {
                                        FormHelper.serviceSelection.add(service[index].phone_model??'');
                                      } else {
                                        FormHelper.serviceSelection.remove(service[index].phone_model??'');
                                      }
                                      print(FormHelper.serviceSelection);
                                    });
                                  });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                      onPressed: (){
                        String serviceType = '';
                        FormHelper.serviceSelection.forEach((element) {
                          serviceType += element +', ';
                        });
                        print(FormHelper.serviceSelection.length);
                        print(serviceType);
                        Navigator.pop(context,serviceType);
                      },
                      child: const Text('تأكيد',style: TextStyle(color: Color(0xff50B04F)),))
                  ],
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
