import 'dart:convert';

import 'package:mobitech/business_logic/model/jobtitle_m.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;

import '../../business_logic/model/jobsub_m.dart';

class JopRep{

Future<List<JobTitle>?> getJobTitles() async{
  try{
  var url=Uri.parse("${Apis.baseUrl}${Apis.jopTitls}");

   var response=await http.get(url,
   headers:{ 'Accept':'application/json'});
 if(response.statusCode==200)
  {

  var res=  jsonDecode(response.body) as List ;
 var d= res.map((e) => JobTitle.fromJson(e)).toList();
 print(d.first.jname);
 return d;
  }
  
    return null;
   

  }
 catch (err){
    print(err.toString());
    throw Exception(err);
    
  }}

Future<List<JobSubject>?> getJobsByName(String? jname) async{
  try{
  var url=Uri.parse("${Apis.baseUrl}${Apis.jopSubs}/$jname");

   var response=await http.get(url,
   headers:{ 'Accept':'application/json'
});
 if(response.statusCode==200)
  {

  var res=  jsonDecode(response.body) as List ;
 var d= res.map((e) => JobSubject.fromJson(e)).toList();
 print(d.first.jname);
 return d;
  }
  
    return null;
   

  }
 catch (err){
    print(err.toString());
    throw Exception(err);
    
  }}



Future<Object> createJobRep(JobSubject jobSubject) async{
  print("dsdsdsd");
  try{
  var url=Uri.parse(Apis.baseUrl+Apis.jopSubs);

   var response=await http.post(url,body: jobSubject.toJson(),
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