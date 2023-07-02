import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/account_m.dart';
import 'package:mobitech/business_logic/usecase/validation.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/view/home/home.dart';
import 'package:mobitech/view/landing_page.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/custom_form-fild.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/password-form-field.dart';
import 'package:provider/provider.dart';

class Registeration extends StatefulWidget {
  const Registeration({Key? key}) : super(key: key);

  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController userName = TextEditingController();

  final formK = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _acountVm = Provider.of<AccountVM>(context, listen: false);
    return MainContainer(
      widget: Scaffold(
        body: SingleChildScrollView(
            child: Form(
          key: formK,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                  child: Text("Mobi-Tech",
                      style: Theme.of(context).textTheme.headline1)),
              const SizedBox(
                height: 80,
              ),
              CustomFormField(
                validator: Validator.isValidName,
                controller: userName,
                iconData: Icons.person,
                hint: "User Name",
                errorMessage: "InValid Input",
              ),
              CustomFormField(
                validator: Validator.isValidEmail,
                controller: email,
                iconData: Icons.email,
                hint: "Email",
                errorMessage: "InValid Input",
              ),
              CustomFormField(
                validator: Validator.isValidPhone,
                controller: phone,
                iconData: Icons.phone,
                hint: "Phone Number",
                errorMessage: "InValid Input",
              ),
              PasswordTextField(
                controller: password,
                hint: "Password",
                validator: Validator.isValidPassword,
                errorMessage: "InValid Input",
              ),
              PasswordTextField(
                controller: passwordConfirm,
                validator: Validator.isValidPassword,
                hint: "Confirm Password",
                errorMessage: "InValid Input",
              ),
              CustomBtn(
                  name: "Register",
                  action: () async {
                    if (formK.currentState!.validate()) {
                      if (Validator.isMatchPassword(
                          password.text, passwordConfirm.text)) {
                        try {
                          var statusCode = await _acountVm.CreateAccount(
                              AccountM(
                                  amail: email.text,
                                  pass: password.text,
                                  aname: userName.text,
                                  atel: phone.text,
                                  id: 0,
                                  aface: '',
                                  agoogle: ''));
                          if (statusCode == 201) {}
                          Navigation.puchNav(const LoginScreen(), context);
                        } catch (err) {
                          print(err);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            "Something err",
                          )));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "كلمة المرور غير متطابقة",
                          style: Theme.of(context).textTheme.headline4,
                        )));
                      }
                    }
                  }),

              ///Social Login
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
