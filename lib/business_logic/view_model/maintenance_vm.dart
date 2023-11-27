import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/maintenance_m.dart';

import 'package:mobitech/data_layer/maintenance/maintenance.dart';


class MaintenanceVM extends ChangeNotifier{

  MaintenanceRep MaintsRep=MaintenanceRep();
  MaintenanceM? maints;

  // Future<dynamic> addWorkOrder(WorkOrdersM workorder)async{
  //   var result= await workOrdersRep.AddReceipt(workorder);
  //   notifyListeners();
  //   return result;
  // }

  Future<MaintenanceM?> getMaintsById(int id)async {
    maints = await MaintsRep.getMaintsById(id);
    print(maints?.customer_name);
    notifyListeners();
    return maints;
  }



}
