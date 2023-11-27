import 'package:flutter/material.dart';

ConfirmAlert(String field,BuildContext context){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      icon: Icon(Icons.check,size: 55,),
      iconColor: Colors.green,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('تم إنشاء طلبك بنجاح!',style: TextStyle(color: Colors.black,fontSize: 17),textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
          Text('رقم الطلب الخاص بك : ${field}',style: TextStyle(color: Colors.black,fontSize: 17),textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
        ],
      ),
      actions: [
        ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text('حسنا'))
      ],
    );
  });
}