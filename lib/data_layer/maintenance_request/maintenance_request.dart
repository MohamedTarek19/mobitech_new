import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobitech/apis/api_endpoints.dart';
import 'package:mobitech/business_logic/model/maintenance_m.dart';
import 'package:mobitech/business_logic/model/maintenance_request_m.dart';

class MaintenanceRequestRep {

  Future<Map<String,dynamic>?> createRequest(MaintenanceRequestM order) async {
    final request = {'query': """
 mutation MyMutation {
  createMaintenanceRequest(
    area: "${order.area}"
    buildingtype: "${order.buildingtype}"
    coordinates: "${order.coordinates}"
    deffict: "${order.deffict}"
    devicecategory: "${order.devicecategory}"
    factory: "${order.factory}"
    inhomecategory: "${order.inhomecategory}"
    location: "${order.location}"
    maintenancetype: "${order.maintenancetype}"
    model: "${order.model}"
    name: "${order.name}"
    os: "${order.os}"
    phone: "${order.phone}"
    photourl: "${order.photourl}"
    preferredtime: "${order.preferredtime}"
    problemdescription: "${order.problemdescription}"
    servicetype: "${order.servicetype}"
  ) {
    ID
    area
    buildingtype
    coordinates
    deffict
    devicecategory
    factory
    inhomecategory
    location
    model
    name
    maintenancetype
    os
    phone
    photourl
    preferredtime
    problemdescription
    servicetype
  }
}
    
    """};
    final response = await http.post(Uri.parse(Apis.baseUrl),
      headers: {"Content-Type": "Application/json"},
      body: jsonEncode(request),
    );
    if(response.statusCode == 200){
      print(response.body);
      var res = jsonDecode(utf8.decode(response.bodyBytes))['data']['createMaintenanceRequest'] as Map<String, dynamic>;

      print(res);
      return res;
      // print(res['id'].runtimeType);
    }



  }

// Future<List<WorkOrdersM>?> getWorkOrdersByCustId(int custid) async {
//   try {
//     var url = Uri.parse("${Apis.baseUrl}${Apis.typesubs}/$custid");
//     var response =
//     await http.get(url, headers: {'Accept': 'application/json'});
//     try{
//       var res = jsonDecode(response.body) as List;
//       var d= res.map((e) => WorkOrdersM.fromJson(e)).toList();
//       return d;
//     }catch(e){
//       print(e);
//     }
//
//     return null;
//   } on Exception catch (err) {
//     print(err.toString());
//     throw Exception(err);
//   }
// }
}
