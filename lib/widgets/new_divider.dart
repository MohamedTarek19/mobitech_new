import 'package:flutter/material.dart';

class newDivider extends StatelessWidget {
  const newDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 15.0,bottom: 15),
      child: Divider(thickness: 2,height: 1,indent: 50,endIndent: 50,color: Colors.white,),
    );
  }
}