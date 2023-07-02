import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:http/http.dart' as http;
import 'package:mobitech/business_logic/model/work_orders_m.dart';
import 'package:mobitech/business_logic/view_model/work_orders_vm.dart';
import 'package:mobitech/view/notify/status_updater.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

const backgroundPeriodicTask = "simplePeriodicTask";
final FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel Androidnotify = AndroidNotificationChannel(
  "Coding is life",
  "testNotification",
  description: "this is the description",
  importance: Importance.high,
);


class NotificationModule{
  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    service.on("setAsForeground").listen((event) {
      print("Foreground=================");
    });
    service.on("setAsBackground").listen((event) {
      print("Background=================");
    });
    service.on("stopService").listen((event) {
      service.stopSelf();
    });
    //display notification

    WorkOrdersVM vm = WorkOrdersVM();
    Timer.periodic(Duration(seconds:10), (timer) async {
      print("Runnnnnnnnnnnnn");
      final sharedPreferences= SharedPreferences.getInstance();
      var _prefs =await sharedPreferences;
      _prefs.reload();
      //if(StatusUtils.inLanding == true) {
        await StatusUtils.SaveStatusList(vm, _prefs);
        await StatusUtils.getNewList(vm, _prefs);
        Map<int, String?> updatedStatus = {};
        updatedStatus = await StatusUtils.getUpdatedStatus(updatedStatus, _prefs);
        if (updatedStatus.isEmpty == false) {
          print("اخييييييييييييييييييييييييييرا");
          for (var u in updatedStatus.entries) {
            print("status new data in background: <${u.key} , ${u.value}>");
            flp.show(
                90, "تم تغيير حالة الطلب رقم(${u.key})", "الحالة: ${u.value}",
                const NotificationDetails(
                    android: AndroidNotificationDetails(
                      "Coding is life",
                      backgroundPeriodicTask,
                      priority: Priority.high,
                      importance: Importance.high,
                      showProgress: true,
                      ongoing: true,
                      icon: "logo",
                      color: Colors.black,
                      colorized: true,
                    )));
          }
          await StatusUtils.updateStatus(updatedStatus, _prefs);
        }
     // }

    });

  }
  @pragma('vm:entry-point')
  static Future<void> Initailize() async {
    var service = FlutterBackgroundService();
    await flp.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(Androidnotify);
    await service.configure(
        iosConfiguration: IosConfiguration(),
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          autoStart: true,
          isForegroundMode: true,
          notificationChannelId: "Coding is life",
          initialNotificationTitle: "run background Services....",
          initialNotificationContent: "Initialization....",
          foregroundServiceNotificationId: 90,
        ));
    service.startService();
  }


}