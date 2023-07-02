class ModelSetsM{
  int? id;
  String? model;
  String? gname;

  ModelSetsM({this.id,this.model,this.gname});
  factory ModelSetsM.fromJson(Map<String?, dynamic> json){
    return ModelSetsM(id: json['id'],model: json['model'] as String,gname: json["gname"]);
  }


}