 import 'package:flutter/material.dart';
 
 AppBar CustomAbbBar( String title,BuildContext context) 

  {
    
    return  AppBar(
        elevation: 0,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
      );
  }
  
 