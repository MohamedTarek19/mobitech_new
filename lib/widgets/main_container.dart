import 'package:flutter/material.dart';
import 'package:mobitech/theme/appthrmr.dart';

class MainContainer extends StatelessWidget {
  final Widget widget;
  final EdgeInsets? padding;
  const MainContainer({Key? key, required this.widget,this.padding}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
     // height: double.infinity,
      decoration: const BoxDecoration(
          gradient:AppTheme.mainGradient
),
      child: widget,
    );
  }
}
