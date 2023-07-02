class Empin {
  Empin({
     this.id,
     this.empcode,
     this.empname,
     this.edate,
     this.timein,
     this.stat,
  });
   int? id;
   int? empcode;
   String? empname;
   String? edate;
   String? timein;
   int? stat;
  
  Empin.fromJson(Map<String, dynamic> json){
    id = json['id'];
    empcode = json['empcode'];
    empname = json['empname'];
    edate = json['edate'];
    timein = json['timein'];
    stat = json['stat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['empcode'] = empcode;
    _data['empname'] = empname;
    _data['edate'] = edate;
    _data['timein'] = timein;
    _data['stat'] = stat;
    return _data;
  }
}