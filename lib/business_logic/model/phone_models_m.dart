class PhoneModelsM{
  String? ID;
  String? groubtype;
  String? phone_model;
  String? phone_type;


  PhoneModelsM({this.ID,this.groubtype,this.phone_model, this.phone_type});
  factory PhoneModelsM.fromJson(Map<String?, dynamic> json){
    return PhoneModelsM(
        ID: json['ID'] as String?,
        groubtype: json['groubtype'] as String?,
        phone_model: json["phone_model"] as String?,
        phone_type: json["phone_type"] as String?,

    );
  }


}