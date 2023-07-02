import 'dart:convert';

import 'package:mobitech/business_logic/model/maints_m.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MaintenanceRep{

Future<MaintsM?> maintSearchById(int mid) async{
  try{
  var url=Uri.parse("${Apis.baseUrl}${Apis.maintenance}/$mid");

   var response=await http.get(url,
   headers:{ 'Accept':'application/json'
});
 if(response.statusCode==200)
  {

  var res=  jsonDecode(response.body) as Map<String,dynamic>;
  return MaintsM.formJson(res);
  }
  
    return null;
   

  }
  catch (err){
    print(err.toString());
    throw Exception(err);
    
  }}



}