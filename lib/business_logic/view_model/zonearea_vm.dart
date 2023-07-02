import 'package:flutter/cupertino.dart';
import 'package:mobitech/business_logic/model/typesubs_m.dart';
import 'package:mobitech/business_logic/model/zonearea_m.dart';
import 'package:mobitech/data_layer/typesubs/typesubs.dart';
import 'package:mobitech/data_layer/zone_area/zonearea.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;


class ZoneAreaVm extends ChangeNotifier{

  List<ZoneAreaM>? zoneArea;
  final ZoneAreaRep _zonearea = ZoneAreaRep();

  Future<void> getZoneArea() async {
    zoneArea = await _zonearea.getZoneArea();
    notifyListeners();
  }


}