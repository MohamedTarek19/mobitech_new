class TypeSetsM{
  int? id;
  String? typework;

  TypeSetsM({this.id,this.typework});

  TypeSetsM.fromJson(Map<String?, dynamic> json){
    id = json['id'];
    typework = json['typework'] as String;
  }


}