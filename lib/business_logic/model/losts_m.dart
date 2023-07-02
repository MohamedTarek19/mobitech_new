class LostsM {
  LostsM({
     this.id,
     this.gname,
     this.gmodel,
     this.gserial,
     this.aname,
     this.gtel,
     this.gdate,
     this.st,
  });
 int? id;
 String? gname;
 String? gmodel;
 String? gserial;
 String? aname;
 String? gtel;
 String? gdate;
 int? st;
  
  LostsM.fromJson(Map<String?, dynamic> json){
    id = json['id'];
    gname = json['gname'];
    gmodel = json['gmodel'];
    gserial = json['gserial'];
    aname = json['aname'];
    gtel = json['gtel'];
    gdate = json['gdate'];
    st = json['st'];
  }

  Map<String?, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = "0";
    _data['gname'] = gname;
    _data['gmodel'] = gmodel;
    _data['gserial'] = gserial;
    _data['aname'] = aname;
    _data['gtel'] = gtel;
    _data['gdate'] = gdate;
    _data['st'] = "0";
    return _data;
  }
}