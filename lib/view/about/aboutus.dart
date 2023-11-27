import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

import '../../business_logic/view_model/maints_vm.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var x = MediaQuery.of(context).orientation;

    return MainContainer(
      widget: Scaffold(
        appBar: CustomAppBar("عن الشركة", context),
        body: Column(
          children: [
            x == Orientation.portrait
                ? const SizedBox(
                    height: 50,
                  )
                : Container(),
            Container(
                margin: AppTheme.marginall,
                child: Image.asset("assets/logo.png")),
            const SizedBox(
              height: 50,
            ),
            Container(
                margin: AppTheme.marginall,
                child: Text(
                  "متجر إصلاح هواتف الجوّال في مصر\ العنوان: 36 منية مطر، شجرة مريم، قسم المطرية، محافظة القاهرة، منية مطر، القاهرة، مصر",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                ))
          ],
        ),
      ),
    );
  }
}
