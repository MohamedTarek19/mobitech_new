import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobitech/apis/api_endpoints.dart';
import 'package:mobitech/business_logic/model/maintenance_m.dart';

class MaintenanceRep {


  Future<MaintenanceM?> getMaintsById(int id) async {
    try{
      final request = {
        'query': '''
          query MyQuery {
  findOneCustomer(id: "$id") {
    customer_name
    customer_paid
    customer_tele
    engreply
    id
    phone_error
    phone_model
    report
    serial_number
    stat
  }
}      
        '''
      };

      final response = await http.post(Uri.parse(Apis.baseUrl),
        headers: {"Content-Type": "Application/json"},
        body: jsonEncode(request),
      );

      if(response.statusCode == 200){
        var res = jsonDecode(utf8.decode(response.bodyBytes))['data']['findOneCustomer'] as Map<String, dynamic>;
        print(res['id']);
        print(res['customer_tele']);
        return MaintenanceM.fromJson(res);
      }
    }catch(e){
      print(e.toString());
    }
  }

}
