import 'package:mobitech/business_logic/model/typesets_m.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TypeSetsRep{
  Future<List<TypeSetsM>?> getTypeSets() async{
    try{
      var url=Uri.parse("${Apis.baseUrl}${Apis.typesets}");

      var response=await http.get(url, headers:{ 'Accept':'application/json'});
      print("fix");
      if(response.statusCode==200)
      {
        var res=  jsonDecode(response.body) as List ;
        print(res);
        var d= res.map((e) => TypeSetsM.fromJson(e)).toList();
        print(d);
        return d;
      }
      return null;
    }
    catch (err){
      print(err.toString());
      throw Exception(err);
    }
  }


}

