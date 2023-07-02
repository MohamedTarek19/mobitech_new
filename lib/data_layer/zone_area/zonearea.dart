import 'package:mobitech/business_logic/model/zonearea_m.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ZoneAreaRep{
  Future<List<ZoneAreaM>?> getZoneArea() async{
    try{
      var url=Uri.parse("${Apis.baseUrl}${Apis.zoa}");

      var response=await http.get(url, headers:{ 'Accept':'application/json'});
      if(response.statusCode==200)
      {
        var res=  jsonDecode(response.body) as List ;
        var d= res.map((e) => ZoneAreaM.fromJson(e)).toList();
        print(d.first.areaname);
        return d;
      }
      return null;
    }
    catch (err){
      print(err.toString());
      throw Exception(err);
    }}


}

