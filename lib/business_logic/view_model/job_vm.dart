import 'package:flutter/cupertino.dart';
import 'package:mobitech/business_logic/model/jobsub_m.dart';
import 'package:mobitech/business_logic/model/jobtitle_m.dart';
import 'package:mobitech/data_layer/job/jobs.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;

class JobVM extends ChangeNotifier {
  List<JobTitle>? jopTitls;
  List<JobTitle>? filtredJobs;
  String?  searchValue;

  final JopRep _jopRep = JopRep();
  getFiltredJobs(List<JobTitle>? jopTitls, String filterText) {
    if(filterText.length==0){
      filtredJobs=[];
    }
    else {
      filtredJobs =
        jopTitls?.where((e) => e.jname!.trim().contains(filterText)).toList();
    }
    notifyListeners();
  }

  Future<void> getJobTitles() async {
    jopTitls = await _jopRep.getJobTitles();
    notifyListeners();
  }
   Future<List<JobSubject>?> getJobsByName(String name) async {
   var res = await _jopRep.getJobsByName(name);
    return res;
  }

  Future<dynamic> createJobRep(JobSubject jobSubject) async {
    var v = await _jopRep.createJobRep(jobSubject);

    return v;
  }
}
