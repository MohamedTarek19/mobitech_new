import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintenance2/maintenance_helper.dart';
import 'package:mobitech/view/maintenance2/common_pages/personal_info.dart';
import 'package:provider/provider.dart';



class PhotoPicker extends StatelessWidget {
  PhotoPicker({Key? key}) : super(key: key);
  String? value;
  var _Image;
  var imagePicker;



  @override
  Widget build(BuildContext context) {
    imagePicker = new ImagePicker();
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              elevation: 5,
              title: Text("إلتقط صورة للمشكلة", style: Theme.of(context).textTheme.headline2,),
            ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: AppTheme.mainGradient,
            ),
            child:Column(
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    //color: Colors.blue,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text('أضف صورة للمشكلة (إختياري)',style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.right,),
                            const Text('أضف صورة للمشكلة حتى يسهل تحديد و فهم المشكلة',style: TextStyle(fontSize: 14,color: Colors.white70),textAlign: TextAlign.right,),

                            StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      minimumSize: Size(MediaQuery.of(context).size.width*0.9, MediaQuery.of(context).size.height*0.07),
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () async {
                                      try {
                                        print('img2');
                                        final image = await ImagePicker().pickImage(
                                            source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
                                        if (image == null) return;
                                        final imageTemp = File(image.path);
                                        setState((){ _Image = imageTemp;
                                        FormHelper.photo = _Image;
                                        });
                                      } on PlatformException catch (e) {
                                        print('Failed to pick image: $e');
                                      }
                                    },
                                    child: const Icon(Icons.add,size: 40,color:Color(0xff50B04F),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: InkWell(
                                      onTap:(){
                                        if(_Image !=null || FormHelper.photo != null){
                                          showDialog(context: context, builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: InteractiveViewer(
                                                  panEnabled: true, // Set it to false
                                                  boundaryMargin: EdgeInsets.all(100),
                                                  minScale: 0.5,
                                                  maxScale: 3,
                                                  child: Image.file(FormHelper.photo)),
                                              actions: [
                                                ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(25))
                                                      ,
                                                    ),
                                                    onPressed: (){Navigator.pop(context);},
                                                    child: Text("حسنا")),
                                                ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.red,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(25))
                                                      ,
                                                    ),
                                                    onPressed: (){
                                                      setState((){
                                                        _Image = null;
                                                        FormHelper.photo = null;
                                                      });
                                                      Navigator.pop(context);},
                                                    child: Text("حذف الصورة")),
                                              ],
                                            );
                                          });
                                        }

                                      },
                                      child: Material(
                                        color: Color.fromRGBO(0, 0, 0, 0.4),
                                        elevation:20,
                                        borderRadius:BorderRadius.circular(20),
                                        child: Container(
                                          height:MediaQuery.of(context).size.height*0.3,
                                          width:MediaQuery.of(context).size.width*0.7,
                                          decoration: BoxDecoration(
                                            color:Color.fromRGBO(255, 255, 255, 0.2),
                                            borderRadius: BorderRadius.circular(20),
                                            border:Border.all(color: Colors.black),
                                          ),
                                          child: FormHelper.photo == null? Padding(
                                            padding: const EdgeInsets.only(top: 50,bottom: 50,left: 100,right: 100),
                                            child: Image.asset("assets/NoImage.png",width: 100,height: 100,fit: BoxFit.fill,),
                                          ):
                                          ClipRRect(
                                            borderRadius:BorderRadius.circular(20),
                                            child: Image.file(FormHelper.photo,
                                            fit: BoxFit.fill,),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.07),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {

                            Navigation.puchNav(PersonalInfo(), context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("التالي",style: TextStyle(color: Color(0xff50B04F),fontSize: 20),),
                              Icon(Icons.arrow_circle_left_outlined,color: Color(0xff50B04F),size: 30,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                )
              ],
            ),
          ),
        )
    );
  }
}
