import 'package:flutter/material.dart';

import '../theme/appthrmr.dart';
class ServiceWidget extends StatelessWidget {
  final String imahePath;
  final String name;
  final VoidCallback? action;
  const ServiceWidget({
    Key? key,
    required this.imahePath,
    required this.name,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: action,
        child: Container(
          margin: AppTheme.marginall,
          padding: AppTheme.paddingall,
          // height: 150,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.borderradiu3),
              border: Border.all(color: AppTheme.mainColor, width: 1.5)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              imahePath,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 9),
            Text(
              name,
              style: Theme.of(context).textTheme.headline4,
              overflow: TextOverflow.ellipsis,
            )
          ]),
        ),
      ),
    );
  }
}
