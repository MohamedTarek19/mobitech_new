import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:mobitech/business_logic/model/maints_m.dart';
import 'package:mobitech/data_layer/maints/maintenance.dart';

class MaintsVM extends ChangeNotifier{
   MaintenanceRep maintenanceRep =MaintenanceRep();
   List<MaintsM> maintsList=[];
   MaintsM? maintsM;
   Future<void> getMaintsById(int mid)async{

    var result=await maintenanceRep.maintSearchById(mid);
    maintsM=result;
    notifyListeners();
   }


   
    



}