import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/catsets_m.dart';
import 'package:mobitech/business_logic/view_model/categories_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/maintain_form/home_electronics_form/electronic_form.dart';
import 'package:mobitech/view/maintance/maintain_form/in_home_form/in_home_form.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/form_info.dart';
import 'package:mobitech/view/maintance/maintain_form/mobile_form/mobile_form.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

class ServiceType extends StatefulWidget {
  const ServiceType({Key? key}) : super(key: key);

  @override
  State<ServiceType> createState() => _ServiceTypeState();
}

class _ServiceTypeState extends State<ServiceType> {
  String? value;
  List<CatsetsM>? txtList;

  // @override
  // void initState() {
  //   super.initState();
  //
  // }

  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    var Cat_vm = Provider.of<CategoriesVm>(context, listen: false);
    txtList = Cat_vm.MainCategories;
    if(FormInfo.checkedValue.isEmpty == true){
      FormInfo.checkedValue = List<bool>.filled(txtList!.length, false);
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('إختر نوع الخدمة'),
          actions: [
            IconButton(onPressed: (){
              Navigation.puchReplace(InHomeForm(), context);
            }, icon: Icon(Icons.arrow_forward_ios))
          ],
        ),
        body: MainContainer(
          widget: Column(
            children: [
              Container(
                height: Height*0.76,
                child: ListView.builder(
                    itemCount: txtList!.length,
                    itemBuilder: (context, index) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.end, children: [
                           CheckboxListTile(
                            title: Text(txtList![index].catname??''),
                            value: FormInfo.checkedValue[index],
                            onChanged: (Val) {
                              setState(() {
                                print(Val);
                                FormInfo.checkedValue[index] = Val!;
                                if(Val == true){
                                  if(FormInfo.listOfServices.contains(txtList![index].catname) != true){
                                    print(FormInfo.listOfServices);
                                    FormInfo.listOfServices.add(txtList![index].catname);
                                  }
                                }else if(Val == false){
                                  FormInfo.listOfServices.remove(txtList![index].catname);
                                }
                              });
                              print(FormInfo.listOfServices);
                            },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                      ]);
                    }),
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
                    onTap: (){
                      print(FormInfo.listOfServices);
                      Navigation.puchReplace(InHomeForm(), context);
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("التالي", style: TextStyle(color: Colors.black, fontSize: 13),),
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
    );
  }
}
