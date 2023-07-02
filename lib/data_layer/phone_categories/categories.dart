import 'package:mobitech/business_logic/model/catsets_m.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryRep{
  Future<List<CatsetsM>?> getCategories() async{
    try{
      var url=Uri.parse("${Apis.baseUrl}${Apis.catsets}");

      var response=await http.get(url, headers:{ 'Accept':'application/json'});
      if(response.statusCode==200)
      {
        var res=  jsonDecode(response.body) as List ;
        var d= res.map((e) => CatsetsM.fromJson(e)).toList();
        print(d.first.catname);
        return d;
      }
      return null;
    }
    catch (err){
      print(err.toString());
      throw Exception(err);
    }}

  Future<List<CatsetsM>?> getCategoriesByTypeSub(String typesub) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.catsets}/$typesub");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d= res.map((e) => CatsetsM.fromJson(e)).toList();
        print(d.first.typesub);
        return d;
      }

      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }


}

