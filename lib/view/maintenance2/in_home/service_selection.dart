import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/inhome_types_m.dart';
import 'package:mobitech/business_logic/view_model/inhome_services_vm.dart';
import 'package:mobitech/business_logic/view_model/inhome_types_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';

import 'package:mobitech/view/maintenance2/alert2.dart';
import 'package:mobitech/view/maintenance2/electronics/device_first_screen.dart';
import 'package:mobitech/view/maintenance2/in_home/service_first_screen.dart';
import 'package:mobitech/view/maintenance2/maintenance_helper.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:provider/provider.dart';

class ServiceSelection extends StatelessWidget {
  ServiceSelection({Key? key}) : super(key: key);


  late InHomeTypesM item;

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<InHomeServicesVm>(context,listen: false);
    final types = Provider.of<InHomeTypesVm>(context,listen: false);
    item = types.inhome!.first;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar("طلب خدمات منزلية", context),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            //color: Colors.blue,
              gradient: AppTheme.mainGradient),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(
                              child: Text(
                                "إختر الخدمة",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.08),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(30),
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: DropdownButton<InHomeTypesM>(
                                        borderRadius:BorderRadius.circular(30),
                                        isExpanded: true,
                                        underline: Container(),
                                        value: item,
                                        items: types.inhome?.map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Center(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.77,
                                                  child: Center(child: Text(e.phone_type??'')),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (InHomeTypesM? value) {
                                          setState(() {
                                            item = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomBtn(
                                name: "التالي",
                                action: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      });
                                  await services.findServicesByType(item.phone_type??'');
                                  Navigator.pop(context);
                                  FormHelper.FormReset();
                                  Navigation.puchNav(ServiceFirstScreen(services: services.services??[],), context);
                                }),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
