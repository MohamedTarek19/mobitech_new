import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/jobsub_m.dart';
import 'package:mobitech/business_logic/view_model/job_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/mainance_details.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/snackbar.dart';
import 'package:provider/provider.dart';

import '../../business_logic/usecase/validation.dart';
import '../../widgets/custom_form-fild.dart';

class JobRequest extends StatefulWidget {
  const JobRequest({Key? key}) : super(key: key);

  @override
  State<JobRequest> createState() => _JobRequestState();
}

class _JobRequestState extends State<JobRequest> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController jobname = TextEditingController();
  JobVM? jobsVm;
  @override
  void initState() {
          

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (mounted) {
jobsVm = Provider.of<JobVM>(context,listen: false);
 
          jobsVm!.getJobTitles().then((value) {

            dorpbtnv=jobsVm?.jopTitls?.first.jname;
          });
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
String? dorpbtnv;
  @override
  Widget build(BuildContext context) {
    print("Sd");
        print("Sds");

    final formK = GlobalKey<FormState>();
    return MainContainer(
        widget: Scaffold(
      appBar: CustomAbbBar("طلب وظيفة", context),
      body: Form(
        key: formK,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
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
                  "طلب وظيفة",
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
                controller: name,
                iconData: Icons.person,
                hint: "الاسم",
                errorMessage: "InValid name",
                inputType: TextInputType.name,
              ),
              CustomFormField(
                validator: Validator.isValidPhone,
                controller:phone,
                iconData: Icons.phone,
                hint: "الهاتف",
                errorMessage: "InValid phone number",
                inputType: TextInputType.phone,
              ),
              CustomFormField(
                isReadOnly: true,
            //    validator: Validator.isValidNumber,
                controller: date,
                iconData: Icons.date_range,
                hint: "التاريخ",
                errorMessage: "InValid name",
                inputType: TextInputType.datetime,
                onTapp: () async {
                  var dd = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      builder: (BuildContext context, s) {
//
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: AppTheme.secondColor, // <-- SEE HERE
                              onPrimary: AppTheme.mainColor, // <-- SEE HERE
                              onSurface: Colors.blueAccent, // <-- SEE HERE
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary:
                                    AppTheme.secondColor, // button text color
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: s!,
                          ),
                        );

                        //
                      });
                  setState(() {
                    date.text = "${dd!.month}/${dd.day}/${dd.year}";
                  });

                  print(date.text);
                },
              ),
             Consumer<JobVM>(builder:((context, value, child) {
print("hi from consumer");
               return Container(
                  margin: AppTheme.marginall,
                  padding:const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTheme.borderradius1),
                      border: Border.all(color: Colors.white, width: 1)),
                  child:  DropdownButton<String>(
                    dropdownColor: AppTheme.secondColor,

                    style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                    isExpanded: true,
                    underline: null,
                    alignment: Alignment.center,
                    elevation: 0,
                    // iconSize: 15,
                    icon:const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    value:dorpbtnv,
                    items: value.jopTitls != null
                        ? value.jopTitls
                            ?.map((e) => DropdownMenuItem<String>(
                                  child: Text(e.jname ?? '',),
                                  value: e.jname,
                      alignment: Alignment.centerRight,
                                ))
                            .toList()
                        : null,
                    onChanged: (v) {
                      jobname.text = v.toString();
                      setState(() {
                         dorpbtnv=v.toString();
                         dorpbtnv=dorpbtnv;
                         print(dorpbtnv);

                      });
                    },
                   // isDense: true,
                  ));
             }) ),
              CustomBtn(
                  name: "طلب",
                  action: () async {
                   
                    if (formK.currentState!.validate() ) {

     try {
                          var statusCode =
                              await jobsVm?.createJobRep(JobSubject(
                            aname: name.text,
                            atel: phone.text,
                            jname: dorpbtnv
                            
                          ));
                          if (statusCode == 201) {
                            if(!mounted){
                              return;
                            }
                           CSnackBar.showSnackBar(context, "تم انشاء الطلب بنجاح");
                          }
 
                        } catch (err) {
                                                    

                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                            "Something error!",
                          )));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "تحقق من البيانات المدخله!",
                          style: Theme.of(context).textTheme.headline4,
                        )));
                      


                      
                    }
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
