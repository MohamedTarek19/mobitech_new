import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class FormInfo{
  static String? region;
  static String? os;
  static String? defict_type;
  static String? factory;
  static String? model;//
  // basic form
  static LatLng? location;
  static var photo_url;
  static String? description;
  static String? prefered_time;
  static String? phone_number;//
  static String? Name;
  static DateTime? visitdate;
  static List<dynamic> listOfServices = [];
  static List<bool> checkedValue=[];
  static String? buildingInfo;

  static bool isNull(){
    if(photo_url == null) {
      return false;
    }
    return true;
  }
  static void reset(){
    region = null;
    os = null;
    defict_type =null;
    factory = null;
    model = null;
    location = null;
    description = null;
    prefered_time = null;
    phone_number = null;
    Name=null;
    photo_url = null;
    listOfServices = [];
    checkedValue=[];
    visitdate = null;
    buildingInfo = null;
  }
  static String ListOSToString(){
    String builder = '';
   for(var l in listOfServices){
     builder+= '${l},';
   }
   print('###############[$builder]#################');
   return builder;
  }
  static Map<String,bool>? firstPageValidate(int option){
    Map<String,bool> listOfValid = {};
    listOfValid["المنطقة"] = region == null? false:true;
    if(option == 1){
      listOfValid["نظام التشغيل"] = os == null? false:true;
      listOfValid["نوع العطل"] = defict_type == null? false:true;
      listOfValid["الشركة المصنعة"] = factory == null? false:true;
      listOfValid["الموديل"] = model == null? false:true;
    }else if (option == 2){
      listOfValid["الشركة المصنعة"] = factory == null? false:true;
      listOfValid["الموديل"] = model == null? false:true;
    }else{
      listOfValid["نوع الخدمة"] = listOfServices.isEmpty == true? false:true;
      listOfValid["نوع الوحدة السكنية"] = buildingInfo == null? false:true;
    }
    return listOfValid;
  }

  static Map<String,bool>? locationPageValidate(){
    Map<String,bool> listOfValid = {};
    listOfValid["الموقع"] = location == null? false:true;
    return listOfValid;
  }
  static Map<String,bool>? descPageValidate(){
    Map<String,bool> listOfValid = {};
    listOfValid["وقت التنفيذ المناسب"] = prefered_time == null? false:true;
    listOfValid["وصف المشكلة"] = description == ''? false:true;
    return listOfValid;
  }
  static Map<String,bool>? personalPageValidate(){
    Map<String,bool> listOfValid = {};
    listOfValid["رقم هاتفك"] = phone_number == ''? false:true;
    listOfValid["إسمك"] = Name == ''? false:true;
    return listOfValid;
  }


}