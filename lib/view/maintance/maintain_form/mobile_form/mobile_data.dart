import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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

class MobileData extends StatefulWidget {
  const MobileData({Key? key}) : super(key: key);

  @override
  State<MobileData> createState() => _MobileDataState();
}

class _MobileDataState extends State<MobileData> {
  TextEditingController description = TextEditingController();
  TextEditingController mobileType = TextEditingController();
  TextEditingController mobileName = TextEditingController();
  final formK = GlobalKey<FormState>();
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
        appBar: CustomAbbBar("إدخال بيانات هاتفك", context),
        body: SingleChildScrollView(
            child: Form(
              key: formK,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [

                  const SizedBox(
                    height: 80,
                  ),
                  CustomFormField(
                    validator: Validator.isValidName,
                    controller: mobileName,
                    iconData: Icons.mobile_friendly,
                    hint: "نوع هاتفك",
                    errorMessage: "خطأ في الإدخال",
                  ),
                  CustomFormField(
                    validator: Validator.isValidName,
                    controller: mobileType,
                    iconData: Icons.question_mark,
                    hint: "طراز هاتفك",
                    errorMessage: "خطأ في الإدخال",
                  ),
                  CustomFormField(
                    validator: Validator.isValidName,
                    controller: description,
                    iconData: Icons.report_problem,
                    hint: "وصف المشكلة",
                    errorMessage: "خطأ في الإدخال",
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
                              content: Text("الرجاء إكمال بياناتك", style: Theme.of(context).textTheme.headline4,)
                          )
                          );
                        }
                      }
                  ),

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