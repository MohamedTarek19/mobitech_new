import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/view_model/inhome_types_vm.dart';
import 'package:mobitech/business_logic/view_model/phone_types_vm.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintenance2/electronics/device_selection.dart';
import 'package:mobitech/view/maintenance2/in_home/service_selection.dart';
import 'package:mobitech/view/maintenance2/mobile/mobile_first_screen.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:provider/provider.dart';

import '../../theme/appthrmr.dart';

class Alert2 extends StatelessWidget {
  final selection;
  Alert2({Key? key,required this.selection}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar("إنشاء طلب جديد", context),
        body: Container(
          decoration: const BoxDecoration(
              gradient: AppTheme.mainGradient,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          "سنسألك بعض الأسئلة لجمع التفاصيل حول طلبك و إرسالها للشركة و الفنيين",
                        style: TextStyle(

                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 50,
                    endIndent: 50,
                    height: 2,
                    thickness: 3,
                    color: Colors.white,
                  )
                ],
              )),
              Expanded(
                flex: 2,
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomBtn(
                      name: "التالي",
                      action: () async {
                        showDialog(context: context, builder: (context){return const Center(child: CircularProgressIndicator());});
                        final types = Provider.of<PhoneTypesVm>(context,listen: false);
                        if(selection == 'هاتف محمول'){
                          await types.findAllMobileTypes();
                          types.Phone = types.Phone?.where((element) => element.groubtype == 'هاتف محمول').toList();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigation.puchNav(MobileFirstScreen(), context);
                        }else if(selection =='أجهزة كهربائية'){
                          Navigation.puchNav(DeviceSelection(), context);
                        }else{
                          final types = Provider.of<InHomeTypesVm>(context,listen: false);
                          await types.findAllInHomeTypes();
                          Navigation.puchNav(ServiceSelection(), context);
                        }
                        //Navigator.pop(context);

                      }),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
