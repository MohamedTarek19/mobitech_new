import 'package:flutter/cupertino.dart';
import 'package:mobitech/business_logic/model/typesubs_m.dart';
import 'package:mobitech/data_layer/typesubs/typesubs.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;


class TypeSubsVm extends ChangeNotifier{

  List<TypeSubsM>? typeSubs;
  final TypeSubsRep _typesub = TypeSubsRep();

  Future<void> getTypeSubs() async {
    typeSubs = await _typesub.gettypeSub();
    notifyListeners();
  }
  Future<List<TypeSubsM>?> getTypeSubByTypeSet(String typework) async {
    typeSubs = await _typesub.getTypeSubByTypeSet(typework);
    notifyListeners();
    return typeSubs;
  }


}