import 'package:flutter/cupertino.dart';
import 'package:mobitech/business_logic/model/typesets_m.dart';
import 'package:mobitech/data_layer/typesets/typesets.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;


class TypeSetsVm extends ChangeNotifier{

  List<TypeSetsM>? TypeSets;
  final TypeSetsRep _TypeSetsRep = TypeSetsRep();

  Future<void> getTypeSets() async {
    TypeSets = await _TypeSetsRep.getTypeSets();
    notifyListeners();
  }

}