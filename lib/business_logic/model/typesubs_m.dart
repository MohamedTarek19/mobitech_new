class TypeSubsM{
  int? id;
  String? typework;
  String? typesub1;

  TypeSubsM({this.id,this.typework,this.typesub1});

  factory TypeSubsM.fromJson(Map<String?, dynamic> json){
    return TypeSubsM(id: json['id'],typework: json['typework'] as String,typesub1: json["typesub1"]);
  }


}