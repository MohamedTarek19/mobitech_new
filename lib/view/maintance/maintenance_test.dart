import 'package:flutter/material.dart';

class maintenance extends StatefulWidget {
  const maintenance({Key? key}) : super(key: key);

  @override
  _maintenanceState createState() => _maintenanceState();
}

class _maintenanceState extends State<maintenance> {
  var _model;
  String dropdownvalue = 'هاتف محمول';
  var items = [
  'هاتف محمول',
  'أجهزة كهربائية',
  'أعمال منزلية'
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF50B04F),
          automaticallyImplyLeading: false,
          title: const Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              'طلب صيانة اجهزة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          child: Container(
            width: 405.8,
            height: 324,
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: double.infinity,
              maxWidth: double.infinity,
              maxHeight: double.infinity,
            ),
            child: Stack(
              children: [
                Image.network(
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mobitech-37q8so/assets/l5iv6thbib7l/Rectangle_1.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        width: 100,
                        height: 157.9,
                        constraints: const BoxConstraints(
                          minWidth: double.infinity,
                          maxWidth: double.infinity,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                        alignment:
                        AlignmentDirectional(0, 0.050000000000000044),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text:
                                'علم قائم على درس نصّ كتابيّ وإيضاح معناه بحسب قواعد النقد العلميّ، وفقه اللغة والتقليد العقائديّ، وبيان ما هو غامض فيه أو ما هو مدعاة للجدل، نقيض المتن.',
                                style: TextStyle(),
                              )
                            ],
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.normal,),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(
                        width: 350,
                        child: Divider(
                          height: 50,
                          thickness: 1,
                          color: Color(0x5E64B24D),
                        ),
                      ),
                      Container(
                        width: 340.9,
                        height: 50.7,
                        //padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Color(0xFF50B04F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('إختر خدمة الصيانة', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 30,),
                        ),

                      ),
                      Divider(
                        height: 50,
                        thickness: 1,
                        color: Color(0x00EEEEEE),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          width: 340.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton(
                            underline: SizedBox(),
                            isExpanded: true,
                            value: dropdownvalue,
                            icon: const Icon(Icons.arrow_drop_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: SizedBox(
                                  width: 100.0, // for example
                                  child: Text(items, textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}