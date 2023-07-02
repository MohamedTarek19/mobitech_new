import 'package:mobitech/business_logic/model/work_orders_m.dart';
import 'package:mobitech/business_logic/view_model/work_orders_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusUtils{
  static Map<int,String> status={};
  static List<String> StatusId = [];
  static Map<int,String> newStatusList = {};
  static bool inLanding = false;

  //save status and it's id in file
  static Future<void> SaveStatusList(WorkOrdersVM workorders_vm,SharedPreferences prefs) async {
    //await prefs.clear();
    StatusId.clear();
    await prefs.reload();
    print("###############[in status saver]###############################");
    List<WorkOrdersM> data = [];
    var CustId = await prefs.getString('Userid').toString();
    data  = await workorders_vm.getWorkOrders()??[];
    print(data);
    for(var d in data){
      if(d.custid == CustId){
        print("###############[customer id = $CustId]###############################");
        if(prefs.containsKey(d.id.toString()) != true){
          print("###############[${d.id}// ${d.st}]###############################");
          await prefs.setString(d.id.toString(), d.st.toString());
        }
        if(StatusId.contains(d.id.toString()) != true){
          print("###############[تم]###############################");
          StatusId.add(d.id.toString());
        }
      }
    }
    prefs.setStringList(CustId, StatusId);
  }
  //saves one status in file
  static Future<void> SaveNewStatus(SharedPreferences prefs,WorkOrdersVM workorders_vm) async {
    await prefs.reload();

    List<WorkOrdersM> data = [];
    var CustId = await prefs.getString('Userid').toString();
    data  =await workorders_vm.getWorkOrders()??[];
    await prefs.setString(data.last.id.toString(), data.last.st.toString());
    StatusId.add(data.last.id.toString());
    prefs.setStringList(CustId, StatusId);
    print("###############${data.last.id} and ${data.last.st}#####################");
  }
  //get the newely updated list from api
  static getNewList(WorkOrdersVM workorders_vm,SharedPreferences prefs) async{
    await prefs.reload();
    newStatusList.clear();
    List<WorkOrdersM> newData = [];
    newData  = await workorders_vm.getWorkOrders()??[];
    var CustId = await prefs.getString('Userid').toString();
    for(var d in newData){
      if(d.custid == CustId){
        print("#################[${d.id} , ${d.st}]#####################");
        newStatusList[int.parse(d.id.toString())] = d.st.toString();
      }

    }
  }
  //Load status and it's id in map<int,string> called Status
  static Future<void> LoadStatus(SharedPreferences prefs) async{
    status.clear();
    await prefs.reload();
    var CustId = await prefs.getString('Userid').toString();
    var Ids = await prefs.getStringList(CustId)??[];
    print('in load status ids length =  ${Ids.length}');
    for(var l in Ids){
      if(status.containsKey(int.parse(l)) == false){
        status[int.parse(l)] = await prefs.getString(l).toString();
        print("status old data : <${l} , ${status[int.parse(l)]}>");
      }
    }
    print("status map length = ${status.length}");
  }
  //update status in file
  static Future<void> updateStatus(Map<int,String?> updatedStatus,SharedPreferences prefs)async{
    await prefs.reload();

    for(var u in updatedStatus.entries){
      await prefs.setString(u.key.toString(), u.value.toString());
    }
  }
  // get the updated status list and compare it with the old one then update it in file
  static Future<Map<int, String?>> getUpdatedStatus(Map<int,String?> updatedStatus,SharedPreferences prefs) async{
    updatedStatus.clear();
    print("in getUpdatedStatus");
    await LoadStatus(prefs);
    for(var st in status.entries){
      if(newStatusList[st.key] != st.value){
        print("status old data : <${st.key} , ${st.value}>");
        updatedStatus[st.key] = newStatusList[st.key];
        print("status new data :<${st.key} , ${newStatusList[st.key]}>");
      }
    }
    await updateStatus(updatedStatus, prefs);
    return updatedStatus;


  }
}