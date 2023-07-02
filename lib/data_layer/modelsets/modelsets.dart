import 'package:mobitech/business_logic/model/modelsets_m.dart';
import 'package:mobitech/business_logic/model/typesubs_m.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModelSetsRep{
  Future<List<ModelSetsM>?> getModelSets() async{
    try{
      var url=Uri.parse("${Apis.baseUrl}${Apis.modelsets}");

      var response=await http.get(url, headers:{ 'Accept':'application/json'});
      if(response.statusCode==200)
      {
        var res=  jsonDecode(response.body) as List ;
        var d= res.map((e) => ModelSetsM.fromJson(e)).toList();
        print(d.first.model);
        return d;
      }
      return null;
    }
    catch (err){
      print(err.toString());
      throw Exception(err);
    }}

  Future<List<ModelSetsM>?> getmodelsetsByCatName(String catname) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.modelsets}/$catname");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d= res.map((e) => ModelSetsM.fromJson(e)).toList();
        //print(d.first.model);
        return d;
      }

      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }


}

