import 'package:flutter/material.dart';
import '../theme/appthrmr.dart';

class PasswordTextField extends StatefulWidget {
 
  final TextEditingController controller;
  final IconData? iconData;
  final bool Function(String?)? validator;
  final String? hint;
final String? errorMessage;
  const PasswordTextField(
      {Key? key,
      required this.controller,
      this.iconData,
         this.validator,this.hint, this.errorMessage})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isscrure = true;
  void ChangeVisibiltit() {
    setState(() {
      isscrure = !isscrure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: AppTheme.marginall,
      child: TextFormField(

      style: Theme.of(context).textTheme.headline4,
        obscureText: isscrure,
        validator: (v){
          if(widget.validator==null){
            return null;
          }
            
            if( widget.validator!(v)){
           return null;
           }
           else{
             return widget.errorMessage;
           }
         },
        controller: widget.controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText:  widget.hint,
           hintStyle: Theme.of(context).textTheme.headline4,

            suffixIcon: IconButton(
              focusColor: AppTheme.iconColor,
              onPressed: ChangeVisibiltit,
              icon: Icon(
                isscrure ? Icons.visibility_off : Icons.visibility,
                semanticLabel: "ds", color: AppTheme.iconColor,
                // color: AppTheme.iconColor,
              ),
            ),
            //suffixIcon: Icon(widget.iconData,color: AppTheme.mainColor,),
             filled: true,
            enabledBorder:const  OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.mainColor),
                borderRadius:
                    BorderRadius.all(Radius.circular(AppTheme.borderradius1))),
            focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.mainColor),
                borderRadius:
                    BorderRadius.all(Radius.circular(AppTheme.borderradius1)))),
      ),
    );
  }
}