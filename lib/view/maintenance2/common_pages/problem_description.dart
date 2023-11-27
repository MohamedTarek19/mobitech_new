import 'package:flutter/material.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/view/maintenance2/electronics/device_form_review.dart';
import 'package:mobitech/view/maintenance2/in_home/service_form_review.dart';
import 'package:mobitech/view/maintenance2/maintenance_helper.dart';
import 'package:mobitech/view/maintenance2/mobile/mobile_form_review.dart';
import 'package:mobitech/view/maintenance2/common_pages/preferred_time_list.dart';
import 'package:mobitech/widgets/FormTile.dart';
import 'package:mobitech/widgets/error_message_alert.dart';
import 'package:provider/provider.dart';

import '../../../utils/navigation.dart';

class ProblemDescription extends StatelessWidget {
  ProblemDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        //resizeToAvoidBottomInset:false,
        appBar: AppBar(elevation: 5, title: Text("أضف وصف للمشكلة", style: Theme.of(context).textTheme.headline2,),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,

          decoration: const BoxDecoration(
            gradient: AppTheme.mainGradient,
          ),
          child:SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height*0.88,
              child: Column(
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
                              // const Text('إختر الوقت المفضل للتنفيذ',
                              //   style: TextStyle(fontSize: 16,color: Colors.white),textAlign: TextAlign.right,),
                              StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {
                                  return FormTile(
                                    tileName: "إختر وقت التنفيذ المناسب",
                                    ontap: () async {
                                      FormHelper.preferredTme = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                        return PreferredTime();
                                      }));
                                      setState((){});
                                  },
                                    data: FormHelper.preferredTme,);
                                },

                              ),
                              SizedBox(
                                height: 20,
                              ),
                              const Text('أوصف مشكلتك و حاجتك بوضوح',
                                style: TextStyle(fontSize: 16,color: Colors.white),textAlign: TextAlign.right,),
                              const Text('أضف وصف واضح لمشكلتك ليتمكن مزود الخدمة من فهمها و تقديم العرض الأفضل لك',
                                style: TextStyle(fontSize: 14,color: Colors.white70),textAlign: TextAlign.right,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: TextFormField(
                                  maxLines: 10,
                                  controller: FormHelper.problemDescription,
                                  decoration: const InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      border: InputBorder.none,

                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "أضف وصف لمشكلتك"
                                  ),

                                  style: const TextStyle(
                                  ),


                                ),
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

                              if(FormHelper.preferredTme ==null){
                                alert('الوقت المناسب للتنفيذ',context);
                              }else if(FormHelper.problemDescription!.text.isEmpty){
                                alert('وصف المشكلة بوضوح',context);
                              }else{
                                if(FormHelper.typeSelection == 'هاتف محمول'){
                                  Navigation.puchNav(MobileFormReview(), context);
                                }else if (FormHelper.typeSelection == 'أجهزة كهربائية'){
                                  Navigation.puchNav(DeviceFormReview(), context);
                                }else{
                                  Navigation.puchNav(ServiceFormReview(), context);
                                }
                              }
                              //print(int.tryParse('1232'));

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("التالي",style: TextStyle(color: Color(0xff50B04F),fontSize: 20),),
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
          ),
        ),
      ),
    );
  }
}
