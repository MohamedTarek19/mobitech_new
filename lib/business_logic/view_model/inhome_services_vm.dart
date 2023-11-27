import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/inhome_services_m.dart';
import 'package:mobitech/data_layer/inhome_services/inhome_services.dart';




class InHomeServicesVm extends ChangeNotifier{

  InHomeServicesRep phoneModels=InHomeServicesRep();
  List<InHomeServicesM>? services;

  Future<List<InHomeServicesM>?> findServicesByType(String type)async {
    services = await phoneModels.findServicesByType(type);
    print(services?.first.phone_type);
    notifyListeners();
    return services;
  }



}
