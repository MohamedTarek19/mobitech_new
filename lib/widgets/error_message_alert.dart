import 'package:flutter/material.dart';

alert(String field,BuildContext context){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      icon: Icon(Icons.dangerous,size: 55,),
      iconColor: Colors.red,
      title: Text('الرجاء إدخال ${field}',style: TextStyle(color: Colors.black,fontSize: 17),textDirection: TextDirection.rtl,),
      actions: [
        ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text('حسنا'))
      ],
    );
  });
}