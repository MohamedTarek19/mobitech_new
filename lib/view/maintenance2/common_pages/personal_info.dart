import 'package:flutter/material.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/view/maintenance2/maintenance_helper.dart';
import 'package:mobitech/view/maintenance2/common_pages/problem_description.dart';
import 'package:provider/provider.dart';


class PersonalInfo extends StatelessWidget {
  PersonalInfo({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController Phone = TextEditingController();
  TextEditingController Name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FormHelper.phone = Phone;
    FormHelper.name = Name;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        appBar: AppBar(elevation: 5, title: Text("إملأ معلوماتك الشخصية", style: Theme.of(context).textTheme.headline2,),
          centerTitle: true,
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text('من فضلك سجل عن طريق إدخال رقم هاتفك داخل دولة مصر بدون إدخال رمز الدولة و إدخال الأرقام باللغة الإنجليزية',
                              style: TextStyle(fontSize: 14,color: Colors.white70),textAlign: TextAlign.right,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: TextFormField(
                                validator: (val){
                                  if(val == null || val.isEmpty){
                                    return "this field is empty";
                                  } else if( val.length > 11){
                                    return "your phone number is too large try to make it 11 numbers";
                                  }else if( val.length < 11){
                                    return "your phone number is too small try to make it 11 numbers";
                                  }else if (val[0] != '0' ||  val[1] != '1' || int.parse(val[2]) > 2){
                                    return "your phone number should start\n with 01 and the 3rd digit should be either 0,1,2";
                                  }else if(int.tryParse(val) == null){
                                    return "your phone number shouldn't contain alphabet";
                                  }
                                },
                                controller: FormHelper.phone,
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(top:14.0),
                                    child: Text('+20',style: TextStyle(color: Colors.grey[500]),),
                                  ),
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Phone Number (01xxxxxxxxxx)"
                                ),

                                style: const TextStyle(
                                ),


                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('إدخال إسمك بالكامل باللغة العربية',
                              style: TextStyle(fontSize: 14,color: Colors.white70),textAlign: TextAlign.start,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                textDirection: TextDirection.rtl,
                                validator: (val){
                                  if(val == null|| val.isEmpty == true){
                                    return "this field is empty";
                                  }else if(val.length <4){
                                    return "the name is too short";
                                  }
                                  bool? va;
                                  val.codeUnits.forEach((c) { if(c >= 0x0600 && c <= 0x06E0){ va = true; }});
                                  if(va == null){
                                    return "it's not in arabic";
                                  }

                                },
                                controller: FormHelper.name,
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.text_snippet_outlined),
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Enter your name"
                                ),
                                style: const TextStyle(

                                ),


                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.07),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          if(_formKey.currentState!.validate()){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return ProblemDescription();
                            }));
                          }


                          //print(int.tryParse('1232'));

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
      ),
    );
  }
}
