import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobitech/apis/api_endpoints.dart';
import 'package:mobitech/business_logic/model/inhome_services_m.dart';
import 'package:mobitech/business_logic/model/maintenance_m.dart';
import 'package:mobitech/business_logic/model/phone_models_m.dart';
import 'package:mobitech/business_logic/model/phone_types_m.dart';
import 'package:mobitech/view/maintenance2/mobile/first_screen_pages/phone_model.dart';

class InHomeServicesRep {

  Future<List<InHomeServicesM>?> findServicesByType(String type) async {
    try {
      final request = {
        'query': '''
          query MyQuery {
  findHomeByPhoneType(phone_type: "$type") {
    ID
    groubtype
    phone_model
    phone_type
  }
}
        '''
      };

      final response = await http.post(
        Uri.parse(Apis.baseUrl),
        headers: {"Content-Type": "Application/json"},
        body: jsonEncode(request),
      );

      if (response.statusCode == 200) {
        var res = jsonDecode(utf8.decode(response.bodyBytes))['data']
        ['findHomeByPhoneType'] as List;
        print(res.first.toString());
        return res.map((e) => InHomeServicesM.fromJson(e)).toList();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
