import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/jobtitle_m.dart';
import 'package:mobitech/business_logic/view_model/job_vm.dart';
import 'package:mobitech/business_logic/view_model/maints_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/jobs/job_search_res.dart';
import 'package:mobitech/view/maintance/mainance_details.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/snackbar.dart';
import 'package:provider/provider.dart';

import '../../business_logic/usecase/validation.dart';
import '../../widgets/custom_form-fild.dart';

class JobSearch extends StatefulWidget {
  const JobSearch({Key? key}) : super(key: key);

  @override
  State<JobSearch> createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> {
  TextEditingController jname = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<JobTitle>? jobs = [];

  @override
  Widget build(BuildContext context) {
    var job_Vm = Provider.of<JobVM>(context, listen: false);
    job_Vm.getJobTitles().then((value) {
      jobs = job_Vm.jopTitls;
    });

    jname.addListener(() {
      // if(jname.text.length) {
      job_Vm.getFiltredJobs(jobs, jname.text);
      // }

      print(1);
    });
    final formK = GlobalKey<FormState>();
    return MainContainer(
        widget: Scaffold(
      appBar: CustomAppBar("الوظائف", context),
      body: SingleChildScrollView(
        child: Form(
          key: formK,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: AppTheme.marginall,
                padding: AppTheme.paddingall,
                decoration: const BoxDecoration(
                    color: AppTheme.mainColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppTheme.borderradiu2))),
                child: Center(
                    child: Text(
                  "بحث عن الوظائف المتاحة",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.green),
                )),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomFormField(
                validator: Validator.isValidName,
                controller: jname,
                iconData: Icons.title,
                hint: "بحث",
                errorMessage: "InValid Title",
                inputType: TextInputType.text,
              ),
              Consumer<JobVM>(builder: ((context, value, child) {
                if (job_Vm.filtredJobs == null) {
                  return Container();
                }
                return SizedBox(
                  height: 200,
                  child: ListView(
                    children: value.filtredJobs!.map((e) {
                      return InkWell(
                        onTap: () {
                          job_Vm.searchValue = e.jname;
                          Navigation.puchNav(JobSearchResult(), context);
                        },
                        child: Container(
                          margin:
                              AppTheme.marginall.copyWith(top: 0, bottom: 0),
                          padding: AppTheme.paddingall,
                          decoration: const BoxDecoration(
                              color: AppTheme.mainColor,
                              border: Border(
                                  top:
                                      BorderSide(color: AppTheme.secondColor))),
                          child: Text(e.jname!),
                        ),
                      );
                    }).toList(),
                  ),
                );
              })),
              // CustomBtn(
              //     name: "بحث",
              //     action: () async {
              //       if (formK.currentState!.validate()) {
              //         //   await maints_Vm.getMaintsById(int.parse(mid.text));
              //         //   if (maints_Vm.maintsM == null) {
              //         //     if (!mounted) {
              //         //       return;
              //         //     }
              //         //     CSnackBar.showSnackBar(
              //         //         context, "لا توجد صيانة لهاذا السجل");
              //         //     return;
              //         //   } else {
              //         //     if (!mounted) {
              //         //       return;
              //         //     }
              //         //     Navigation.puchNav(const MaintSearchResult(), context);
              //         //   }
              //       }
              //     })
            ],
          ),
        ),
      ),
    ));
  }
}
