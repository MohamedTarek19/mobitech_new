import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/account_m.dart';
import 'package:mobitech/business_logic/model/work_orders_m.dart';
import 'package:mobitech/data_layer/accounts/account.dart';
import 'package:mobitech/data_layer/work_orders/work_orders.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_layer/localdata/localdata.dart';
class WorkOrdersVM extends ChangeNotifier{

  WorkOrdersRep workOrdersRep=WorkOrdersRep();
  List<WorkOrdersM>? orders;

  Future<dynamic> addWorkOrder(WorkOrdersM workorder)async{
    var result= await workOrdersRep.AddReceipt(workorder);
    notifyListeners();
    return result;
  }

  Future<List<WorkOrdersM>?> getWorkOrders()async {
    orders = await workOrdersRep.getWorkOrders();
    notifyListeners();
    return orders;
  }

  Future<List<WorkOrdersM>?> getWorkOrdersByCustId(int custid)async{
    orders= await workOrdersRep.getWorkOrdersByCustId(custid);
    notifyListeners();
    return orders;
  }


}
