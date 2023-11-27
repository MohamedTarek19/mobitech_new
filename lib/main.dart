import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:mobitech/business_logic/view_model/categories_vm.dart';
import 'package:mobitech/business_logic/view_model/emp_vm.dart';
import 'package:mobitech/business_logic/view_model/inhome_services_vm.dart';
import 'package:mobitech/business_logic/view_model/inhome_types_vm.dart';
import 'package:mobitech/business_logic/view_model/job_vm.dart';
import 'package:mobitech/business_logic/view_model/losts_vm.dart';
import 'package:mobitech/business_logic/view_model/maintenance_request_vm.dart';
import 'package:mobitech/business_logic/view_model/maints_vm.dart';
import 'package:mobitech/business_logic/view_model/modelsets_vm.dart';
import 'package:mobitech/business_logic/view_model/maintenance_vm.dart';
import 'package:mobitech/business_logic/view_model/phone_models_vm.dart';
import 'package:mobitech/business_logic/view_model/phone_types_vm.dart';
import 'package:mobitech/business_logic/view_model/typesets_vm.dart';
import 'package:mobitech/business_logic/view_model/typesubs_vm.dart';
import 'package:mobitech/business_logic/view_model/work_orders_vm.dart';
import 'package:mobitech/business_logic/view_model/zonearea_vm.dart';

import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/view/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var sharedPreferences= SharedPreferences.getInstance();

void main()async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AccountVM()),
          ChangeNotifierProvider(create: (context) => MaintsVM()),
          ChangeNotifierProvider(create: (context) => JobVM()),
          ChangeNotifierProvider(create: (context) => EmpVm()),
          ChangeNotifierProvider(create: (context) => LostVM()),
          ChangeNotifierProvider(create: (context)=>CategoriesVm()),
          ChangeNotifierProvider(create: (context)=>TypeSetsVm()),
          ChangeNotifierProvider(create: (context)=>TypeSubsVm()),
          ChangeNotifierProvider(create: (context)=>ZoneAreaVm()),
          ChangeNotifierProvider(create: (context)=>ModelSetsVm()),
          ChangeNotifierProvider(create: (context)=>WorkOrdersVM()),
          ChangeNotifierProvider(create: (context)=> MaintenanceVM()),
          ChangeNotifierProvider(create: (context)=> MaintenanceRequestVM()),
          ChangeNotifierProvider(create: (context)=> PhoneTypesVm()),
          ChangeNotifierProvider(create: (context)=> PhoneModelsVm()),
          ChangeNotifierProvider(create: (context)=> InHomeServicesVm()),
          ChangeNotifierProvider(create: (context)=> InHomeTypesVm()),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.themeData,
          home: const SplachScreen(),
        ),
      ),
    );
  }
}
