 
import 'dart:io';
 

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobitech/business_logic/model/empin_m.dart';
import 'package:mobitech/data_layer/employee/emp_rep.dart';
import 'package:mobitech/widgets/text_button.dart';
class EmpVm extends ChangeNotifier {
final  EmpRep _empRep=EmpRep();
  static LocalAuthentication auth = LocalAuthentication();

  Future<bool> userFingerPrint(BuildContext context) async {
    var alert = AlertDialog(
      title: Text("Not Supported"),
      content: Text("your device dont Support Fingerprint!"),
      actions: [
        TextBtn(
            text: "Close",
            action: () {
              Navigator.pop(context);
            })
      ],
    );
    var authRes = false;
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      
      authRes = await auth.authenticate(localizedReason: "auth",options: AuthenticationOptions(biometricOnly: true) );
    } else {
      showDialog(context: context, builder: (context) => alert);
    }

    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.iris)) {
        print("p");
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        print(availableBiometrics);
      }
    }

    return authRes;
  }
  //////////////EmpIN
  Future<Object> empCheckIn(Empin empin)async{

 var res=await _empRep.empCheckIn(empin);
 return res;

  }
  
}
