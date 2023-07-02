import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/catsets_m.dart';
import 'package:mobitech/business_logic/model/work_orders_m.dart';
import 'package:mobitech/business_logic/view_model/categories_vm.dart';
import 'package:mobitech/business_logic/view_model/work_orders_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/emp_landing_page.dart';
import 'package:mobitech/view/landing_page.dart';
import 'package:mobitech/view/maintance/location_picker.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/defict_type.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobileCategory.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/operating_system.dart';
import 'package:mobitech/view/maintance/maintain_form/personal_form.dart';
import 'package:mobitech/view/maintance/maintain_form/regions.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/view/notify/status_updater.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

class ElecFormViewer extends StatefulWidget {
  const ElecFormViewer({Key? key}) : super(key: key);

  @override
  State<ElecFormViewer> createState() => _ElecFormViewerState();
}

class _ElecFormViewerState extends State<ElecFormViewer> {
  String? value;
  alert()async{
    final _workOrdersVm = Provider.of<WorkOrdersVM>(context, listen: false);
    var idGetter=await _workOrdersVm.getWorkOrders();
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        icon: Icon(Icons.check,size: 50,color: Colors.green,),
        title: Container(child: Column(
          children: [
            Text('هل تريد إرسال طلبك؟',style: TextStyle(color: Colors.black,fontSize: 17),textDirection: TextDirection.rtl,),
            Text('رقم طلبك هو : ${(idGetter?.last.id??1) + 1}',style: TextStyle(color: Colors.black,fontSize: 17),textDirection: TextDirection.rtl,),
          ],
        )),
        actions: [
          ElevatedButton(onPressed: ()async{
            showDialog(context: context, builder: (context){
              return const Center(child: CircularProgressIndicator());
            });
            var _prefs =await sharedPreferences;
            var statusCode = await _workOrdersVm.addWorkOrder(WorkOrdersM(
              typework: MHelper.typeset,
              typesub: MHelper.typesub,
              castset: FormInfo.factory,
              modelset: FormInfo.model,
              area: FormInfo.region,
              errortype: '',
              address: '',
              buildtype:'',
              servicetype:'',
              st:'قيد الإنتظار',
              wnote:'',
              custid: await _prefs.getString('Userid')??"0",
              mimage: FormInfo.photo_url.toString(),
              custname: FormInfo.Name,
              custmobile: FormInfo.phone_number,
              workdesc: FormInfo.description,
              visittime: FormInfo.visitdate.toString(),
              lline: FormInfo.location!.longitude.toString(),
              lwidth: FormInfo.location!.latitude.toString(),
            ));
            await StatusUtils.SaveNewStatus(_prefs, _workOrdersVm);

            Navigator.of(context).pop();
            if(MHelper.isInEmp == true){
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>LandingPage_emp()), (route) => route.isFirst,);
            }else{
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>LandingPage()), (route) => route.isFirst,);
            }
          }, child: Text('حسنا')),
          ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text('إلغاء'))
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
          title: Text('تأكيد الطلب'),
        ),
        body: SizedBox(
          height: Height,
          child: MainContainer(
            padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
            widget:SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("الإسم", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.right,),
                                  Text(FormInfo.Name??'', style: TextStyle(fontSize: 13,color: Colors.white70),textAlign: TextAlign.right,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("رقم الهاتف", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.right,),
                                  Text(FormInfo.phone_number??'', style: TextStyle(fontSize: 13,color: Colors.white70),textAlign: TextAlign.right,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                      //  width: double.infinity,
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      width: 100,
                      color: AppTheme.mainColor,
                      height: 3,
                      padding: AppTheme.marginall,
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("المنطقة", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.right,),
                                  Text(FormInfo.region??'', style: TextStyle(fontSize: 13,color: Colors.white70),textAlign: TextAlign.right,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("الشركة المصنعة", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.right,),
                                  Text(FormInfo.factory??'', style: TextStyle(fontSize: 13,color: Colors.white70),textAlign: TextAlign.right,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("الموديل", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.right,),
                                  Text(FormInfo.model??'', style: TextStyle(fontSize: 13,color: Colors.white70),textAlign: TextAlign.right,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                      //  width: double.infinity,
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      width: 100,
                      color: AppTheme.mainColor,
                      height: 3,
                      padding: AppTheme.marginall,
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("المكان", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.right,),
                                  Text('(${FormInfo.location?.latitude??''},${FormInfo.location?.longitude??''})', style: TextStyle(fontSize: 13,color: Colors.white70),textAlign: TextAlign.right,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                      //  width: double.infinity,
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      width: 100,
                      color: AppTheme.mainColor,
                      height: 3,
                      padding: AppTheme.marginall,
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("وصف الطلب", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.right,),
                                  Text(FormInfo.description??'', style: TextStyle(fontSize: 13,color: Colors.white70),textAlign: TextAlign.right,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("الوقت المناسب", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.right,),
                                  Text(FormInfo.prefered_time??'', style: TextStyle(fontSize: 13,color: Colors.white70),textAlign: TextAlign.right,)
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: FormInfo.isNull() != false
                          ? Image.file(
                        FormInfo.photo_url,
                        width: 60,
                        height: 50,
                        fit: BoxFit.fitHeight,
                      )
                          : Container(),
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                          onTap: (){
                            alert();

                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("تأكيد و إرسال", style: TextStyle(color: Colors.black, fontSize: 13),),
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
