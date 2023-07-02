 import 'package:flutter/material.dart';
import 'package:mobitech/theme/appthrmr.dart';

class CustomFormField extends StatelessWidget {
 
  final TextEditingController controller;
  final IconData? iconData;
  final Widget? widgett;
  final bool Function(String?)? validator;
  final bool? isReadOnly;
  final int? maxlines;
   final TextInputType? inputType;
   final String? errorMessage;
final String? hint;
final VoidCallback? onTapp;
  const CustomFormField(
      {Key? key,
       this.validator,
      required this.controller,
       this.iconData,
      this.widgett,
      this.isReadOnly,
      this.maxlines,
       this.inputType,this.hint, this.errorMessage, this.onTapp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
       margin: AppTheme.marginall,
      child: TextFormField(
        textAlign: TextAlign.right,
    style: Theme.of(context).textTheme.headline4,
        keyboardType: inputType,
         readOnly: isReadOnly ?? false,
          validator: (v){
            if(validator==null){
            return null;
          }
            
            if( validator!(v)){
           return null;
           }
           else{
             return   errorMessage;
           }
         },
         onTap:onTapp,
        controller: controller,

        decoration: InputDecoration(

          hintText: hint,
          hintStyle: Theme.of(context).textTheme.headline4,
          enabledBorder:const  OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.mainColor),
          borderRadius:
          BorderRadius.all(Radius.circular(AppTheme.borderradius1))),
         // filled: true,
             suffixIcon:widgett?? Icon(iconData,color:AppTheme.mainColor,),
            // suffix: widgett,
           //fillColor: AppTheme.mainColor,
            focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.mainColor),
                borderRadius:
                    BorderRadius.all(Radius.circular(AppTheme.borderradius1))),
                    ),
      ),
    );
  }
}