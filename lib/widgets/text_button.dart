import 'package:flutter/material.dart';
class TextBtn extends StatelessWidget {
  final String text;
  final VoidCallback action;

   const  TextBtn({Key? key, required this.text, required this.action, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return  TextButton(onPressed: action, child: Text(text,style: 
   Theme.of(context).textTheme.headline2));

    
  }
}