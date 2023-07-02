import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobitech/business_logic/model/account_m.dart';
import 'package:mobitech/business_logic/usecase/validation.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/view/home/home.dart';
import 'package:mobitech/view/landing_page.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/custom_form-fild.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/password-form-field.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class InHomeData extends StatefulWidget {
  const InHomeData({Key? key}) : super(key: key);

  @override
  State<InHomeData> createState() => _InHomeDataState();
}

class _InHomeDataState extends State<InHomeData> {
  TextEditingController description = TextEditingController();
  TextEditingController mobileType = TextEditingController();
  TextEditingController mobileName = TextEditingController();
  var sampleItems = <String>['sample 1', 'sample 2', 'sample 3'];
  final formK = GlobalKey<FormState>();
  var dropdownvalue = 'sample 1';
  var _Image;
  var imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }
  Future pickImage() async {
    try {
      print('img2');
      final image = await ImagePicker().pickImage(source: ImageSource.camera,preferredCameraDevice: CameraDevice.rear);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() =>_Image = imageTemp);
      print(_Image);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      widget: Scaffold(
        appBar: CustomAbbBar("إدخال بيانات الأعمال المنزلية", context),
        body: SingleChildScrollView(
            child: Form(
          key: formK,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              // const SizedBox(
              //   height: 80,
              // ),

              const SizedBox(
                height: 80,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
                      child: const Text(
                        'إختر نوع الخدمة المنزلية',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ))),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  width: 310.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    underline: SizedBox(),
                    isExpanded: true,
                    value: dropdownvalue,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: sampleItems.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: SizedBox(
                          width: 100.0, // for example
                          child: Text(items, textAlign: TextAlign.center),
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (BuildContext context) {
                      return sampleItems.map((String value) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Text(dropdownvalue),
                        );
                      }).toList();
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: CustomFormField(
                  validator: Validator.isValidName,
                  controller: description,
                  iconData: Icons.report_problem,
                  hint: "وصف المشكلة",
                  errorMessage: "خطأ في الإدخال",
                ),
              ),
              Container(
                //  width: double.infinity,
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                width: 100,
                color: AppTheme.mainColor,
                height: 3,
                padding: AppTheme.marginall,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                    color: Colors.teal,
                    child: const Text(
                        "إدخل صورة للمشكلة(إختياري)",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold
                        )
                    ),
                    onPressed: () {
                      pickImage();
                      print('img');

                    }
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 150,
                height: 130,

                child: _Image != null ? Image.file(_Image, width: 150.0, height: 150.0, fit: BoxFit.fitWidth,)
                    : Container(
                  // decoration: BoxDecoration(
                  //     color: Colors.red[200]),
                  // width: 200,
                  // height: 200,
                  // child: Icon(Icons.camera_alt, color: Colors.grey[800],),
                ),
              ),
              CustomBtn(
                  name: "التالي",
                  action: () async {
                    if (formK.currentState!.validate()) {
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "الرجاء إكمال بياناتك",
                        style: Theme.of(context).textTheme.headline4,
                      )));
                    }
                  }),

              ///Social Login
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
