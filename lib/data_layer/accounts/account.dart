import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobitech/apis/api_endpoints.dart';
import 'dart:io';
import 'package:mobitech/business_logic/model/account_m.dart';

class AccountRep {
  Future<Map<String,dynamic>?> createAccount(AccountM user) async{
    final request = {'query': """
    mutation MyMutation {
  createAccountSocial(
    aface: "${user.aface}"
    agoogle: "${user.agoogle}"
    amail: "${user.amail}"
    aname: "${user.aname}"
    atel: "${user.atel}"
    pass: "${user.pass}"
  ) {
    ID
    aface
    agoogle
    amail
    aname
    atel
    pass
  }
}
    """};
    final response = await http.post(Uri.parse(Apis.baseUrl),
      headers: {"Content-Type": "Application/json"},
      body: jsonEncode(request),
    );
    if(response.statusCode == 200){
      print(response.body);
      var res = jsonDecode(utf8.decode(response.bodyBytes))['data']['createAccountSocial'] as Map<String, dynamic>;

      print(res);
      return res;
      // print(res['id'].runtimeType);
    }
  }

  Future<AccountM?> login(String email) async {
    try {
      final request = {
        'query': '''
          query MyQuery {
  findAccountSocialByEmail(email: "$email") {
    ID
    aface
    agoogle
    amail
    aname
    atel
    pass
  }
}
        '''
      };

      final response = await http.post(Uri.parse(Apis.baseUrl),
        headers: {"Content-Type": "Application/json"},
        body: jsonEncode(request),
      );

      if(response.statusCode == 200){
        var res = jsonDecode(utf8.decode(response.bodyBytes))['data']['findAccountSocialByEmail'] as Map<String, dynamic>;
        print(res['ID']);
        print(res['aname']);
        return AccountM.formJson(res);
      }
    }catch(e){
      print(e.toString());
    }
  }
}
