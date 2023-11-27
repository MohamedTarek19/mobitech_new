class MaintenanceM {
  String? id;

  String? customer_name;

  String? customer_tele;

  String? customer_paid;

  String? stat;

  String? serial_number;

  String? report;

  String? phone_model;

  String? phone_error;

  String? engreply;

  MaintenanceM({
    this.id,
    this.customer_name,
    this.customer_tele,
    this.customer_paid,
    this.stat,
    this.serial_number,
    this.report,
    this.phone_model,
    this.phone_error,
    this.engreply,
  });

  factory MaintenanceM.fromJson(Map<String, dynamic> json) {
    return MaintenanceM(
      id: json['id'] as String?,
      customer_name: json["customer_name"] as String?,
      customer_tele: json["customer_tele"] as String?,
      customer_paid: json["customer_paid"] as String?,
      stat: json["stat"] as String?,
      serial_number: json["serial_number"] as String?,
      report: json["report"] as String?,
      phone_model: json["phone_model"] as String?,
      phone_error: json["phone_error"] as String?,
      engreply: json["engreply"] as String?,
    );
  }

  Map toJson() {
    return {
      "customer_name": customer_name as String?,
      "customer_tele": customer_tele as String?,
      "id": "0",
      "customer_paid": customer_paid as String?,
      "stat": stat as String?,
      "serial_number": serial_number as String?,
      "report": report as String?,
      "phone_model": phone_model as String?,
      "phone_error": phone_error as String?,
      "engreply": engreply as String?,
    };
  }
}
