import 'package:flutter/cupertino.dart';
import 'package:mobitech/business_logic/model/catsets_m.dart';
import 'package:mobitech/data_layer/phone_categories/categories.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;


class CategoriesVm extends ChangeNotifier{

  List<CatsetsM>? MainCategories;
  final CategoryRep _catRep = CategoryRep();

  Future<void> getPhoneCategories() async {
    MainCategories = await _catRep.getCategories();
    notifyListeners();
  }
  Future<List<CatsetsM>?> getPhoneCategoriesByTypeSub(String typesub) async {
    MainCategories = await _catRep.getCategoriesByTypeSub(typesub);
    notifyListeners();
    return MainCategories;
  }


}