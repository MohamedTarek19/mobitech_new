import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/maintenance_m.dart';
import 'package:mobitech/business_logic/model/phone_types_m.dart';

import 'package:mobitech/data_layer/maintenance/maintenance.dart';
import 'package:mobitech/data_layer/phone_types/phone_types.dart';


class PhoneTypesVm extends ChangeNotifier{

  PhoneTypesRep phoneGroups=PhoneTypesRep();
  List<PhoneTypesM>? Phone;

  Future<List<PhoneTypesM>?> findAllMobileTypes()async {
    Phone = await phoneGroups.findAllMobileTypes();
    print(Phone?.first.phone_type);
    notifyListeners();
    return Phone;
  }



}
