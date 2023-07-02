import 'package:flutter/cupertino.dart';
import 'package:mobitech/business_logic/model/losts_m.dart';
import 'package:mobitech/data_layer/stolen/stole_rep.dart';
import 'package:mobitech/view/stolens/stolen_search.dart';

class LostVM extends ChangeNotifier
{

LostsM? lostsM;
StolenRep stolenRep=StolenRep();
Future <Object> lostReport(LostsM lostM)async{
var res=stolenRep.lostReport(lostM);
return res;

}
Future <void> losttSearchBySerial(String lostM)async{
var res=await stolenRep.losttSearchBySerial(lostM);
 lostsM=res;
 notifyListeners();

}

}