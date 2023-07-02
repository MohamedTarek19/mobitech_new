import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:http/http.dart' as http;
import 'package:mobitech/business_logic/model/work_orders_m.dart';
import 'dart:convert';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const backgroundPeriodicTask = "simplePeriodicTask";
final FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel Androidnotify = AndroidNotificationChannel(
  "Coding is life",
  "testNotification",
  description: "this is the description",
  importance: Importance.high,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initailize();
  runApp(const MyApp());
}
List<WorkOrdersM> x = [];

//onstart function
@pragma("vm:enry-point")
void OnStart(ServiceInstance service) {
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
  Timer.periodic(Duration(seconds:5), (timer) async {
    var _prefs =await SharedPreferences.getInstance();
    print(x[1].st??'');
    print(timer.tick);
    flp.show(90, "خصم 20%", "الحالة ${x[1].st}", const NotificationDetails(
            android: AndroidNotificationDetails(
              "Coding is life",
              "testNotification",
              priority: Priority.high,
              importance: Importance.high,
              showProgress: true,
              ongoing: true,
              icon: "logo",
              color: Colors.black,
              colorized: true,
            )));
  });

}

Future<void> Initailize() async {
  var service = FlutterBackgroundService();
  await flp.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(Androidnotify);
  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: OnStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: "Coding is life",
        initialNotificationTitle: "Coding is life",
        initialNotificationContent: "Awesome coding",
        foregroundServiceNotificationId: 90,
      ));
  service.startService();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController seconds = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: seconds,
            ),
            Text(
              '0',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var service = FlutterBackgroundService();
          service.invoke("setAsBackground");

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
