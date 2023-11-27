import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/inhome_services_m.dart';
import 'package:mobitech/business_logic/model/inhome_types_m.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintenance2/in_home/first_screen_pages/building_type.dart';
import 'package:mobitech/view/maintenance2/in_home/first_screen_pages/service_type.dart';
import 'package:mobitech/view/maintenance2/maintenance_helper.dart';
import 'package:mobitech/view/maintenance2/common_pages/area_screen.dart';
import 'package:mobitech/view/maintenance2/common_pages/second_screen.dart';
import 'package:mobitech/widgets/error_message_alert.dart';
import '../../../widgets/FormTile.dart';



class ServiceFirstScreen extends StatelessWidget {
  ServiceFirstScreen({Key? key,required this.services}) : super(key: key);
  List<InHomeServicesM> services;
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
                            FormTile(tileName: 'إختر نوع الخدمة',ontap: () async {

                              FormHelper.serviceType = await Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                                return ServiceType(service: services,);
                              }));
                              setState((){
                                if(FormHelper.serviceType!.isEmpty){
                                  FormHelper.serviceType = null;
                                }
                              });
                            },data: FormHelper.serviceType,),
                            FormTile(tileName: 'إختر نوع الوحدة السكنية',ontap: ()async {
                              FormHelper.buildingType = await Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
                                return BuildingType();
                              }));
                              setState((){

                              });
                            },data: FormHelper.buildingType,),

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
                          else if( FormHelper.serviceType ==null){
                            alert('نوع الخدمة',context);
                          }
                          else if( FormHelper.buildingType ==null){
                            alert('نوع لبوحدة السكنية',context);
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


