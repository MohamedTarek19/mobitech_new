import 'package:flutter/material.dart';

class reviewItem extends StatelessWidget{

  String title;
  String value;
  reviewItem({
    super.key,
    required this.title,
    required this.value

  });



  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: TextStyle(fontSize: 17,color: Colors.white),textAlign: TextAlign.right,),
        Text(value, style: const TextStyle(fontSize: 16,color: Colors.white70),textAlign: TextAlign.right,),
      ],
    );



  }



}