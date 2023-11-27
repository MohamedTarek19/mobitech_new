class PhoneTypesM{
  String? ID;
  String? groubtype;
  String? phone_type;

  PhoneTypesM({this.ID,this.groubtype,this.phone_type});
  factory PhoneTypesM.fromJson(Map<String?, dynamic> json){
    return PhoneTypesM(ID: json['ID'] as String?,groubtype: json['groubtype'] as String?,phone_type: json["phone_type"] as String?);
  }


}