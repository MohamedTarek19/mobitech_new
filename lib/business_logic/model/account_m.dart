import 'package:mobitech/data_layer/accounts/account.dart';

class AccountM {
  String? aname; //user name
  String? ID;// user id
  String? atel;// user phone
  String? aface;// user facebook account // social login
  String? agoogle;// user google account // social login
  String? pass;// user password
  String? amail;// user other email

  AccountM(
      {this.aname,
      this.aface,
      this.agoogle,
      this.amail,
      this.atel,
      this.ID,
      this.pass});
  factory AccountM.formJson(Map<String, dynamic> json) {
    return AccountM(
        aface: json["aface"] as String?,
        agoogle: json["agoogle"] as String?,
        amail: json["amail"] as String,
        aname: json["aname"] as String,
        atel: json["atel"] as String?,
        ID: json["ID"]  ,
        pass: json["pass"] as String);
  }
}
