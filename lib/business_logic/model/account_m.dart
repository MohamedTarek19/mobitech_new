import 'package:mobitech/data_layer/accounts/account.dart';

class AccountM {
  String? aname;
  int? id;
  String? atel;
  String? aface;
  String? agoogle;
  String? pass;
  String? amail;

  AccountM(
      {this.aname,
      this.aface,
      this.agoogle,
      this.amail,
      this.atel,
      this.id,
      this.pass});
  factory AccountM.formJson(Map<String, dynamic> json) {
    return AccountM(
        aface: json["aface"] as String?,
        agoogle: json["agoogle"] as String?,
        amail: json["amail"] as String,
        aname: json["aname"] as String,
        atel: json["atel"] as String?,
        id: json["id"]  ,
        pass: json["pass"] as String);
  }
  Map toJson() {
    return {
      "aname": aname as String,
      "amail": amail as String,
      "atel": atel as String,
      "agoogle": agoogle as String,
      "aface": aface as String,
      "id":"0",
      "pass": pass as String
    };
  }
}
