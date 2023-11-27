import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/maintenance_request_m.dart';
import 'package:mobitech/business_logic/view_model/maintenance_request_vm.dart';

import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/landing_page.dart';
import 'package:mobitech/view/maintenance2/maintenance_helper.dart';
import 'package:mobitech/widgets/new_divider.dart';
import 'package:mobitech/widgets/review_item.dart';
import 'package:provider/provider.dart';

import '../../../widgets/confirm_alert_message.dart';

class MobileFormReview extends StatelessWidget {
  const MobileFormReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(elevation: 5, title: Text("راجع طلبك", style: Theme.of(context).textTheme.headline2,),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              reviewItem(title: "الإسم", value: "${FormHelper.name!.text??''}",),
                              reviewItem(title: "رقم الهاتف", value: "${FormHelper.phone?.text} 20+",),
                              newDivider(),
                              reviewItem(title: "المنطقة", value: "${FormHelper.area}"),
                              reviewItem(title: "نظام التشغيل", value: "${FormHelper.os}"),
                              reviewItem(title: "عطل الهاتف", value: "${FormHelper.deffict}"),
                              reviewItem(title: "شركة الهاتف", value: "${FormHelper.factory}"),
                              reviewItem(title: "موديل الهاتف", value: "${FormHelper.model}"),
                              newDivider(),
                              reviewItem(title: "الموقع الجغرافي", value: "${FormHelper.Location}"),
                              newDivider(),
                              reviewItem(title: "وصف الطلب", value: "${FormHelper.problemDescription?.text}"),
                              reviewItem(title: "الوقت المناسب", value: "${FormHelper.preferredTme}"),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: FormHelper.photo != null? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Material(
                                      elevation:10,
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: FileImage(FormHelper.photo),
                                            fit: BoxFit.fill
                                          )
                                        ),
                                      ),
                                    ),
                                  ],
                                ):Container(),
                              ),



                            ],
                          ),
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
                          onPressed: () async {
                            showDialog(context: context, builder: (context){return const Center(child: CircularProgressIndicator());});
                            FormHelper.typeSelection = 'هاتف محمول';
                            final RequestVm = Provider.of<MaintenanceRequestVM>(context,listen: false);
                            MaintenanceRequestM order = MaintenanceRequestM(
                              area: FormHelper.area ?? '',
                              location: FormHelper.Location??'',
                              coordinates: FormHelper.coordinates ?? '',
                              phone: FormHelper.phone?.text??'',
                              name: FormHelper.name?.text??'',
                              preferredtime: FormHelper.preferredTme??'',
                              problemdescription: FormHelper.problemDescription?.text??'',
                              maintenancetype: FormHelper.typeSelection,
                              servicetype: FormHelper.serviceSelection.join(', '),
                              photourl: FormHelper.photo.path,
                              os: FormHelper.os,
                              model: FormHelper.model,
                              inhomecategory: FormHelper.serviceType,
                              factory: FormHelper.factory,
                              devicecategory:'',
                              deffict: FormHelper.deffict,
                              buildingtype: FormHelper.buildingType,

                            );
                            var res = await RequestVm.createRequest(order);

                            FormHelper.FormReset();
                            Navigator.pop(context);
                            await ConfirmAlert("${res?['ID']}",context);
                            Navigation.puchNav(LandingPage(), context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("تأكيد",style: TextStyle(color: Color(0xff50B04F),fontSize: 20),),
                              Icon(Icons.arrow_circle_left_outlined,color: Color(0xff50B04F),size: 30,)
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
        )
    );
  }
}



