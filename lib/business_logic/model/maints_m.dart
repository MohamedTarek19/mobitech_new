import 'package:mobitech/data_layer/accounts/account.dart';

class MaintsM {
  int? idno;
  int? id;
   String? custname;
  String? custel;
  String? mstate;
  double? mcost;
  int get ds{
    return 4;
  }
 
  MaintsM(
      { this.custel,this.custname,this.id,this.idno,this.mcost,this.mstate});
  factory MaintsM.formJson(Map<String, dynamic> json) {
    return MaintsM(
        custel: json["custtel"] ,
        custname: json["custname"] ,
        mstate: json["mstate"] ,
        mcost:double.parse( json["mcost"].toString()),
        idno: json["idno"]  ,
        id: json["id"]);
   }
  Map toJson() {
    return{
  "id": "0" ,
  "idno": idno,
  "custname": custname,
  "custel": custel,
  "mstate": mstate,
  "mcost": mcost
};
  }
}
