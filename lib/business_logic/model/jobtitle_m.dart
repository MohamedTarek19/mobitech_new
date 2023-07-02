class JobTitle{
  int?id;
  String? jname;
  JobTitle({this.id,this.jname});
  factory JobTitle.fromJson(Map<String, dynamic>json){


    return JobTitle(id: json["id"],jname: json["jname"]);

  }

}