import 'package:flutter/cupertino.dart';
import 'package:mobitech/business_logic/model/modelsets_m.dart';
import 'package:mobitech/business_logic/model/typesubs_m.dart';
import 'package:mobitech/data_layer/modelsets/modelsets.dart';
import 'package:mobitech/data_layer/typesubs/typesubs.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;


class ModelSetsVm extends ChangeNotifier{

  List<ModelSetsM>? modelSets;
  final ModelSetsRep _modelSets = ModelSetsRep();

  Future<void> getModelSets() async {
    modelSets = await _modelSets.getModelSets();
    notifyListeners();
  }
  Future<List<ModelSetsM>?> getModelSetsByCatName(String catname) async {
    modelSets = await _modelSets.getmodelsetsByCatName(catname);
    notifyListeners();
    return modelSets;
  }


}