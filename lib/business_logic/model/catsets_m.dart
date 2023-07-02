class CatsetsM{
  int? id;
  String? catname;
  String? typesub;

  CatsetsM({this.id,this.catname,this.typesub});

  factory CatsetsM.fromJson(Map<String?, dynamic> json){
    return CatsetsM(id: json['id'],catname: json['catname'] as String,typesub: json['typesub'] as String);
  }


}