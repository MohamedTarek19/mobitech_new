import 'dart:convert';

import 'package:mobitech/business_logic/model/losts_m.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart'as http;

class StolenRep{




Future<LostsM?> losttSearchBySerial(String gserial) async{
  try{
  var url=Uri.parse("${Apis.baseUrl}${Apis.mlosts}/$gserial");

   var response=await http.get(url,
   headers:{ 'Accept':'application/json'
});
 if(response.statusCode==200)
  {

  var res=  jsonDecode(response.body) as Map<String,dynamic>;
  return LostsM.fromJson(res);
  }
  
    return null;
   

  }
  on Exception catch (err){
    print(err.toString());
    throw Exception(err);
    
  }}

Future<Object> lostReport(LostsM lostM) async{
  print("dsdsdsd");
  try{
  var url=Uri.parse(Apis.baseUrl+Apis.mlosts);

   var response=await http.post(url,body: lostM.toJson(),
   headers:{ 'Accept':'application/json'
});
if(response.statusCode==201) {
  print("ds");
  return response.statusCode;
}
print(response.body);
 return 404;

  }
   catch (err){
    print("..........");
    print(err.toString());
    throw Exception(err);
    
  }

}
  
}