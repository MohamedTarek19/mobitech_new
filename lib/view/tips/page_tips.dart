import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../../business_logic/model/tips.dart';
import '../../widgets/text_button.dart';

class PageTips extends StatelessWidget {
  final Tips pageTips;
  const PageTips({Key? key, required this.pageTips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: Image.asset(pageTips.imagepath)),
      SizedBox(height: 30,),
      Text(
        pageTips.title,
        style: Theme.of(context).textTheme.headline2,
      ),
      Text(
        pageTips.description,
        style: Theme.of(context).textTheme.headline3,
        textAlign: TextAlign.justify,
      ),
    ]);
  }
}
