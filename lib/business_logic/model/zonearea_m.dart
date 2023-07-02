class ZoneAreaM{
  int? id;
  String? areaname;


  ZoneAreaM({this.id,this.areaname});

  factory ZoneAreaM.fromJson(Map<String?, dynamic> json){
    return ZoneAreaM(id: json['id'],areaname: json['areaname'] as String);
  }


}