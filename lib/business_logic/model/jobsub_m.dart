class JobSubject {
  int? id;
  String? jname;
  String? aname;
  String? atel;
  JobSubject({this.id, this.aname, this.atel, this.jname});
  factory JobSubject.fromJson(Map<String, dynamic> json) {
    return JobSubject(
        id: json["id"],
        jname: json["jname"],
        aname: json["aname"],
        atel: json["atel"]);
  }
  Map<String, dynamic> toJson() {
    return {"id": "0", "jname": jname, "aname": aname, "atel": atel};
  }
}
