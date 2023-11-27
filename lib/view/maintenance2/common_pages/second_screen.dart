import 'package:flutter/material.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/view/maintenance2/common_pages/location_picker.dart';

import '../../../widgets/FormTile.dart';
import '../../../widgets/cuttom_appbar.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(elevation: 5, title: Text("إملأ الطلب", style: Theme.of(context).textTheme.headline2,),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.black,
              boxShadow: [
                BoxShadow(color: Colors.black,blurRadius: 14.0,spreadRadius: 0.5,offset: Offset(0.7, 0.7))
              ]
          ),
          child:Column(
            children: [
              Expanded(
                child: googleMaps(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


