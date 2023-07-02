import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobitech/apis/api_endpoints.dart';
import 'dart:io';
import 'package:mobitech/business_logic/model/work_orders_m.dart';

class WorkOrdersRep {
  Future<Object> AddReceipt(WorkOrdersM orderM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.workorders);

      var response = await http.post(url,
          body: orderM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 20) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<List<WorkOrdersM>?> getWorkOrders() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.workorders}");
      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>WorkOrdersM.fromJson(e)).toList();
        //print(d.length);
        return d;
      }
      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<List<WorkOrdersM>?> getWorkOrdersByCustId(int custid) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.typesubs}/$custid");
      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      try{
        var res = jsonDecode(response.body) as List;
        var d= res.map((e) => WorkOrdersM.fromJson(e)).toList();
        return d;
      }catch(e){
        print(e);
      }

      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
}
