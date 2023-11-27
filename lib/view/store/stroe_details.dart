import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:provider/provider.dart';

import '../../business_logic/view_model/maints_vm.dart';

class StoreDetails extends StatelessWidget {
  const StoreDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var x=MediaQuery.of(context).orientation;

    return MainContainer(
      widget: Scaffold(
        appBar: CustomAppBar("المتاجر", context),
        body: Column(
           children: [
        x==Orientation.portrait?     const SizedBox(
              height: 50,
            ):Container(),
               Container(
              margin: AppTheme.marginall,
              padding: AppTheme.paddingall,
              decoration: const BoxDecoration(
                  color: AppTheme.mainColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppTheme.borderradiu2))),
              child: Center(
                  child: Text(
                "Oppo",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.green),
              )),
            ),
            Container(margin: AppTheme.marginall,child: Image.asset("assets/oppo-a17.jpg")),
             const SizedBox(
              height: 20,
            ),
            Card(
              margin: AppTheme.marginall,
              shape: Border.all(color: AppTheme.mainColor,width: 2),
              elevation: 0,
              color: Colors.transparent,
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                      "Oppo A17",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    ": الاسم",
                    style: Theme.of(context).textTheme.headline3,
                  )
                ],
              ),
              Container(height: 2,color: AppTheme.mainColor,margin: AppTheme.marginall,width: 200),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                     "6000جم",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    ": السعر",
                    style: Theme.of(context).textTheme.headline3,
                  )
                ],
              ),
                            Container(height: 2,color: AppTheme.mainColor,margin: AppTheme.marginall,width: 200),


            ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
