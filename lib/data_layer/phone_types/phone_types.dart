import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobitech/apis/api_endpoints.dart';
import 'package:mobitech/business_logic/model/maintenance_m.dart';
import 'package:mobitech/business_logic/model/phone_types_m.dart';

class PhoneTypesRep {

  Future<List<PhoneTypesM>?> findAllMobileTypes() async {
    try {
      final request = {
        'query': '''
          query MyQuery {
  findAllMobileTypes {
    ID
    groubtype
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
            ['findAllMobileTypes'] as List;
        return res.map((e) => PhoneTypesM.fromJson(e)).toList();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
