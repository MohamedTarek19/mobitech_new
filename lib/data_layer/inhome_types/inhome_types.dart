import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobitech/apis/api_endpoints.dart';
import 'package:mobitech/business_logic/model/inhome_types_m.dart';


class InHomeTypesRep {

  Future<List<InHomeTypesM>?> findAllInHomeTypes() async {
    try {
      final request = {
        'query': '''
          query MyQuery {
  findAllHomeTypes {
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
        ['findAllHomeTypes'] as List;
        return res.map((e) => InHomeTypesM.fromJson(e)).toList();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
