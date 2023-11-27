import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/maintenance_m.dart';
import 'package:mobitech/business_logic/model/maintenance_request_m.dart';

import 'package:mobitech/data_layer/maintenance/maintenance.dart';
import 'package:mobitech/data_layer/maintenance_request/maintenance_request.dart';


class MaintenanceRequestVM extends ChangeNotifier{

  MaintenanceRequestRep MaintsRep=MaintenanceRequestRep();


  // Future<dynamic> addWorkOrder(WorkOrdersM workorder)async{
  //   var result= await workOrdersRep.AddReceipt(workorder);
  //   notifyListeners();
  //   return result;
  // }

  Future<Map<String,dynamic>?> createRequest(MaintenanceRequestM order)async {
    var res = await MaintsRep.createRequest(order);
    notifyListeners();
    return res;
  }



}
