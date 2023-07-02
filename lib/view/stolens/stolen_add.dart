import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/jobsub_m.dart';
import 'package:mobitech/business_logic/model/losts_m.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:mobitech/business_logic/view_model/job_vm.dart';
import 'package:mobitech/business_logic/view_model/losts_vm.dart';
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

class StolenAdd extends StatefulWidget {
  const StolenAdd({Key? key}) : super(key: key);

  @override
  State<StolenAdd> createState() => _StolenAddState();
}

class _StolenAddState extends State<StolenAdd> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController gname = TextEditingController();
  TextEditingController gmodel = TextEditingController();
  TextEditingController gserial = TextEditingController();
  TextEditingController jobname = TextEditingController();

  JobVM? jobsVm;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (mounted) {}
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  String? dorpbtnv;
  @override
  Widget build(BuildContext context) {
    final lostVm = Provider.of<LostVM>(context, listen: false);
    print("Sd");
    print("Sds");

    final formK = GlobalKey<FormState>();
    return MainContainer(
        widget: Scaffold(
      appBar: CustomAbbBar( "تبليغ عن جهاز مفقود", context),
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
                  "تبليغ عن جهاز مفقود",
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
                controller: gname,
                iconData: Icons.mobile_friendly,
                hint: "الاسم",
                errorMessage: "InValid name",
                inputType: TextInputType.name,
              ),
              CustomFormField(
                validator: Validator.isValidName,
                controller: gmodel,
                iconData: Icons.type_specimen,
                hint: "الموديل",
                errorMessage: "InValid name",
                inputType: TextInputType.name,
              ),
              CustomFormField(
                validator: Validator.isValidName,
                controller: gserial,
                iconData: Icons.numbers,
                hint: "السريال",
                errorMessage: "InValid name",
                inputType: TextInputType.name,
              ),
              CustomFormField(
                validator: Validator.isValidPhone,
                controller: phone,
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
              CustomBtn(
                  name: "تبليغ",
                  action: () async {
                    print(date.text);
                    if (formK.currentState!.validate()) {
                      try {
                        var statusCode = await lostVm.lostReport(LostsM(
                          id: 0,
                          gdate: date.text,
                          gmodel: gmodel.text,
                          gname: gname.text,
                          aname: Provider.of<AccountVM>(context, listen: false)
                              .userDetails,
                          gserial: gserial.text,
                          gtel: phone.text,
                          st: 0,
                        ));
                        if (statusCode == 201) {
                          if (!mounted) {
                            return;
                          }
                          CSnackBar.showSnackBar(
                              context, "تم انشاء الطلب بنجاح");
                        }
                      } catch (err) {
                        print(err.toString());
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
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
