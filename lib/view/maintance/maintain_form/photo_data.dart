import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobitech/business_logic/model/catsets_m.dart';
import 'package:mobitech/business_logic/view_model/categories_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/location_picker.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/defict_type.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobileCategory.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/operating_system.dart';
import 'package:mobitech/view/maintance/maintain_form/problem_description.dart';
import 'package:mobitech/view/maintance/maintain_form/regions.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

import 'personal_form.dart';

class PhotoDoc extends StatefulWidget {
  const PhotoDoc({Key? key}) : super(key: key);

  @override
  State<PhotoDoc> createState() => _PhotoDocState();
}

class _PhotoDocState extends State<PhotoDoc> {
  String? value;
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
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
      if (image == null) return;
      final imageTemp = File(image.path);
      print(imageTemp);
      setState((){ _Image = imageTemp;
      FormInfo.photo_url = _Image;
      });
      print(FormInfo.photo_url);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('املأ الطلب'),
          ),
          body: MainContainer(
            padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
            widget: SingleChildScrollView(
              child: SizedBox(
                height: Height * 0.88,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 9, 5, 14),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "أضف صورة للمشكلة (إختياري)",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    textAlign: TextAlign.right,
                                  ),
                                  Text(
                                    "أضف صورة للمشكلة حتى يسهل تحديد و فهم المشكلة",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white70),
                                    textAlign: TextAlign.right,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ListTile(
                                  onTap: () {
                                    pickImage();
                                    //Navigation.puchNav(Regions(), context);
                                  },
                                  title: Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                  tileColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            )
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 200,
                      child: _Image != null
                          ? Image.file(
                              _Image,
                              width: 200,
                              height: 200,
                              fit: BoxFit.fitWidth,
                            )
                          : Container(),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                          onTap: () {
                            Navigation.puchNav(ProblemDescription(), context);
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "التالي",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                              Icon(Icons.arrow_circle_left_sharp),
                            ],
                          ),
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
