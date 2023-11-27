import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/phone_types_m.dart';

class FormHelper {
  static List<PhoneTypesM>? tmp;
  static int? id;

  static String? area;

  static String? os;

  static String? deffict;

  static String? factory;

  static String? model;

  static String? Location;

  static String? coordinates;

  static var photo;

  static TextEditingController? phone;

  static TextEditingController? name;

  static String? preferredTme;

  static TextEditingController? problemDescription = TextEditingController();
  static String? serviceType;

  static String? buildingType;
  static List<String> serviceSelection = [];
  static List<bool> selected = [];

  //0000000000000000000000000000000000000000000000000000000

  static String? typeSelection = 'هاتف محمول';

  static void FormReset() {
    id = null;
    area = null;
    os = null;
    deffict = null;
    factory = null;
    model = null;
    Location = null;
    coordinates = null;
    photo = null;
    phone = TextEditingController();
    name = TextEditingController();
    preferredTme = null;
    problemDescription = TextEditingController();
    serviceType = null;
    buildingType = null;
    serviceSelection = [];
    selected = [];
  }
}
