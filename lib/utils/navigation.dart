import 'package:flutter/material.dart';

class Navigation{
  static puchNav(Widget pageName, BuildContext context) async {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return pageName;
    });
    await Navigator.push(context, route);
  }

  static puchReplace(Widget pageName, BuildContext context) async {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return pageName;
    });

    await Navigator.pushReplacement(context, route);
  }

  static puchReplaceAllUntil(
      Widget pageName, BuildContext context, Route<dynamic>? except) async {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return pageName;
    });

    await Navigator.pushAndRemoveUntil(context, route, (v) {
      if (except != null&& v==route) {


        return true;
      } else {
        //this mean delete all previe route if no except is assigned
        return false;
      }
    });
  }
}