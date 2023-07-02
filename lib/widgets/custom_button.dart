import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobitech/theme/appthrmr.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({Key? key, required this.name, required this.action}) : super(key: key);
  final String name;
  final VoidCallback   action;
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: AppTheme.marginall,
  
      child: MaterialButton(onPressed:  
        
        action
     ,
      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(AppTheme.borderradius1)),
      
      color: AppTheme.mainColor
      ,
      child: Padding(
        padding:     AppTheme.paddingall.copyWith(top: 8,bottom: 8),
        child: Text(name,style: Theme.of(context).textTheme.headline3!.copyWith(color: AppTheme.secondColor,)),
      )),


      ),
    );
    
  }
}