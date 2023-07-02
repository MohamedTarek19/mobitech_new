import 'package:mobitech/business_logic/model/typesubs_m.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TypeSubsRep{
  Future<List<TypeSubsM>?> gettypeSub() async{
    try{
      var url=Uri.parse("${Apis.baseUrl}${Apis.typesubs}");

      var response=await http.get(url, headers:{ 'Accept':'application/json'});
      if(response.statusCode==200)
      {
        var res=  jsonDecode(response.body) as List ;
        var d= res.map((e) => TypeSubsM.fromJson(e)).toList();
        print(d.first.typework);
        return d;
      }
      return null;
    }
    catch (err){
      print(err.toString());
      throw Exception(err);
    }}

  Future<List<TypeSubsM>?> getTypeSubByTypeSet(String typework) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.typesubs}/$typework");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d= res.map((e) => TypeSubsM.fromJson(e)).toList();
        print(d.first.typesub1);
        return d;
      }

      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }


}

