import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/inhome_types_m.dart';
import 'package:mobitech/business_logic/model/maintenance_m.dart';
import 'package:mobitech/business_logic/model/phone_types_m.dart';
import 'package:mobitech/data_layer/inhome_types/inhome_types.dart';

import 'package:mobitech/data_layer/maintenance/maintenance.dart';
import 'package:mobitech/data_layer/phone_types/phone_types.dart';


class InHomeTypesVm extends ChangeNotifier{

  InHomeTypesRep InHomeGroups=InHomeTypesRep();
  List<InHomeTypesM>? inhome;

  Future<List<InHomeTypesM>?> findAllInHomeTypes()async {
    inhome = await InHomeGroups.findAllInHomeTypes();
    print(inhome?.first.phone_type);
    notifyListeners();
    return inhome;
  }



}
