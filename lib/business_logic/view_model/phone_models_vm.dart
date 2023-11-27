import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/phone_models_m.dart';
import 'package:mobitech/data_layer/phone_models/phone_models.dart';



class PhoneModelsVm extends ChangeNotifier{

  PhoneModelsRep phoneModels=PhoneModelsRep();
  List<PhoneModelsM>? models;

  Future<List<PhoneModelsM>?> findModelsByPhoneType(String type)async {
    models = await phoneModels.findModelsByPhoneType(type);
    print(models?.first.phone_type);
    notifyListeners();
    return models;
  }



}
