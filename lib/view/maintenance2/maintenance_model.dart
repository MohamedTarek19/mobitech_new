class MaintenanceModel {
  String? id;

  String area;

  String? os;

  String? deffict;

  String? factory;

  String? model;

  String Location;

  String coordinates;

  String? photoUrl;

  String phone;

  String name;

  String preferredTme;

  String problemDescription;

  String? serviceType;

  String? buildingType;

  String? DeviceCategory;

  String? InhomeCategory;

  String MaintenanceType;

  MaintenanceModel({
    this.id,
    required this.area,
    this.os,
    this.deffict,
    this.factory,
    this.model,
    required this.Location,
    required this.coordinates,
    this.photoUrl,
    required this.phone,
    required this.name,
    required this.preferredTme,
    required this.problemDescription,
    this.serviceType,
    this.buildingType,
    this.DeviceCategory,
    this.InhomeCategory,
    required this.MaintenanceType,
  });

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceModel(
      id: json['id'] as String?,
      area: json['area'] as String,
      os: json[' os'] as String?,
      deffict: json[' deffict'] as String?,
      factory: json[' factory'] as String?,
      model: json[' model'] as String?,
      Location: json['Location'] as String,
      coordinates: json['coordinates'] as String,
      photoUrl: json[' photoUrl'] as String?,
      phone: json['phone'] as String,
      name: json['name'] as String,
      preferredTme: json['preferredTme'] as String,
      problemDescription: json['problemDescription'] as String,
      serviceType: json["serviceType"] as String?,
      buildingType: json["buildingType"] as String?,
      DeviceCategory: json["DeviceCategory"] as String?,
      InhomeCategory: json["InhomeCategory"] as String?,
      MaintenanceType: json["MaintenanceType"] as String,
    );
  }

  Map toJson() {
    return {
      "deffict": deffict as String?,
      "area": area as String,
      "os": os as String?,
      "id": "0",
      "factory": factory as String?,
      "model": model as String?,
      "Location": Location as String,
      "coordinates": coordinates as String,
      "photoUrl": photoUrl as String?,
      "phone": phone as String,
      "name": name as String,
      "preferredTme": preferredTme as String,
      "problemDescription": problemDescription as String,
      "serviceType": serviceType as String?,
      "buildingType": buildingType as String?,
      "DeviceCategory": DeviceCategory as String?,
      "InhomeCategory": InhomeCategory as String?,
      "MaintenanceType": MaintenanceType as String,
    };
  }
}
