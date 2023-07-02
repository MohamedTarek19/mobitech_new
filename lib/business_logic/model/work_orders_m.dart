class WorkOrdersM {
  int? id;
  String? typework; //نوع الفورم
  String? typesub; //نوع ما بداخل الفورم
  String? custname;
  String? custmobile;
  String? area;
  String? address;
  String? workdesc;
  String? castset; //كاتيجوري/نوع خدمة
  String? modelset;
  String? lline; //خط طول
  String? lwidth; //خط عرض
  String? mimage;
  String? visittime;
  String? errortype;
  String? servicetype;
  String? buildtype;
  String? st;
  String? wnote;
  String? custid;

  WorkOrdersM(
      {this.id,
        this.typework,
        this.typesub,
        this.custname,
        this.custmobile,
        this.area,
        this.address,
        this.workdesc,
        this.castset,
        this.modelset,
        this.mimage,
        this.lline,
        this.lwidth,
        this.visittime,
        this.buildtype,
        this.errortype,
        this.servicetype,
        this.st,
        this.wnote,
        this.custid,
      });

  factory WorkOrdersM.fromJson(Map<String?, dynamic> json) {
    return WorkOrdersM(
      id: json['id'],
      typework: json['typework'] as String?,
      typesub: json["typesub"] as String?,
      custname: json["custname"] as String?,
      custmobile: json["custmobile"] as String?,
      area: json["area"] as String?,
      address: json["address"] as String?,
      workdesc: json["workdesc"] as String?,
      castset: json["castset"] as String?,
      modelset: json["modelset"] as String?,
      mimage: json["mimage"] as String?,
      lline: json["lline"] as String?,
      lwidth: json["lwidth"] as String?,
      visittime: json["visittime"] as String?,
      buildtype: json["buildtype"] as String?,
      errortype: json["errortype"] as String?,
      servicetype: json["servicetype"] as String?,
      st: json["st"] as String?,
      wnote: json["wnote"] as String?,
      custid: json["custid"].toString(),
    );
  }

  Map toJson() {
    return {
      "typework": typework as String?,
      "typesub": typesub as String?,
      "custname": custname as String?,
      "custmobile": custmobile as String?,
      "area": area as String?,
      "id": "0",
      "address": address as String?,
      "workdesc": workdesc as String?,
      "castset": castset as String?,
      "modelset": modelset as String?,
      "mimage": mimage as String?,
      "lline": lline as String?,
      "lwidth": lwidth as String?,
      "visittime": visittime as String?,
      "buildtype": buildtype as String?,
      "errortype": errortype as String?,
      "servicetype": servicetype as String?,
      "st": st as String?,
      "wnote": wnote as String?,
      "custid": custid as String?,
    };
  }
}
