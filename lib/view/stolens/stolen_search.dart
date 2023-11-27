import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/view_model/losts_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/mainance_details.dart';
import 'package:mobitech/view/stolens/stolen_search_res.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/snackbar.dart';
import 'package:provider/provider.dart';

import '../../business_logic/usecase/validation.dart';
import '../../widgets/custom_form-fild.dart';

class LostSearch extends StatefulWidget {
  const LostSearch({Key? key}) : super(key: key);

  @override
  State<LostSearch> createState() => _LostSearchState();
}

class _LostSearchState extends State<LostSearch> {
      TextEditingController mid = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("d");
    print("2");
    var lost_Vm = Provider.of<LostVM>(context,listen: false);
    final formK = GlobalKey<FormState>();
    return MainContainer(
        widget: Scaffold(
      appBar: CustomAppBar("بحث عن جهاز مسروق", context),
      body: Form(
        key: formK,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: AppTheme.marginall,
              padding: AppTheme.paddingall,
              decoration: const BoxDecoration(
                  color: AppTheme.mainColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppTheme.borderradiu2))),
              child: Center(
                  child: Text(
                "بحث عن جهاز مفقود",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.green),
              )),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomFormField(
              validator: Validator.isValidName,
              controller: mid,
              iconData: Icons.numbers,
              hint: "سيريال الجهاز",
              errorMessage: "InValid number",
              inputType: TextInputType.number,
            ),
            CustomBtn(
                name: "بحث",
                action: () async {
                  if (formK.currentState!.validate()) {
                    await lost_Vm.losttSearchBySerial( mid.text);
                    if (lost_Vm.lostsM == null) {
                      if (!mounted) {
                        return;
                      }
                      CSnackBar.showSnackBar(
                          context, "لا يوجد لهاذا السريال");
                      return;
                    } else {
                      if (!mounted) {
                        return;
                      }
                      print("Nav");
                       Navigation.puchNav(const LostSearchResult(), context);
                    }
                  }
                })
          ],
        ),
      ),
    ));
  }
}
