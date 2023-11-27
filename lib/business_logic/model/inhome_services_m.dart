class InHomeServicesM{
  String? ID;
  String? groubtype;
  String? phone_model;
  String? phone_type;


  InHomeServicesM({this.ID,this.groubtype,this.phone_model, this.phone_type});
  factory InHomeServicesM.fromJson(Map<String?, dynamic> json){
    return InHomeServicesM(
      ID: json['ID'] as String?,
      groubtype: json['groubtype'] as String?,
      phone_model: json["phone_model"] as String?,
      phone_type: json["phone_type"] as String?,

    );
  }


}