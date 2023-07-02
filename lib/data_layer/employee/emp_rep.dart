import 'package:mobitech/business_logic/model/empin_m.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;

class EmpRep{

Future<Object> empCheckIn(Empin empin) async{
  print("dsdsdsd");
  try{
  var url=Uri.parse(Apis.baseUrl+Apis.jopSubs);

   var response=await http.post(url,body: empin.toJson(),
   headers:{ 'Accept':'application/json'
});
if(response.statusCode==201) {
  
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