import 'package:flutter/material.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintenance2/maintenance_helper.dart';
import 'package:mobitech/view/maintenance2/common_pages/area_screen.dart';
import 'package:mobitech/view/maintenance2/common_pages/second_screen.dart';
import 'package:mobitech/widgets/error_message_alert.dart';
import '../../../widgets/FormTile.dart';
import 'first_screen_pages/device_factory_screen.dart';
import 'first_screen_pages/device_model_screen.dart';

class DeviceFirstScreen extends StatelessWidget {
  DeviceFirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(elevation: 5, title: Text("إملأ الطلب", style: Theme.of(context).textTheme.headline2,),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: AppTheme.mainGradient,
          ),
          child:Column(
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  //color: Colors.blue,
                  child: SingleChildScrollView(
                    child: StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setState) {
                        return Column(
                          children: [
                            FormTile(tileName: 'إختر المنطقة',ontap: () async {
                              FormHelper.area = await Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                                return Area();
                              }));
                              setState((){

                              });
                            },data: FormHelper.area,),
                            FormTile(tileName: 'إختر شركة الجهاز',ontap: () async {
                              FormHelper.factory = await Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                                return DeviceFactory();
                              }));
                              setState((){

                              });
                            },data: FormHelper.factory,),
                            FormTile(tileName: 'إختر الموديل',ontap: ()async {
                              FormHelper.model = await Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                                return DeviceModel();
                              }));
                              setState((){

                              });
                            },data: FormHelper.model,),

                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(child: Container(

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.07),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if(FormHelper.area ==null){
                            alert('المنطقة',context);
                          }
                          else if( FormHelper.factory ==null){
                            alert('شركةالجهاز',context);
                          }
                          else if( FormHelper.model ==null){
                            alert('موديل الجهاز',context);
                          }else{
                            Navigation.puchNav(SecondScreen(), context);
                          }

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("التالي",style: TextStyle(color: Color(0xff50B04F),fontSize: 20),),
                            const Icon(Icons.arrow_circle_left_outlined,color: Color(0xff50B04F),size: 30,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}


