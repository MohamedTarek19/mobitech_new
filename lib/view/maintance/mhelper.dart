import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MHelper{

  static String dropdownvalueMaint ='هاتف محمول';
  static String dropdownvalueEH ='غسالة';
  static String dropdownvalueIH ='سباكة';
  static bool isInMaintenance = false;
  static String typeset = '';
  static String typesub = '';
  static bool isInEmp = false;
  static LatLng? location;

  static void setDropValue(String val){
    dropdownvalueMaint = val;
  }
}