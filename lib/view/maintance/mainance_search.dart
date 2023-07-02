import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/view_model/maints_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/maintance/mainance_details.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/cuttom_appbar.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/snackbar.dart';
import 'package:provider/provider.dart';

import '../../business_logic/usecase/validation.dart';
import '../../widgets/custom_form-fild.dart';

class MaintanceSearch extends StatefulWidget {
  const MaintanceSearch({Key? key}) : super(key: key);

  @override
  State<MaintanceSearch> createState() => _MaintanceSearchState();
}

class _MaintanceSearchState extends State<MaintanceSearch> {
  @override
  Widget build(BuildContext context) {
    var maints_Vm = Provider.of<MaintsVM>(context);
    TextEditingController mid = TextEditingController();
    final formK = GlobalKey<FormState>();
    return MainContainer(
        widget: Scaffold(
      appBar: CustomAbbBar("إستعلام عن جهاز صيانة", context),
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
                "إستعلام عن جهاز صيانة",
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
              validator: Validator.isValidNumber,
              controller: mid,
              iconData: Icons.numbers,
              hint: "رقم السجل",
              errorMessage: "InValid number",
              inputType: TextInputType.number,
            ),
            CustomBtn(
                name: "بحث",
                action: () async {
                  if (formK.currentState!.validate()) {
                    await maints_Vm.getMaintsById(int.parse(mid.text));
                    if (maints_Vm.maintsM == null) {
                      if (!mounted) {
                        return;
                      }
                      CSnackBar.showSnackBar(
                          context, "لا توجد صيانة لهاذا السجل");
                      return;
                    } else {
                      if (!mounted) {
                        return;
                      }
                      Navigation.puchNav(const MaintSearchResult(), context);
                    }
                  }
                })
          ],
        ),
      ),
    ));
  }
}
